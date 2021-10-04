
from buildingspy.io.outputfile import Reader
import scipy.io as sio
from buildingspy.io.postprocess import Plotter
import os
import matplotlib.pyplot as plt
import pandas as pd
import utilities
from eppy.modeleditor import IDF
import csv
import shutil

# simulation_results_folder = '/home/developer/models/Buildings'
# processed_results_folder = '/home/developer/models/extracted_simulation_data'
# simulation_results_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\Git_repos\\modelica-buildings\\raw_mat_files\\Buffalo-post060921'
simulation_results_folder = "C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\OpenBuildingControl\\boiler_plant_case_study\\ASHRAE_BPAC21\\Datasets\\60degCSupply\\Full_datasets"
auto_result_name = True
# filter_list = ['ClosedLoopTest_singlePump', 'Atlanta', '100days', '.mat']
filter_list = ['.mat']
list_of_files = utilities.find_relevant_files(filter_list, simulation_results_folder)
print(list_of_files)
separator = '_'
# processed_results_folder_name = separator.join(filter_list)
processed_results_folder_name = 'Results'
# processed_results_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\Git_repos\\modelica-buildings\\raw_mat_files\\Buffalo-post060921\\processed_results_Jan'
processed_results_folder = os.path.join(simulation_results_folder, processed_results_folder_name)
# simulation_results_folder = 'C:\Buildings_library\modelica-buildings\raw_mat_files'
# processed_results_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\Git_repos\\modelica-buildings\\raw_mat_files\\processed_results_051121'

datapoints = {
    'boiPla.boi1.m_flow': 'boiler1_massflowrate', 
    'boiPla.senTem3.T': 'boiler1_supply_temp', 
    'boiPla.senTem1.T': 'radiator_return_temp', 
    'boiPla.boi.m_flow': 'boiler2_massflowrate', 
    'boiPla.senTem2.T': 'boiler2_supply_temp', 
    'boiPla.pum.P': 'pump1_power',
    # 'boiPla.pum1.P': 'pump2_power',
    'zoneModel_simplified.y': 'zone_temp',
    'controller.TOut': 'outdoor_air_temp',
    'boiPla.ySupTem': 'radiator_supply_temp',
    'boiPla.senVolFlo.V_flow': 'radiator_flowrate',
    'boiPla.boi1.T': 'boiler1_temp',
    'boiPla.boi.T': 'boiler2_temp',
    'boiPla.val1.y_actual': 'boiler1_isoVal_position',
    'boiPla.val2.y_actual': 'boiler2_isoVal_position',
    'boiPla.boi1.y': 'boiler1_actuatorSignal',
    'boiPla.boi.y': 'boiler2_actuatorSignal',
    'boiPla.boi1.QFue_flow': 'boiler1_fuelUse',
    'boiPla.boi.QFue_flow': 'boiler2_fuelUse',
    'boiPla.TBoiHotWatSupSet[1]': 'boiler1_supSet',
    'boiPla.TBoiHotWatSupSet[2]': 'boiler2_supSet',
    'boiPla.senRelPre1.p_rel': 'pumps_dP',
    'boiPla.boi1.y': 'boiler1_partloadratio',
    'boiPla.boi.y': 'boiler2_partloadratio',
    'controller.plaEna.yPla': 'plant_enable_signal',
    'val3.y': 'radiator_control_valve_position',
    'addPar.y': 'zone_temp_setpoint',
    'boiPla.yHotWatDp[1]': 'loop_diff_pres'}

month_start_end = {
    'January': [0, 2764800],
    'February': [2764800, 5184000],
    'March': [5184000, 7862400],
    'October': [23673600, 26352000],
    'November': [26352000, 28944000],
    'December': [28944000, 31622400]
}

line_plot_datapoints = {
    'Boiler power consumed': 'total_boiler_consumption',
    'Boiler-1 supply temperature setpoint': 'boiler1_supSet',
    'Boiler-2 supply temperature setpoint': 'boiler2_supSet',
    'Pumps power consumed': 'pumps_power_consumption',
    'Measured boiler-1 temperature': 'boiler1_temp',
    'Measured boiler-2 temperature': 'boiler2_temp',
    'Measured zone temperature': 'zone_temp',
    'Deviation from zone setpoint': 'zone_temperature_deviation'
}

bar_plot_datapoints = {
    'Boiler power consumed': 'total_boiler_consumption',
    'Pumps power consumed': 'pumps_power_consumption',
    'Total plant energy consumed': 'total_plant_consumption'
    }

weather_file_location = os.path.join('C:\\WeatherData')
weather_file_dictionary = {
    'Albuquerque': 'USA_NM_Albuquerque.Intl.AP.723650_TMY3', 
    'Atlanta': 'USA_GA_Atlanta-Hartsfield.Jackson.Intl.AP.722190_TMY3', 
    'Buffalo': 'USA_NY_Buffalo.Niagara.Intl.AP.725280_TMY3', 
    'Denver': 'USA_CO_Denver-Aurora-Buckley.AFB.724695_TMY3', 
    'Dubai': 'ARE_Abu.Dhabi_IWEC', 
    'ElPaso': 'USA_TX_El.Paso.Intl.AP.722700_TMY3', 
    'Fairbanks': 'USA_AK_Fairbanks.Intl.AP.702610_TMY3', 
    'GreatFalls': 'USA_MT_Great.Falls.Intl.AP.727750_TMY3', 
    'HoChiMinh': 'VNM_Ho.Chi.Minh.City-Tan.Son.Nhat.AP.489000_IWEC2', 
    'Honolulu': 'USA_HI_Honolulu.Intl.AP.911820_TMY3', 
    'InternationalFalls': 'USA_MN_International.Falls.Intl.AP.727470_TMY3', 
    'NewDelhi': 'IND_Delhi_New.Delhi-Safdarjung.AP.421820_IWEC2', 
    'NewYork': 'USA_NY_New.York-John.F.Kennedy.Intl.AP.744860_TMY3', 
    'PortAngeles': 'USA_WA_Port.Angeles-William.R.Fairchild.Intl.AP.727885_TMY3', 
    'Rochester': 'USA_MN_Rochester.Intl.AP.726440_TMY3', 
    'SanDiego': 'USA_CA_San.Diego-Brown.Field.Muni.AP.722904_TMY3', 
    'Seattle': 'USA_WA_Seattle-Tacoma.Intl.AP.727930_TMY3', 
    'Tampa': 'USA_FL_Tampa.Intl.AP.722110_TMY3', 
    'Tucson': 'USA_AZ_Tucson.Intl.AP.722740_TMY3'}

# idd_path = os.path.join('C:\EnergyPlusV9-0-1', 'Energy+.idd')
# IDF.setiddname(idd_path)

def main(filter_list, auto_result_name = False):
    mat_file_list = utilities.find_relevant_files(filter_list, simulation_results_folder)
    print('Found .mat files: ', mat_file_list)
    for mat_file in mat_file_list:
        print('Generating csv for ', mat_file)
        generate_csv(mat_file, auto_result_name)
    generate_plots()

def generate_csv(data_file_name, auto_result_name = False):
    # data_file_name = "simulation_results_trial_4.mat"
    global simulation_results_folder
    global processed_results_folder
    global datapoints

    # result_file_name = data_file_name.replace('.mat', '')
    data_file = os.path.join(simulation_results_folder, data_file_name)
    simulation_data_raw = Reader(data_file, 'dymola')
    var_names = simulation_data_raw.varNames()

    simulation_data = pd.DataFrame()

    for datapoint in list(datapoints):
        for var_name in var_names:
            if datapoint == var_name:
                t, simulation_data[datapoints[datapoint]] = simulation_data_raw.values(var_name)

    simulation_data['t'] = t

    simulation_data = simulation_data.drop_duplicates(subset=['t'], keep='last')

    simulation_data['minute'] = (simulation_data['t']/60).astype(int)
    simulation_data = simulation_data.groupby('minute').mean()

    simulation_data['zone_thermal_load'] = 1000 * 4200 * simulation_data['radiator_flowrate'] * (simulation_data['radiator_supply_temp'] - simulation_data['radiator_return_temp'])
    simulation_data['boiler1_power_generation'] = 4200 * simulation_data['boiler1_massflowrate'] * (simulation_data['boiler1_supply_temp'] - simulation_data['radiator_return_temp'])
    simulation_data['boiler2_power_generation'] = 4200 * simulation_data['boiler2_massflowrate'] * (simulation_data['boiler2_supply_temp'] - simulation_data['radiator_return_temp'])
    simulation_data['boiler1_power_consumption'] = simulation_data['boiler1_fuelUse']
    simulation_data['boiler2_power_consumption'] = simulation_data['boiler2_fuelUse']
    simulation_data['pumps_power_consumption'] = simulation_data['pump1_power']  # + simulation_data['pump2_power']
    simulation_data['total_boiler_generation'] = simulation_data['boiler1_power_generation'] + simulation_data['boiler2_power_generation']
    simulation_data['total_boiler_consumption'] = simulation_data['boiler1_power_consumption'] + simulation_data['boiler2_power_consumption']
    simulation_data['total_plant_consumption'] = simulation_data['total_boiler_consumption'] + simulation_data['pumps_power_consumption']
    simulation_data['zone_temperature_deviation'] = simulation_data['zone_temp'] - (273.15 + 21.11)

    available_months = get_months_available(simulation_data)

    if 'baseline' in data_file_name:
        controller_type = 'baseline'
    else:
        controller_type = 'RP-1711'

    if auto_result_name:
        for month in available_months:
            filtered_data = simulation_data[(simulation_data['t'] >= month_start_end[month][0]) & (simulation_data['t'] <= month_start_end[month][1])]
            result_file_name = controller_type + '_' + month
            print('Saving csv for ', controller_type, ' for ', month)
            if not os.path.isdir(processed_results_folder):
                os.mkdir(processed_results_folder)
            filtered_data.to_csv(os.path.join(processed_results_folder, (result_file_name + '.csv')))
            print('csv saved.')
    else:
        result_file_name = data_file_name.replace('.mat', '')
        print('Saving csv for ', data_file_name)
        if not os.path.isdir(processed_results_folder):
            os.mkdir(processed_results_folder)
        simulation_data.to_csv(os.path.join(processed_results_folder, (result_file_name + '.csv')))
        print('csv saved.')

def get_months_available(simulation_data):
    global month_start_end

    available_months = []
    for month in list(month_start_end):
        month_start = month_start_end[month][0]
        month_end = month_start_end[month][1]

        filtered_data = simulation_data[(simulation_data['t'] >= month_start) & (simulation_data['t'] <= month_end)]
        if len(filtered_data['t']) > 1:
            available_months.append(month)

    return available_months

def generate_plots():
    global processed_results_folder
    global line_plot_datapoints
    global bar_plot_datapoints

    # list_of_results = os.listdir(processed_results_folder)
    list_of_results = utilities.find_relevant_files(['.csv'], processed_results_folder)
    scenario_names = []
    for result in list_of_results:
        scenario_names.append(result.rstrip('.csv'))
    print(list_of_results)
    print(scenario_names)

    plt.close()
    for datapoint in list(line_plot_datapoints):
        plt.figure(figsize=(20,12))
        plt.title(datapoint, fontsize=32)
        for result_file in list_of_results:
            file_data = pd.read_csv(os.path.join(processed_results_folder, result_file))
            reqd_data = file_data[line_plot_datapoints[datapoint]]
            reqd_data.describe()
            plt.plot(reqd_data)
        plt.legend(['Baseline', 'Baseline+RequestReset', 'Baseline+1711Staging', 'Full1711'], fontsize=16)
        plt.xticks(fontsize=16)
        plt.yticks(fontsize=16)
        plt.savefig(os.path.join(processed_results_folder, (datapoint + '.png')))
        # plt.show()    
    
    plt.close()
    for datapoint in list(bar_plot_datapoints):
        plt.figure(figsize=(10, 6))
        plt.title(datapoint, fontsize=24)
        data_summary = pd.DataFrame()
        for result_file in list_of_results:
            file_data = pd.read_csv(os.path.join(processed_results_folder, result_file))
            reqd_data = file_data[bar_plot_datapoints[datapoint]].sum()
            data_summary[result_file.rstrip('.csv')] = [reqd_data]
        width = 0.25
        plt.bar(data_summary.columns, data_summary.iloc[0].values, width)
        plt.ylabel('Energy consumed (W-min)', fontsize=16)
        plt.yticks(fontsize=12)
        plt.xticks(data_summary.columns, fontsize=12)
        plt.savefig(os.path.join(processed_results_folder, (datapoint + '.png')))
        # plt.show()

    plt.close()
    data_summary = pd.DataFrame(columns = list(bar_plot_datapoints))
    data_summary['scenario_name'] = scenario_names
    for datapoint in list(bar_plot_datapoints):
        for result_file in list_of_results:
            file_data = pd.read_csv(os.path.join(processed_results_folder, result_file))
            reqd_data = file_data[bar_plot_datapoints[datapoint]].sum()
            reqd_row = (data_summary['scenario_name'] == result_file.rstrip('.csv')).values
            reqd_column = (data_summary.columns == datapoint)
            data_summary.iloc[reqd_row, reqd_column] = reqd_data

    plt.close('all')
    # plot_histogram(processed_results_folder, list_of_results)
    # plot_histogram_2(processed_results_folder, list_of_results)

    data_summary['%age reduction in plant energy consumption'] = (max(data_summary['Total plant energy consumed']) - data_summary['Total plant energy consumed']) * 100 / max(data_summary['Total plant energy consumed'])

    data_summary.to_csv(os.path.join(processed_results_folder, 'data_summary.csv'))

def plot_histogram(processed_results_folder, list_of_results):
    hist_datapoints = ['boiler1_partloadratio', 'boiler2_partloadratio']
    for result_file in list_of_results:
        file_data = pd.read_csv(os.path.join(processed_results_folder, result_file))
        scenario_number = find_scenario_number(result_file)
        for datapoint in hist_datapoints:
            filtered_data = file_data[file_data[datapoint] > 0]
            filtered_data.describe()
            boiler_plr_when_on = list(filtered_data[datapoint])
            plt.hist(boiler_plr_when_on)
            plt.ylim(0, 600)
            plt.savefig(os.path.join(processed_results_folder, (datapoint + '_scenario_' + scenario_number + '.png')))
            plt.close()

def plot_histogram_2(processed_results_folder, list_of_results):
    hist_datapoints = ['boiler1_partloadratio', 'boiler2_partloadratio']
    for datapoint in hist_datapoints:
        for result_file in list_of_results:
            file_data = pd.read_csv(os.path.join(processed_results_folder, result_file))
            scenario_number = find_scenario_number(result_file)
            filtered_data = file_data[file_data[datapoint] > 0]
            filtered_data.describe()
            boiler_plr_when_on = list(filtered_data[datapoint])
            if scenario_number == '5':
                plt.hist(boiler_plr_when_on,  linestyle = '-', edgecolor = 'blue', fill = False, joinstyle = 'miter')
            else:
                plt.hist(boiler_plr_when_on, linestyle = '-', edgecolor = 'red', fill = False, joinstyle = 'miter')
        plt.ylim(0, 600)
        plt.savefig(os.path.join(processed_results_folder, (datapoint + '.png')))
        plt.close()

def find_scenario_number(result_file):
    list_of_strings = result_file.split('_')
    scenario_index = list_of_strings.index('scenario') + 1
    scenario_number = list_of_strings[scenario_index]

    return scenario_number

def building_mass_compilation_from_idfs(idf_folder):
    idf_folder_path = os.path.join(idf_folder)
    summary_file_path = os.path.join(idf_folder, 'Building_mass_summary_file.csv')

    list_of_idfs = utilities.find_relevant_files(['.idf'], idf_folder_path)

    building_thermal_capacitance_data = [['Building IDF', 'Building thermal capacitance']]

    for idf in list_of_idfs:
        print('Analyzing IDF file ', idf)
        idf_path = os.path.join(idf_folder_path, idf)
        building_thermal_mass = utilities.get_thermal_mass_from_idf(idf_path)
        building_thermal_capacitance_data.append([idf.rstrip('.idf'), str(building_thermal_mass)])

    # building_thermal_capacitance_data = str(building_thermal_capacitance_data)
    csv_file = open(summary_file_path, 'w')
    csv_writer = csv.writer(csv_file)
    # for line in building_thermal_capacitance_data:
    #     csv_writer.writerow(line)
    csv_writer.writerows(building_thermal_capacitance_data)
    csv_file.close()
    print(building_thermal_capacitance_data)

def output_variables_cleanup(idf_folder, dest_folder = None):
    idf_folder_path = os.path.join(idf_folder)
    if dest_folder == None:
        dest_folder_path = idf_folder_path
    else:
        dest_folder_path = os.path.join(dest_folder)
    if not os.path.isdir(dest_folder_path):
        os.mkdir(dest_folder_path)

    list_of_idfs = utilities.find_relevant_files(['.idf'], idf_folder_path)

    for idf in list_of_idfs:
        print('Modifying IDF file ', idf)
        idf_path = os.path.join(idf_folder_path, idf)
        idf_data = IDF(idf_path)
        modified_idf_data = utilities.delete_all_existing_output_variables(idf_data)

        output_file_path = os.path.join(dest_folder_path, idf)
        modified_idf_data.save(output_file_path)

def output_variables_addition(idf_folder, dest_folder = None):
    idf_folder_path = os.path.join(idf_folder)
    if dest_folder == None:
        dest_folder_path = idf_folder_path
    else:
        dest_folder_path = os.path.join(dest_folder)
    if not os.path.isdir(dest_folder_path):
        os.mkdir(dest_folder_path)

    list_of_idfs = utilities.find_relevant_files(['.idf'], idf_folder_path)

    for idf in list_of_idfs:
        print('Adding output variable to IDF file ', idf)
        idf_path = os.path.join(idf_folder_path, idf)
        idf_data = IDF(idf_path)
        modified_idf_data = utilities.add_output_variable_to_file(idf_data, 'Boiler Heating Rate', 'HeatSys1 Boiler', 'timestep')

        output_file_path = os.path.join(dest_folder_path, idf)
        modified_idf_data.save(output_file_path)

# output_variables_cleanup('C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\OpenBuildingControl\\boiler_plant_case_study\\ASHRAE901_OfficeLarge_STD2004', 
#                          'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\OpenBuildingControl\\boiler_plant_case_study\\modified_idfs')
# output_variables_addition('C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\OpenBuildingControl\\boiler_plant_case_study\\modified_idfs')

def deploy_idfs(idf_folder, dest_folder = None):
    global weather_file_dictionary

    idf_folder_path = os.path.join(idf_folder)
    if dest_folder is None:
        dest_folder_path = idf_folder_path
    else:
        dest_folder_path = os.path.join(dest_folder)
    if not os.path.isdir(dest_folder_path):
        os.mkdir(dest_folder_path)

    list_of_idfs = utilities.find_relevant_files(['.idf'], idf_folder_path)

    for idf in list_of_idfs:
        print('Running IDF file ', idf)
        origin_path = os.path.join(idf_folder_path, idf)
        location_name = idf.rstrip('.idf').split('_')[3]
        for proper_location_name in list(weather_file_dictionary):
            if location_name in proper_location_name:
                location_name = proper_location_name
                break
        dest_path = os.path.join(dest_folder_path, location_name)
        if not os.path.isdir(dest_path):
            os.mkdir(dest_path)

        shutil.copy(origin_path, dest_path)

# idf_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\OpenBuildingControl\\boiler_plant_case_study\\modified_idfs'
# simulation_runs_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\OpenBuildingControl\\boiler_plant_case_study\\simulation_runs'
# deploy_idfs(idf_folder, simulation_runs_folder)

def calculate_envelope_heat_transfer(output_csv_file):
    csv_file_path = os.path.join(output_csv_file)
    output_data = pd.read_csv(csv_file_path)

    column_total = pd.DataFrame(index = output_data.index)
    column_total['total'] = 0
    column_headers = output_data.columns.tolist()
    for header in column_headers:
        if 'Total Heat Loss Rate' in header:
            column_total['total'] += -output_data[header]
        if 'Total Heat Gain Rate' in header:
            column_total['total'] += output_data[header]
        if 'Total Heat Loss Energy' in header:
            column_total['total'] += -output_data[header]/60
        if 'Total Heat Gain Energy' in header:
            column_total['total'] += output_data[header]/60

    column_total.to_csv(os.path.join(os.path.dirname(csv_file_path), 'window_infiltration_energyTransfer.csv'))

# calculate_envelope_heat_transfer('C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\OpenBuildingControl\\boiler_plant_case_study\\simulation_runs\\step_test\\step_test_loads_and_equipment_off_windowsAndInfiltration.csv')
main(filter_list, auto_result_name)
list_of_results = utilities.find_relevant_files(['case', '.csv'], processed_results_folder)
# plot_histogram_2(processed_results_folder, list_of_results)
