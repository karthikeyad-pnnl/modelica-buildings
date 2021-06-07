
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
simulation_results_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\Git_repos\\modelica-buildings\\raw_mat_files\\Changed_boiler_capacity'
processed_results_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\Git_repos\\modelica-buildings\\raw_mat_files\\Changed_boiler_capacity\\processed_results_Jan_2_5_coefficient'
# simulation_results_folder = 'C:\Buildings_library\modelica-buildings\raw_mat_files'
# processed_results_folder = 'C:\\Users\\deva713\\OneDrive - PNNL\\Documents\\Git_repos\\modelica-buildings\\raw_mat_files\\processed_results_051121'

datapoints = {
        'boiPla.boi1.m_flow': 'boiler1_massflowrate', 
        'boiPla.senTem3.T': 'boiler1_supply_temp', 
        'boiPla.senTem1.T': 'radiator_return_temp', 
        'boiPla.boi.m_flow': 'boiler2_massflowrate', 
        'boiPla.senTem2.T': 'boiler2_supply_temp', 
        'boiPla.pum.P': 'pump1_power',
        'boiPla.pum1.P': 'pump2_power',
        'zoneModel_simplified.y': 'zone_temp',
        'boiPla.TOut': 'outdoor_air_temp',
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
        'controller.plaEna.yPla': 'plant_enable_signal'}

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

idd_path = os.path.join('C:\EnergyPlusV9-0-1', 'Energy+.idd')
IDF.setiddname(idd_path)

def main():
    mat_file_list = utilities.find_relevant_files(['case_study', '15mins', 'Jan', '2_5', '.mat'], simulation_results_folder)
    print('Found .mat files: ', mat_file_list)
    for mat_file in mat_file_list:
        print('Generating csv for ', mat_file)
        generate_csv(mat_file)
    generate_plots()

def generate_csv(data_file_name):
    # data_file_name = "simulation_results_trial_4.mat"
    global simulation_results_folder
    global processed_results_folder
    global datapoints

    result_file_name = data_file_name.rstrip('.mat')
    data_file = os.path.join(simulation_results_folder, data_file_name)
    print(data_file)
    simulation_data_raw = Reader(data_file, 'dymola')
    # simulation_data_raw = sio.loadmat(data_file)
    var_names = simulation_data_raw.varNames()
    # print(var_names)

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
    simulation_data['pumps_power_consumption'] = simulation_data['pump1_power'] + simulation_data['pump2_power']
    simulation_data['total_boiler_generation'] = simulation_data['boiler1_power_generation'] + simulation_data['boiler2_power_generation']
    simulation_data['total_boiler_consumption'] = simulation_data['boiler1_power_consumption'] + simulation_data['boiler2_power_consumption']
    simulation_data['total_plant_consumption'] = simulation_data['total_boiler_consumption'] + simulation_data['pumps_power_consumption']
    simulation_data['zone_temperature_deviation'] = simulation_data['zone_temp'] - (273.15 + 21.11)

    print('Saving csv for ', data_file_name)
    if not os.path.isdir(processed_results_folder):
        os.mkdir(processed_results_folder)
    simulation_data.to_csv(os.path.join(processed_results_folder, (result_file_name + '.csv')))
    print('csv saved.')



# # Plots

# ## Configure plots

plt.rcParams['axes.facecolor']='whitesmoke'
plt.rcParams['font.size'] = 6
plt.rcParams['text.usetex'] = False
plt.rcParams['legend.facecolor'] = 'white'
plt.rcParams['legend.framealpha'] = 0.75
plt.rcParams['legend.edgecolor'] = 'none'
plt.rcParams['savefig.dpi'] = 300

def save_plot(figure, file_name):
    """ Save the figure to a pdf and png file in the directory `img`
    """
    import os
    import matplotlib.pyplot as plt
    
    out_dir = "img"
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
    figure.savefig(os.path.join(out_dir, '{}.pdf'.format(file_name)))
    figure.savefig(os.path.join(out_dir, '{}.png'.format(file_name)))
    plt.clf()
    

def configure_axes(axes):
    """ Configure the axis style
    """
    axes.spines['right'].set_visible(False)
    axes.spines['top'].set_visible(False)
    axes.spines['left'].set_visible(False)
    axes.spines['bottom'].set_visible(False)
    axes.grid(color='lightgrey', linewidth=0.25)
    return

# ---------------------------------------------------------------------------
# helper functions and scripts

def set_cases_and_initiate_plot():
    from matplotlib.gridspec import GridSpec
    cases = ['test_base', 'test_1711']
    seasons = ['']
    num_cases = len(cases)
    num_seasons = len(seasons)
    
    fig = plt.figure(figsize=(6.5,8.))
    gs1 = GridSpec(80, 1)
    gs1.update(left=0.1, right=0.9, hspace=0.05)
    
    ax = list()
    ax.insert(0, fig.add_subplot(gs1[0:11,:]))
    ax.insert(1, fig.add_subplot(gs1[12:23,:]))
    ax.insert(2, fig.add_subplot(gs1[28:39,:]))
    ax.insert(3, fig.add_subplot(gs1[40:51,:]))
    ax.insert(4, fig.add_subplot(gs1[56:67,:]))
    ax.insert(5, fig.add_subplot(gs1[68:79,:]))
    
    # fig, ax = plt.subplots(nrows=num_cases*num_seasons, ncols=1, figsize = (6.5,8.))
    # fig, ax = plt.subplots(nrows=20, ncols=1, figsize = (6.5,8.))
    
    return cases, seasons, num_cases, num_seasons, fig, ax

def set_title(ax, title):
    left, width = .01, .97
    bottom, height = .01, .88
    right = left + width
    top = bottom + height
    
    title_str = r"$\it{" + title + "}$"
    ax.text(left, top,
            title_str,
            verticalalignment = 'center',
            horizontalalignment = 'left', 
            transform=ax.transAxes,
            fontsize = 6, color = 'k',
            bbox=dict(facecolor='white', alpha=0.75, edgecolor='none'))
    
    
def set_up_labels(i, ax, cases, seasons, num_cases, num_seasons, x_axis_label, y_axis_label):
    # Hide xtick labels and ticks on the upper case subplot (each basecase)
    if i % 2 == 0:
        hide_tick_labels(ax)

    # Print x axis title only below the lowest subplot
    if i  == num_cases*num_seasons - 1:
        ax.set_xlabel(x_axis_label)
    ax.set_ylabel(y_axis_label)
    #ax.xaxis.set_ticks(np.arange(min(t)+0, 365, 1))
     
    # Annotate case
    set_title(ax, cases[i % 2])
    # Annotate case
    # if i % 2 == 0:
    #     title_str = r"$\bf{" + seasons[i/2] + "}$" + ' (upper: ' + r"$\it{" + cases[i % 2] + "}$" + ', lower: ' + r"$\it{"  + cases[(i-1) % 2] + "}$" + ')'
    #     ax.set_title(title_str, # mg assign appropriate season/case
    #                  verticalalignment = 'top',
    #                  horizontalalignment = 'center', 
    #                  fontsize = 6, color = 'k')
        
    # Print legend only at the lower plot (g36 case)
    if i % 1 == 0:
        ax.legend(loc='center right', ncol=1)
    configure_axes(ax)
        
    #plt.tight_layout(h_pad=0)
    plt.tight_layout()
    #plt.subplots_adjust(hspace = .2)
        
def tem_conv_CtoF(T_in_degC):
    '''Converts temperature provided in degC to degF
    '''
    T_in_degF = (T_in_degC)*9./5. + 32.
    
    return T_in_degF
        
def add_secondary_yaxis_for_degF(ax, time, temp_in_K):
        # Add a secondary axis with temperatures represented in F
        ax_F = ax.twinx()
        # Get limits to match with the left axis
        ax_F.set_ylim([tem_conv_CtoF(ax.get_ylim()[0]),tem_conv_CtoF(ax.get_ylim()[1])])
        # plot a "scaler" variable and make it invisible
        ax_F.plot(time, tem_conv_CtoF(temp_in_K-273.15), linewidth=0.0)
        ax_F.set_ylabel('temperature [$^\circ$F]')
        configure_axes(ax_F)
        #ax.grid(False)
        #ax.xaxis.grid()
        
def hide_tick_labels(ax):
    '''Removes labels and ticks. Kwargs: bottom controls the ticks, labelbottom the tick labels
    '''
    ax.tick_params(axis = 'x',labelbottom='off',bottom='off')

def generate_plots():
    global processed_results_folder
    global line_plot_datapoints
    global bar_plot_datapoints

    # list_of_results = os.listdir(processed_results_folder)
    list_of_results = utilities.find_relevant_files(['case_study', '.csv'], processed_results_folder)
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

    data_summary['%age reduction in plant energy consumption'] = (max(data_summary['Total plant energy consumed']) - data_summary['Total plant energy consumed']) * 100 / max(data_summary['Total plant energy consumed'])

    data_summary.to_csv(os.path.join(processed_results_folder, 'data_summary.csv'))

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
main()
