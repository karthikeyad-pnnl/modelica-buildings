import fmpy
from fmpy.fmi2 import FMU2Slave
import datetime
import shutil
import os
import tes_classes
import pandas as pd
import json
import requests
import sys

class Simulation():
    def __init__(self, fmu_name:str, start_date:str, stop_date:str, simulation_year:int, modelica_FMU_name:str = '', modelica_only:bool=False):
        self.delta_time = 60 # Do not change this value

        self.start_time = (datetime.datetime(year=simulation_year, month=int(start_date.split('/')[0]), day=int(start_date.split('/')[1])) - datetime.datetime(year=simulation_year, month=1, day=1)).total_seconds()
        self.stop_time = (datetime.datetime(year=simulation_year, month=int(stop_date.split('/')[0]), day=int(stop_date.split('/')[1])) - datetime.datetime(year=simulation_year, month=1, day=1)).total_seconds()    
        self.fmu_name = fmu_name
        self.reqd_charge_rate = 0
        self.modelica_only = modelica_only

        if not self.modelica_only:
            self.fmu_setup()
        if not modelica_FMU_name == '':
            self.modelica_fmu_setup(modelica_FMU_name, simulation_year)
            self.warm_up_modelica(simulation_year)
        self.current_time = self.start_time

    def fmu_setup(self):
        model_description = fmpy.read_model_description(self.fmu_name)

        self.vrs={}
        for variable in model_description.modelVariables:
            self.vrs[variable.name] = variable.valueReference

        self.fmu_extracted = fmpy.extract(self.fmu_name)

        self.fmu = FMU2Slave(guid=model_description.guid,
                        unzipDirectory=self.fmu_extracted,
                        modelIdentifier=model_description.coSimulation.modelIdentifier,
                        instanceName='eplus')

        self.fmu.instantiate()
        self.fmu.setupExperiment(startTime=self.start_time, stopTime=self.stop_time)
        self.fmu.enterInitializationMode()
        self.fmu.exitInitializationMode()

    def modelica_fmu_setup(self, modelica_fmu_name:str = '', simulation_year:int = 2023):
        self.modelica_start_time = (datetime.timedelta(seconds=self.start_time) - datetime.timedelta(days=1)).total_seconds()
        print(self.modelica_start_time)
        model_description = fmpy.read_model_description(modelica_fmu_name)

        self.modelica_vrs={}
        for variable in model_description.modelVariables:
            self.modelica_vrs[variable.name] = variable.valueReference

        self.fmu_extracted = fmpy.extract(modelica_fmu_name)

        self.modelica_fmu = FMU2Slave(guid=model_description.guid,
                        unzipDirectory=self.fmu_extracted,
                        modelIdentifier=model_description.coSimulation.modelIdentifier,
                        instanceName='modelica')

        self.modelica_fmu.instantiate()
        self.modelica_fmu.setupExperiment(startTime=self.modelica_start_time, stopTime=self.stop_time)
        self.modelica_fmu.enterInitializationMode()
        self.modelica_fmu.exitInitializationMode()

    def cleanup_fmu(self):
        self.fmu.terminate()
        self.fmu.freeInstance()
        shutil.rmtree(self.fmu_extracted, ignore_errors=True)

    def advance_simulation(self, TES_charge_rate: int):
        self.fmu.setReal([self.vrs['TES_load']], [TES_charge_rate])
        self.fmu.doStep(currentCommunicationPoint=self.current_time, communicationStepSize=self.delta_time)
        # self.current_time += self.delta_time

    def pass_rate_to_tes_object(self, tes_object: tes_classes.TES_iceStorage_simple, reqd_rate: float):
        inlet_temperature = self.fmu.getReal([self.vrs['TES_inletTemp']])[0]
        inlet_mass_flowrate = self.fmu.getReal([self.vrs['TES_flowrate']])[0]
        if reqd_rate < 0:
            if inlet_temperature >= tes_object.phase_change_temperature:
                # Pre-cooling mode when charging is requested but CHW supply temp is not low enough. This value for TES load will run CHW loop without charging TES object
                TES_load = -1e-6
                new_soc = tes_object.soc
            else:
                TES_load, new_soc = tes_object.calculate_charge_discharge_rate(reqd_rate, inlet_temperature, inlet_mass_flowrate)
        else:
            TES_load, new_soc = tes_object.calculate_charge_discharge_rate(reqd_rate, inlet_temperature, inlet_mass_flowrate)

        self.advance_simulation(TES_load)
        return TES_load, new_soc
    
    def pass_rate_to_tess_fmu(self, reqd_rate: float):
        # self.inlet_temperature = self.fmu.getReal([self.vrs['CHW_return_temp']])[0]
        # self.inlet_mass_flowrate = self.fmu.getReal([self.vrs['mCHW_flowrate']])[0]
        # self.outdoor_air_temperature = self.fmu.getReal([self.vrs['TOut']])[0]
        # self.fmu_sign_correction = -reqd_rate
        # print(self.inlet_temperature, self.inlet_mass_flowrate, self.outdoor_air_temperature, self.fmu_sign_correction)

        if not reqd_rate > 0:
            self.modelica_fmu.setReal([self.modelica_vrs['TOut']], [273.15 + 20])
            # self.modelica_fmu.setReal([self.modelica_vrs['mCHW_flow']], [self.inlet_mass_flowrate])
            # self.modelica_fmu.setReal([self.modelica_vrs['TRet']], [273.15+self.inlet_temperature])
            self.modelica_fmu.setReal([self.modelica_vrs['TRet']], [273.15+8])
            self.modelica_fmu.setReal([self.modelica_vrs['mCHW_flow']], [0.0])
        self.modelica_fmu.setReal([self.modelica_vrs['uQReq']], [reqd_rate])
        self.modelica_fmu.doStep(currentCommunicationPoint=self.current_time, communicationStepSize=self.delta_time)

        actual_charge_rate = -self.modelica_fmu.getReal([self.modelica_vrs['Q_flow']])[0]
        actual_SOC = self.modelica_fmu.getReal([self.modelica_vrs['SOC']])[0]

        print(f"Actual charge rate={actual_charge_rate}, Actual SOC={actual_SOC}")
        return actual_charge_rate, actual_SOC
    
    def warm_up_modelica(self, simulation_year: int):
        print("Running TESS warmup")
        end_time = self.start_time
        start_time = self.modelica_start_time
        current_time = start_time
        print(start_time, end_time)

        self.modelica_fmu.setReal([self.modelica_vrs['uQReq']], [0])
        self.modelica_fmu.setReal([self.modelica_vrs['TOut']], [273.15 + 15])
        self.modelica_fmu.setReal([self.modelica_vrs['mCHW_flow']], [0])
        self.modelica_fmu.setReal([self.modelica_vrs['TRet']], [273.15+12])
        grethr_hys = self.modelica_fmu.getReal([self.modelica_vrs['tESS.greThr.h']])[0]
        # print(grethr_hys)

        while current_time < end_time:
            chiller_supply_temp = self.modelica_fmu.getReal([self.modelica_vrs['tESS.senTem.T']])[0]
            if chiller_supply_temp > (273.15):
                self.modelica_fmu.setReal([self.modelica_vrs['uQReq']], [300000])
                input_signal = self.modelica_fmu.getReal([self.modelica_vrs['uQReq']])[0]
                flowrate_signal = self.modelica_fmu.getReal([self.modelica_vrs['tESS.mov.m_flow_in']])[0]
                actual_flowrate = self.modelica_fmu.getReal([self.modelica_vrs['tESS.mov.m_flow_actual']])[0]
                actual_soc = self.modelica_fmu.getReal([self.modelica_vrs['SOC']])[0]
                grethr_signal = self.modelica_fmu.getReal([self.modelica_vrs['tESS.greThr.u']])[0]
                grethr_output = self.modelica_fmu.getBoolean([self.modelica_vrs['tESS.greThr.y']])[0]
                bootorea_signal = self.modelica_fmu.getReal([self.modelica_vrs['tESS.booToRea.y']])[0]
                gain_signal = self.modelica_fmu.getReal([self.modelica_vrs['tESS.gai.y']])[0]
                val_signal = self.modelica_fmu.getReal([self.modelica_vrs['tESS.val.y']])[0]
                val_actual = self.modelica_fmu.getReal([self.modelica_vrs['tESS.val.y_actual']])[0]
                print(f"current time: {current_time},\
                        input signal: {input_signal},\
                        grethr input:{grethr_signal},\
                        grethr output:{grethr_output},\
                        BooToReal: {bootorea_signal},\
                        val signal: {val_signal},\
                        val actual: {val_actual},\
                        gain signal: {gain_signal},\
                        water flowrate signal: {flowrate_signal},\
                        actual water flowrate: {actual_flowrate},\
                        actual SOC:{actual_soc}")
                # print(f"Precooling chilled water loop: Currently {chiller_supply_temp}, input signal: {input_signal}, water flowrate signal: {flowrate_signal}, actual water flowrate: {actual_flowrate}, actual SOC:{actual_soc}")
            else:
                self.modelica_fmu.setReal([self.modelica_vrs['uQReq']], [0])
            self.modelica_fmu.doStep(currentCommunicationPoint=current_time, communicationStepSize=self.delta_time)
            current_time += self.delta_time

        print("Finished warming up TESS system")


def test_setup(fmu_path: os.PathLike = os.path.join(os.getcwd(), "ASHRAE901_OfficeLarge_STD2019_Pasco.fmu")):
    # fmu_name = os.path.join(os.path.curdir, 'ASHRAE901_OfficeLarge_STD2019_Pasco.fmu')
    fmu_name = fmu_path
    input_timeseries = pd.read_excel(os.path.join(os.getcwd(), 'TES_parameters_closedLoop.xlsx'))

    start_date = '08/08'
    stop_date = '08/10'
    change_date = '07/16'
    current_year = 2023
    simulation = Simulation(fmu_name, start_date, stop_date, current_year)
    initial_soc = 0

    tess_capacity = 1100*3600*1000
    phase_change_temperature = 0
    nominal_mass_flowrate = 26.864
    tes_object = tes_classes.TES_iceStorage_simple(tess_capacity, phase_change_temperature, nominal_mass_flowrate, simulation.delta_time, initial_soc)

    change_time = (datetime.datetime(year=current_year, month=int(change_date.split('/')[0]), day=int(change_date.split('/')[1])) - datetime.datetime(year=current_year, month=1, day=1)).total_seconds()

    TES_load_list = []
    TES_reqd_list = []
    soc_list = []
    datetime_list = []
    UA_value_list = []
    outlet_temperature_list = []
    max_charge_rate_list = []
    max_discharge_rate_list = []
    loop1_temp_list = []
    loop2_temp_list = []

    while simulation.current_time < simulation.stop_time:
        print(simulation.current_time)

        current_datetime = datetime.datetime(year=current_year, month=1, day=1) + datetime.timedelta(seconds=simulation.current_time)
        current_datetime_string = current_datetime.isoformat()
        if current_datetime_string in input_timeseries['Datetime'].values:
            print(input_timeseries['TES reqrd'][input_timeseries['Datetime'] == current_datetime_string].values[0])
            current_charge_reqd = input_timeseries['TES reqrd'][input_timeseries['Datetime'] == current_datetime_string].values[0]
        if simulation.current_time == simulation.start_time:
            current_charge_reqd = 0
        loop1_temp = simulation.fmu.getReal([simulation.vrs['HE2_supply_inlet']])[0]
        loop2_temp = simulation.fmu.getReal([simulation.vrs['HE2_demand_inlet']])[0]

        TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, float(current_charge_reqd))

        TES_load_list.append(TES_load)
        TES_reqd_list.append(current_charge_reqd)
        soc_list.append(new_soc)
        datetime_list.append(current_datetime.isoformat())
        UA_value_list.append(tes_object.UA_value)
        outlet_temperature_list.append(tes_object.outlet_temperature)
        max_charge_rate_list.append(tes_object.max_charge_rate)
        max_discharge_rate_list.append(tes_object.max_discharge_rate)
        loop1_temp_list.append(loop1_temp)
        loop2_temp_list.append(loop2_temp)
        simulation.current_time += simulation.delta_time
    simulation.fmu.terminate()
    simulation.fmu.freeInstance()
    

    soc_df = pd.DataFrame()
    soc_df['Datetime'] = datetime_list
    soc_df['SOC'] = soc_list
    soc_df['Reqd TES load'] = TES_reqd_list
    soc_df['TES load'] = TES_load_list
    soc_df['UA value'] = UA_value_list
    soc_df['Outlet temperature'] = outlet_temperature_list
    soc_df['Max charge rate'] = max_charge_rate_list
    soc_df['Max discharge rate'] = max_discharge_rate_list
    soc_df['Supply loop HE temperature'] = loop1_temp_list
    soc_df['Demand loop HE temperature'] = loop2_temp_list
    soc_df.to_excel(f"./TES_parameters_{os.path.basename(fmu_path).replace('.fmu', '')}.xlsx")

def run_validation_1():
    fmu_name = os.path.join(os.path.curdir, 'ASHRAE901_OfficeLarge_STD2019_Pasco.fmu')

    start_date = '07/01'
    stop_date = '07/31'
    change_date = '07/16'
    current_year = 2023
    simulation = Simulation(fmu_name, start_date, stop_date, current_year)
    initial_soc = 0
    tess_capacity = 65.83*(10**9)
    phase_change_temperature = 0
    nominal_mass_flowrate = 69.8
    tes_object = tes_classes.TES_iceStorage_simple(tess_capacity, phase_change_temperature, nominal_mass_flowrate, simulation.delta_time, initial_soc)

    change_time = (datetime.datetime(year=current_year, month=int(change_date.split('/')[0]), day=int(change_date.split('/')[1])) - datetime.datetime(year=current_year, month=1, day=1)).total_seconds()

    while simulation.current_time <= simulation.stop_time:
        print(simulation.current_time)

        current_datetime = datetime.datetime(year=current_year, month=1, day=1) + datetime.timedelta(seconds=simulation.current_time)
        current_timestamp = current_datetime.time()
        current_hour = current_timestamp.hour

        if simulation.current_time<change_time:
            if (current_hour > 8) and (current_hour<18):
                TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, 0)
            else:
                TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, 0)
        else:
            if (current_hour > 8) and (current_hour<18):
                TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, 0)
            else:
                TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, 0)

def run_validation_2():
    fmu_name = os.path.join(os.path.curdir, 'ASHRAE901_OfficeLarge_STD2019_Pasco.fmu')

    start_date = '07/18'
    stop_date = '07/23'
    change_date = '07/16'
    current_year = 2023
    simulation = Simulation(fmu_name, start_date, stop_date, current_year)
    initial_soc = 100
    # tess_capacity = 3*65.83*(10**9)
    phase_change_temperature = 0
    nominal_mass_flowrate = 69.8
    cooling_start_time = 8
    cooling_end_time = 17
    if cooling_end_time > cooling_start_time:
        non_cooling_time = (24 - (cooling_end_time - cooling_start_time))*3600
    else:
        non_cooling_time = (cooling_end_time - cooling_start_time)*3600
    tess_capacity = 800*(24-non_cooling_time)
    tes_object = tes_classes.TES_iceStorage_simple(tess_capacity, phase_change_temperature, nominal_mass_flowrate, simulation.delta_time, initial_soc)

    change_time = (datetime.datetime(year=current_year, month=int(change_date.split('/')[0]), day=int(change_date.split('/')[1])) - datetime.datetime(year=current_year, month=1, day=1)).total_seconds()

    TES_load_list = []
    soc_list = []
    datetime_list = []
    UA_value_list = []
    outlet_temperature_list = []
    max_charge_rate_list = []
    max_discharge_rate_list = []

    while simulation.current_time < simulation.stop_time:
        print(simulation.current_time)

        current_datetime = datetime.datetime(year=current_year, month=1, day=1) + datetime.timedelta(seconds=simulation.current_time)
        current_timestamp = current_datetime.time()
        current_hour = current_timestamp.hour

        q1_coil = simulation.fmu.getReal([simulation.vrs['qCoil1']])[0]
        q2_coil = simulation.fmu.getReal([simulation.vrs['qCoil2']])[0]
        q3_coil = simulation.fmu.getReal([simulation.vrs['qCoil3']])[0]
        q4_coil = simulation.fmu.getReal([simulation.vrs['qCoil4']])[0]
        sum_q_coil = q1_coil + q2_coil + q3_coil + q4_coil

        if not ((current_hour > cooling_start_time) and (current_hour<cooling_end_time)):
            TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, -tess_capacity/non_cooling_time)
        else:
            if (sum_q_coil > 0) and (tes_object.soc > 0):
                TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, sum_q_coil)
            else:
                TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, -tess_capacity/non_cooling_time)

        TES_load_list.append(TES_load)
        soc_list.append(new_soc)
        datetime_list.append(current_datetime.isoformat())
        UA_value_list.append(tes_object.UA_value)
        outlet_temperature_list.append(tes_object.outlet_temperature)
        max_charge_rate_list.append(tes_object.max_charge_rate)
        max_discharge_rate_list.append(tes_object.max_discharge_rate)
        simulation.current_time += simulation.delta_time

    TES_load, new_soc = simulation.pass_rate_to_tes_object(tes_object, 0)
    TES_load_list.append(TES_load)
    soc_list.append(new_soc)
    datetime_list.append(current_datetime.isoformat())
    UA_value_list.append(tes_object.UA_value)
    outlet_temperature_list.append(tes_object.outlet_temperature)
    max_charge_rate_list.append(tes_object.max_charge_rate)
    max_discharge_rate_list.append(tes_object.max_discharge_rate)

    soc_df = pd.DataFrame()
    soc_df['Datetime'] = datetime_list
    soc_df['SOC'] = soc_list
    soc_df['TES load'] = TES_load_list
    soc_df['UA value'] = UA_value_list
    soc_df['Outlet temperature'] = outlet_temperature_list
    soc_df['Max charge rate'] = max_charge_rate_list
    soc_df['Max discharge rate'] = max_discharge_rate_list
    soc_df.to_excel('./TES_parameters.xlsx')

def test_setup_secondarySchool(fmu_path: os.PathLike = os.path.join(os.getcwd(), "ASHRAE901_SchoolSecondary_STD2019_Buffalo.fmu")):
    # fmu_name = os.path.join(os.path.curdir, 'ASHRAE901_OfficeLarge_STD2019_Pasco.fmu')
    fmu_name = fmu_path
    modelica_fmu_name = os.path.join(os.getcwd(), 'Buildings_Fluid_Storage_Ice_Validation_TESS_0W_0interfaces.fmu')
    input_timeseries = pd.read_excel(os.path.join(os.getcwd(), 'TES_parameters_closedLoop.xlsx'))
    case_name = 'Case3_Boston'
    input_param_filename = 'Case_Study/'+case_name+'/opt_dispatch_input.csv'
    input_param = pd.read_csv(input_param_filename)
    bes_soc0 = input_param.query("variable_name=='E_0'")['value'].iloc[0]
    tes_soc0 = input_param.query("variable_name=='L_0'")['value'].iloc[0]
    min_tes_charge = input_param.query("variable_name=='Cap_c_tess'")['value'].iloc[0]*1000*0.01

    with open('Case_Study/'+case_name+'/case_input.json') as f:
        case_dict = json.load(f)
        f.close()

    start_date = '07/01'
    stop_date = '07/02'
    change_date = '07/16'
    current_year = 2023
    simulation = Simulation(fmu_name, start_date, stop_date, current_year, modelica_fmu_name)

    # TES parameters
    initial_soc = 0
    simulation.modelica_fmu.setReal([simulation.modelica_vrs['SOC_start']], [initial_soc])

    next_hour = 0
    tes_chg_rate = 0
    bes_chg_rate = 0
    url = "http://127.0.0.1:5000"
    eplus_url = "http://127.0.0.1:5050"

    inputs = {}
    inputs['input_param_filename'] = input_param_filename
    inputs['WD_filename']          = case_dict['WD_filename']
    inputs['location']             = case_name.split('_')[-1]

    TES_load_list = []
    TES_reqd_list = []
    soc_list = []
    datetime_list = []
    outlet_temperature_list = []
    TESS_inlet_temp = []
    TESS_inlet_mass_flowrate = []

    while simulation.current_time <= simulation.stop_time:
        print(simulation.current_time)

        current_datetime = datetime.datetime(year=current_year, month=1, day=1) + datetime.timedelta(seconds=simulation.current_time)
        current_datetime_string = current_datetime.isoformat()
        current_hour = current_datetime.hour

        if current_hour == next_hour:
                next_hour = (current_hour + 1)%24
                if current_hour == 0:
                    inputs['start_date'] = (current_datetime-datetime.timedelta(days=1)).strftime("%m/%d %H:%M:%S").replace(' 00:',' 24:')
                    inputs['E_0']        = bes_soc0
                else:
                    inputs['start_date'] = current_datetime.strftime("%m/%d %H:%M:%S")
                    inputs['E_0']        = bes_soc
                print("Current time stamp: ", inputs['start_date'])

                chiller2_supplyTemp = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.electricReformulatedEIR.TEvaLvg']])[0] - 273.15
                chiller2_returnTemp = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.electricReformulatedEIR.TEvaEnt']])[0] - 273.15
                chiller2_condReturnTemp = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.electricReformulatedEIR.TConEnt']])[0] - 273.15

                inputs['L_0']            = simulation.modelica_fmu.getReal([simulation.modelica_vrs['SOC']])[0]
                inputs['T_cw_norm2']     = chiller2_supplyTemp
                inputs['T_cw_ch2']       = chiller2_returnTemp
                inputs['T_cond_l2']      = chiller2_condReturnTemp
                if "T_cw_norm1" not in inputs.keys():
                    inputs['T_cw_norm1']     = chiller2_supplyTemp
                if "T_cw_ch1" not in inputs.keys():
                    inputs['T_cw_ch1']       = chiller2_returnTemp
                if "T_cond_l1" not in inputs.keys():
                    inputs['T_cond_l1']      = chiller2_condReturnTemp
                
                input_data = json.dumps(inputs, indent=4, sort_keys=True, default=str)
                result = requests.post('{0}/calculate'.format(url),headers={"Content-type":"application/json"}, data=input_data).json()
                tes_chg_rate= result['TES_load'][0] * 1000 # unit conversion from kW to Watts
                if ((tes_chg_rate < 0) and (tes_chg_rate > -min_tes_charge)) or ((tes_chg_rate>0) and (tes_chg_rate < min_tes_charge)):
                    new_tes_chg_rate = 0
                else:
                    new_tes_chg_rate = tes_chg_rate
                # bes_chg_rate= result['bess_power'][0]*1000

                bes_soc     = result["bess_soc"][0]  # Save next step bess_soc
                power_price = result['power_price'][0]
                cool_demand = result['cool_demand'][0]
                elec_demand = result['elec_demand'][0]
                simulation.reqd_charge_rate = new_tes_chg_rate
                print("required TES Charge rate is: ",new_tes_chg_rate,"W")

        if "TES_inlet_temp" in result.keys():
            tes_inlet_temp = 273.15 + result["TES_inlet_temp"]
        else:
            tes_inlet_temp = 273.15 + 20
        if "TES_mFlowrate" in result.keys():
            tes_flowrate = result["TES_mFlowrate"]
        else:
            tes_flowrate = 0
        if "TOut" in result.keys():
            tout = 273.15 + result["TOut"]
        else:
            tout = 273.15 + 20
        simulation.modelica_fmu.setReal([simulation.modelica_vrs['TRet']], [tes_inlet_temp])
        simulation.modelica_fmu.setReal([simulation.modelica_vrs['mCHW_flow']], [tes_flowrate])
        simulation.modelica_fmu.setReal([simulation.modelica_vrs['TOut']], [tout])
        print(f"Required charge rate passed to TESS is {-float(simulation.reqd_charge_rate)}")
        TES_load, new_soc = simulation.pass_rate_to_tess_fmu(-float(simulation.reqd_charge_rate))
        inputs['actual_charge_rate'] = TES_load

        input_data = json.dumps(inputs, indent=4, sort_keys=True, default=str)
        result_eplus = requests.post('{0}/calculate'.format(eplus_url),headers={"Content-type":"application/json"}, data=input_data).json()
        inputs['T_cw_norm1'] = result_eplus['T_cw_norm1']
        inputs['T_cw_ch1'] = result_eplus['T_cw_ch1']
        inputs['T_cond_l1'] = result_eplus['T_cond_l1']
        result["TES_inlet_temp"] = result_eplus['TES_inlet_temp']
        result['TES_mFlowrate'] = result_eplus['TES_mFlowrate']
        result['TOut'] = result_eplus['TOut']

        outlet_temperature = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.controlledTank_uQReq.T']])[0]
        TES_load_list.append(TES_load)
        TES_reqd_list.append(simulation.reqd_charge_rate)
        soc_list.append(new_soc)
        datetime_list.append(current_datetime.isoformat())
        outlet_temperature_list.append(outlet_temperature)
        
        simulation.current_time += simulation.delta_time


    soc_df = pd.DataFrame()
    soc_df['Datetime'] = datetime_list
    soc_df['SOC'] = soc_list
    soc_df['Reqd TES load'] = TES_reqd_list
    soc_df['TES load'] = TES_load_list
    soc_df['Outlet temperature'] = outlet_temperature_list
    soc_df.to_excel(f"./TES_parameters_{os.path.basename(fmu_path).replace('.fmu', '')}.xlsx")

class Modelica_simulation():
    def __init__(self) -> None:
        case_name = 'Case3_Boston' #'Case1_California', 'Case2_Texas', 
        self.start_date = '08/08'
        self.stop_date = '08/10'
        self.current_year = 2023

        with open('Case_Study/'+case_name+'/case_input.json') as f:
            case_dict = json.load(f)
            f.close()

        input_timeseries = pd.read_excel(os.path.join(os.getcwd(), 'TES_parameters_closedLoop.xlsx'))
        input_param_filename = 'Case_Study/'+case_name+'/opt_dispatch_input.csv'
        input_param = pd.read_csv(input_param_filename)
        fmu_name = case_dict['fmu_name']

        self.tes_soc0 = input_param.query("variable_name=='L_0'")['value'].iloc[0]
        self.bes_soc0 = input_param.query("variable_name=='E_0'")['value'].iloc[0]
        self.min_tes_charge = input_param.query("variable_name=='Cap_c_tess'")['value'].iloc[0]*1000*0.01
        self.tess_capacity = input_param.query("variable_name=='Q_tess'")['value'].iloc[0]*1000*3600
        self.phase_change_temperature = input_param.query("variable_name=='T_fr'")['value'].iloc[0]
        self.nominal_mass_flowrate = input_param.query("variable_name=='m_ice'")['value'].iloc[0]

        self.next_hour = 0
        self.tes_chg_rate = 0
        self.bes_chg_rate = 0
        #self.url = "http://127.0.0.1:5000"
        self.url = "host.docker.internal:5000"

        self.inputs = {}
        self.inputs['input_param_filename'] = input_param_filename
        self.inputs['WD_filename']          = case_dict['WD_filename']
        self.inputs['location']             = case_name.split('_')[-1]
        self.soc = 0
        TES_load_list = []
        TES_reqrd_list = []
        BES_chgrate_list = []
        Power_price_list = []
        Cool_demand_list = []
        Elec_demand_list = []
        TES_soc_list  = []
        BES_soc_list  = []
        datetime_list = []
        UA_value_list = []
        outlet_temperature_list = []
        max_charge_rate_list = []
        max_discharge_rate_list = []
        cool_demand = 0
        elec_demand = 0
        power_price = 0
        pass

def test_Modelica_python(input, simulation):
    current_time = input

    if simulation == None:
        simulation = Modelica_simulation()

    current_datetime = datetime.datetime(year=Modelica_simulation.current_year, month=1, day=1) + datetime.timedelta(seconds=current_time)
    current_timestamp = current_datetime.time()
    current_hour = current_timestamp.hour
    # print("********* ",current_datetime," *********")

    # Measurements from simulation
    chiller1_supplyTemp = 12
    chiller2_supplyTemp = 12
    chiller1_returnTemp = 18
    chiller2_returnTemp = 18
    chiller1_condReturnTemp = 20
    chiller2_condReturnTemp = 20

    if current_hour == next_hour:
        next_hour = (current_hour + 1)%24
        if current_hour == 0:
            inputs['start_date'] = (current_datetime-datetime.timedelta(days=1)).strftime("%m/%d %H:%M:%S").replace(' 00:',' 24:')
            inputs['E_0']        = simulation.bes_soc0
        else:
            inputs['start_date'] = current_datetime.strftime("%m/%d %H:%M:%S")
            inputs['E_0']        = bes_soc
        print("Current time stamp: ", inputs['start_date'])

        inputs['L_0']            = simulation.soc
        inputs['T_cw_norm1']     = chiller1_supplyTemp
        inputs['T_cw_ch1']       = chiller1_returnTemp
        inputs['T_cond_l1']      = chiller1_condReturnTemp
        inputs['T_cw_norm2']     = chiller2_supplyTemp
        inputs['T_cw_ch2']       = chiller2_returnTemp
        inputs['T_cond_l2']      = chiller2_condReturnTemp
        
        input_data = json.dumps(inputs, indent=4, sort_keys=True, default=str)
        result = requests.post('{0}/calculate'.format(simulation.url),headers={"Content-type":"application/json"}, data=input_data).json()
        tes_chg_rate= result['TES_load'][0] * 1000 # unit conversion from kW to Watts
        if ((tes_chg_rate < 0) and (tes_chg_rate > -simulation.min_tes_charge)) or ((tes_chg_rate>0) and (tes_chg_rate < simulation.min_tes_charge)):
            new_tes_chg_rate = 0
        else:
            new_tes_chg_rate = tes_chg_rate
        bes_chg_rate= result['bess_power'][0]*1000

        bes_soc     = result["bess_soc"][0]  # Save next step bess_soc
        power_price = result['power_price'][0]
        cool_demand = result['cool_demand'][0]
        elec_demand = result['elec_demand'][0]
        print("required TES Charge rate is: ",tes_chg_rate,"W")

    simulation.soc += new_tes_chg_rate*60/simulation.tess_capacity
    output = simulation.soc
    
    return output, simulation
    

def test_Modelica_fmu_windows(fmu_path: os.PathLike = os.path.join(os.getcwd(), "ASHRAE901_SchoolSecondary_STD2019_Buffalo.fmu")):
    # fmu_name = os.path.join(os.path.curdir, 'ASHRAE901_OfficeLarge_STD2019_Pasco.fmu')
    fmu_name = fmu_path
    modelica_fmu_name = os.path.join(os.getcwd(), 'TESS_121023.fmu')
    input_timeseries = pd.read_excel(os.path.join(os.getcwd(), 'TES_parameters_closedLoop.xlsx'))
    
    start_date = '07/01'
    stop_date = '07/03'
    change_date = '07/02'
    current_year = 2023
    simulation = Simulation(fmu_name, start_date, stop_date, current_year, modelica_fmu_name, True)

    # TES parameters
    initial_soc = 0
    simulation.modelica_fmu.setReal([simulation.modelica_vrs['SOC_start']], [initial_soc])
    tes_charge_rate = 80000

    TES_load_list = []
    TES_reqd_list = []
    soc_list = []
    datetime_list = []
    outlet_temperature_list = []
    TESS_inlet_temp = []
    TESS_inlet_mass_flowrate = []

    change_time = datetime.datetime(year=current_year, month=int(change_date.split("/")[0]), day=int(change_date.split("/")[1]))

    while simulation.current_time <= simulation.stop_time:
        print(simulation.current_time)

        current_datetime = datetime.datetime(year=current_year, month=1, day=1) + datetime.timedelta(seconds=simulation.current_time)
        current_datetime_string = current_datetime.isoformat()
        current_hour = current_datetime.hour

        chiller2_supplyTemp = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.electricReformulatedEIR.TEvaLvg']])[0] - 273.15
        chiller2_returnTemp = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.electricReformulatedEIR.TEvaEnt']])[0] - 273.15
        chiller2_condReturnTemp = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.electricReformulatedEIR.TConEnt']])[0] - 273.15

        if current_datetime < change_time:            
            new_tes_chg_rate = -tes_charge_rate
        else:
            new_tes_chg_rate = tes_charge_rate
            # bes_chg_rate= result['bess_power'][0]*1000

        simulation.reqd_charge_rate = new_tes_chg_rate
        print("required TES Charge rate is: ",new_tes_chg_rate,"W")

        tes_inlet_temp = 273.15 + 20
        tes_flowrate = 10
        tout = 273.15 + 20

        simulation.modelica_fmu.setReal([simulation.modelica_vrs['TRet']], [tes_inlet_temp])
        simulation.modelica_fmu.setReal([simulation.modelica_vrs['mCHW_flow']], [tes_flowrate])
        simulation.modelica_fmu.setReal([simulation.modelica_vrs['TOut']], [tout])
        print(f"Required charge rate passed to TESS is {-float(simulation.reqd_charge_rate)}")
        TES_load, new_soc = simulation.pass_rate_to_tess_fmu(-float(simulation.reqd_charge_rate))

        outlet_temperature = simulation.modelica_fmu.getReal([simulation.modelica_vrs['tESS.controlledTank_uQReq.T']])[0]
        TES_load_list.append(TES_load)
        TES_reqd_list.append(simulation.reqd_charge_rate)
        soc_list.append(new_soc)
        datetime_list.append(current_datetime.isoformat())
        outlet_temperature_list.append(outlet_temperature)
        
        simulation.current_time += simulation.delta_time


    soc_df = pd.DataFrame()
    soc_df['Datetime'] = datetime_list
    soc_df['SOC'] = soc_list
    soc_df['Reqd TES load'] = TES_reqd_list
    soc_df['TES load'] = TES_load_list
    soc_df['Outlet temperature'] = outlet_temperature_list
    soc_df.to_excel(f"./TES_parameters_{os.path.basename(fmu_path).replace('.fmu', '')}.xlsx")

    
# if __name__=='__main__':
    # try:
    #     argument = sys.argv[1]
    #     if sys.argv[1] == 'validation_1':
    #         print("Running validation-1\n")
    #         run_validation_1()
    #     elif sys.argv[1] == 'validation_2':
    #         print("Running validation-2\n")
    #         run_validation_2()
    #     elif sys.argv[1] == 'secondary_school':
    #         print("Running secondary school simulation\n")
    #         test_setup_secondarySchool()
    #         print("Completed secondary school simulation\n")
    # except:
    #     print("Running test setup\n")
    #     fmu_folder_path = os.path.join(os.getcwd(), "idf_files", "parameter_sweep", "generated_fmus", "Pasco")
    #     # list_of_fmus = os.listdir(fmu_folder_path)
    #     list_of_fmus = ["ASHRAE901_OfficeLarge_STD2019_Pasco_2_0.fmu"]
    #     target_folder_path = os.path.join(os.getcwd(), "idf_files", "parameter_sweep", "results", "Pasco")
    #     if not os.path.exists(target_folder_path):
    #         os.mkdir(target_folder_path)
    #     for fmu in list_of_fmus:
    #         test_setup(os.path.join(fmu_folder_path, fmu))
    #         result_file_name = fmu.replace(".fmu", ".csv")
    #         result_file_path = os.path.join("Output_EPExport_instance1", result_file_name)
    #         shutil.copy(result_file_path, target_folder_path)
    #         shutil.copy(f"./TES_parameters_{fmu.replace('.fmu', '')}.xlsx", target_folder_path)

    # test_setup(os.path.join(os.getcwd(), 'ASHRAE901_OfficeLarge_STD2019_Boston.fmu'))
    # test_Modelica_fmu_windows()
    