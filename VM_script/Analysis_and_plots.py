
from buildingspy.io.outputfile import Reader
from buildingspy.io.postprocess import Plotter
import os
import matplotlib.pyplot as plt
import pandas as pd
import utilities

simulation_results_folder = 'home/developer/models/Buildings'
processed_results_folder = 'home/developer/models/extracted_simulation_data'

datapoints = {
        'boilerPlant.senVolFlo2.V_flow': 'boiler1_flowrate', 
        'boilerPlant.senTem3.T': 'boiler1_supply_temp', 
        'boilerPlant.senTem1.T': 'radiator_return_temp', 
        'boilerPlant.senVolFlo1.V_flow': 'boiler2_flowrate', 
        'boilerPlant.senTem2.T': 'boiler2_supply_temp', 
        'boilerPlant.pum.P': 'pump1_power',
        'boilerPlant.pum1.P': 'pump2_power',
        'boilerPlant.yZonTem': 'zone_temp',
        'boilerPlant.TOutAir': 'outdoor_air_temp',
        'boilerPlant.senTem.T': 'radiator_supply_temp',
        'boilerPlant.senVolFlo.V_flow': 'radiator_flowrate',
        'boilerPlant.boi1.T': 'boiler1_temp',
        'boilerPlant.boi.T': 'boiler2_temp',
        'boilerPlant.val1.y_actual': 'boiler1_isoVal_position',
        'boilerPlant.val2.y_actual': 'boiler2_isoVal_position',
        'boilerPlant.boi1.y': 'boiler1_actuatorSignal',
        'boilerPlant.boi.y': 'boiler2_actuatorSignal',
        'boilerPlant.boi1.QFue_flow': 'boiler1_fuelUse',
        'boilerPlant.boi.QFue_flow': 'boiler2_fuelUse',
        'boilerPlant.TBoiHotWatSupSet[1]': 'boiler1_supSet',
        'boilerPlant.TBoiHotWatSupSet[2]': 'boiler2_supSet',
        'boilerPlant.senRelPre1.p_rel': 'pumps_dP'}

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

def main():
    mat_file_list = utilities.find_relevant_files('.mat', simulation_results_folder)
    for mat_file in mat_file_list:
        generate_csv(mat_file)
    generate_plots

def generate_csv(data_file_name):
    # data_file_name = "simulation_results_trial_4.mat"
    global simulation_results_folder
    global processed_results_folder
    global datapoints

    result_file_name = data_file_name.rstrip('.mat')
    data_file = os.path.join(simulation_results_folder, data_file_name)
    simulation_data_raw = Reader(data_file, 'dymola')
    var_names = simulation_data_raw.varNames()
    print(var_names)


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
    simulation_data['boiler1_power_generation'] = -1000 * 4200 * simulation_data['boiler1_flowrate'] * (simulation_data['boiler1_supply_temp'] - simulation_data['radiator_return_temp'])
    simulation_data['boiler2_power_generation'] = -1000 * 4200 * simulation_data['boiler2_flowrate'] * (simulation_data['boiler2_supply_temp'] - simulation_data['radiator_return_temp'])
    simulation_data['boiler1_power_consumption'] = simulation_data['boiler1_fuelUse']
    simulation_data['boiler2_power_consumption'] = simulation_data['boiler2_fuelUse']
    simulation_data['pumps_power_consumption'] = simulation_data['pump1_power'] + simulation_data['pump2_power']
    simulation_data['total_boiler_generation'] = simulation_data['boiler1_power_generation'] + simulation_data['boiler2_power_generation']
    simulation_data['total_boiler_consumption'] = simulation_data['boiler1_power_consumption'] + simulation_data['boiler2_power_consumption']
    simulation_data['total_plant_consumption'] = simulation_data['total_boiler_consumption'] + simulation_data['pumps_power_consumption']
    simulation_data['zone_temperature_deviation'] = simulation_data['zone_temp'] - (273.15 + 21.11)

    simulation_data.to_csv(os.path.join(processed_results_folder, (result_file_name + '.csv')))


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

    list_of_results = os.listdir(processed_results_folder)
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
        plt.savefig((datapoint + '.png'))
        plt.show()    

    
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
        plt.show()

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

    data_summary.to_csv('data_summary.csv')
