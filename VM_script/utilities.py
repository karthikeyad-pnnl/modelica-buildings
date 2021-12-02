import os
from eppy.modeleditor import IDF
import csv

idd_path = os.path.join('C:\EnergyPlusV9-0-1', 'Energy+.idd')
IDF.setiddname(idd_path)

def delete_comment_string(lines, reqd_string):
    """
    Finds lines with a particular string defined by reqd_string and deletes the string till it hits the newline character. Returns all text including modfied and unmodified lines.
    """
    
    modified_text_data = []

    for line in lines:
        if reqd_string in line:
            string_start_index = line.index(reqd_string)
            string_end_index = line.index("\n")

            replaced_string = line[string_start_index:string_end_index]
            line = line.replace(replaced_string, '')
        
        modified_text_data.append(line)        

    return modified_text_data

def delete_number_of_lines(lines, start_line = 0, end_line = 0, number_of_lines = 0):
    """
    Deletes lines with line-index starting at start_line and up to end_line. number_of_lines can also be used in lieu of end_line. Returns text with lines removed.
    """

    if end_line == 0:
        end_line = start_line + number_of_lines

    modified_text_data = []
    
    for line_index, line in enumerate(lines):
        if line_index < end_line:
            line = ''        
        modified_text_data.append(line)

    return modified_text_data

def find_relevant_files(list_of_identifiers, folder_name='.'):
    """
    Finds files within a folder that satisfy all the identifying strings in list_of_identifiers. Returns list of files.
    """

    list_of_reqd_files = []

    list_of_items = os.listdir(folder_name)
    
    for item in list_of_items:
        identifier_flags = []
        for identifier in list_of_identifiers:
            identifier_flags.append(identifier in item)

        if False in identifier_flags:
            next
        else:
            list_of_reqd_files.append(item)

    return list_of_reqd_files

def delete_all_existing_output_variables(idf_data):

    print(len(idf_data.idfobjects['Output:Variable'.upper()]))

    output_variables = idf_data.idfobjects['Output:Variable'.upper()]
    while len(output_variables) > 0:
        for variable in output_variables:
            idf_data.removeidfobject(variable)
        output_variables = idf_data.idfobjects['Output:Variable'.upper()]


    print(len(idf_data.idfobjects['Output:Variable'.upper()]))

    return idf_data

def delete_all_existing_objects(idf_data, object_name):

    print(len(idf_data.idfobjects[object_name.upper()]))

    output_variables = idf_data.idfobjects[object_name.upper()]
    while len(output_variables) > 0:
        for variable in output_variables:
            idf_data.removeidfobject(variable)
        output_variables = idf_data.idfobjects[object_name.upper()]


    print(len(idf_data.idfobjects[object_name.upper()]))

    return idf_data

def add_output_variable_to_file(idf_data, variable_name, key='*', variable_reporting_frequency='Hourly'):
    valid_reporting_frequencies = ['Detailed', 'Timestep', 'Hourly', 'Daily', 'Monthly', 'RunPeriod', 'Annual']
    valid_reporting_frequencies_upper = [item.upper() for item in valid_reporting_frequencies]
    if variable_reporting_frequency.upper() not in valid_reporting_frequencies_upper:
        raise 'Invalid variable reporting frequency'
    reqd_reporting_frequncy = valid_reporting_frequencies[valid_reporting_frequencies_upper.index(variable_reporting_frequency.upper())]

    idf_data.newidfobject('Output:Variable'.upper(), Key_Value = key, Variable_Name = variable_name, Reporting_Frequency = reqd_reporting_frequncy)

    return idf_data

def get_thermal_mass_from_idf(file_path):
    '''
    https://unmethours.com/question/39167/is-there-a-way-to-extract-thermal-mass-from-an-energyplus-model/

    '''
    
    idf_data = IDF(file_path)
    building_thermal_mass = 0
    surfaces = idf_data.idfobjects['BuildingSurface:Detailed'.upper()]

    for surface in surfaces:
        surface_thermal_mass = 0

        construction = idf_data.getobject('CONSTRUCTION', surface.Construction_Name)

        if construction is not None:

            construction_field_names = construction.fieldnames

            construction_heat_capacity = 0
            for field_name in construction_field_names[2:]:
                attribute = field_name
                material_name = getattr(construction, attribute)
                material = idf_data.getobject('MATERIAL', material_name)

                if material is not None:
                    thickness = material.Thickness
                    density = material.Density
                    specific_heat = material.Specific_Heat

                    material_heat_capacity = thickness * density * specific_heat
                    construction_heat_capacity += material_heat_capacity
            
            surface_thermal_mass += construction_heat_capacity * surface.area

        building_thermal_mass += surface_thermal_mass
    return building_thermal_mass

def main():
    list_of_file_identifiers = ['.idf']
    list_of_strings_to_delete = ['# VM']
    number_of_lines_to_delete = 146
    modified_files_folder_name = 'modified_files'

    modified_files_folder_path = os.path.join(os.getcwd(), modified_files_folder_name)
    if not os.path.isdir(modified_files_folder_path):
        os.mkdir(modified_files_folder_path)

    list_of_idf_files = find_relevant_files(list_of_file_identifiers)

    for idf_file in list_of_idf_files:
        file_path = os.path.join(os.getcwd(), idf_file)
        text_data = open(file_path, 'r')
        lines = text_data.readlines()
        text_data.close()

        modified_text_data = delete_number_of_lines(lines, number_of_lines = number_of_lines_to_delete)

        for search_string in list_of_strings_to_delete:
            modified_text_data = delete_comment_string(modified_text_data, search_string)
        
        save_file_path = os.path.join(modified_files_folder_path, idf_file)
        file_writer = open(save_file_path, 'w')
        file_writer.writelines(modified_text_data)
        file_writer.close()

def find_zone_areas(result_file):
    from eppy.results import readhtml
    import os
    import csv
    
    result_file_path = os.path.join(result_file)
    print('Reading HTML')
    result_data =  open(result_file_path, 'r').read()
    print('Parsing HTML')
    result_tables = readhtml.titletable(result_data)

    print('Compiling table titles')
    table_titles = [result_table[0] for result_table in result_tables]

    print('Searching for required table')
    for title in table_titles:
        if 'Zone Summary' in title:
            reqd_table_index = table_titles.index(title)
            print('Found table')
            break
    
    reqd_table = result_tables[reqd_table_index]
    reqd_data = reqd_table[1]
    headers = reqd_data[0]
    zone_name_column = 0
    area_column = 1

    zone_area_table = []
    for row in reqd_data:
        zone_area_table.append([row[zone_name_column], row[area_column]])

    output_file_name = ('./zone_areas.csv')
    csv_file = open(output_file_name, 'w')
    csv_writer = csv.writer(csv_file)
    csv_writer.writerows(zone_area_table)
    csv_file.close()

def turn_off_all_internal_loads(idf_data):
    people_loads = idf_data.idfobjects['People'.upper()]
    lighting_loads = idf_data.idfobjects['Lights'.upper()]
    electric_loads = idf_data.idfobjects['ElectricEquipment'.upper()]

    list_of_loads = [people_loads, lighting_loads, electric_loads]

    for load_type in list_of_loads:
        for load in load_type:
            if (load.key == 'Lights') or (load.key == 'ElectricEquipment'):
                load.Schedule_Name = "ALWAYS_OFF"
            else:
                load.Number_of_People_Schedule_Name = 'ALWAYS_OFF'

def turn_on_internal_loads(idf_data, internal_load_key, schedule_name):
    list_of_loads = idf_data.idfobjects[internal_load_key.upper()]

    for load in list_of_loads:
        if (load.key == 'Lights') or (load.key == 'ElectricEquipment'):
            load.Schedule_Name = schedule_name
        else:
            load.Number_of_People_Schedule_Name = schedule_name

def find_active_loads(idf_data):
    people_loads = idf_data.idfobjects['People'.upper()]
    lighting_loads = idf_data.idfobjects['Lights'.upper()]
    electric_loads = idf_data.idfobjects['ElectricEquipment'.upper()]

    list_of_loads = [people_loads, lighting_loads, electric_loads]

    active_loads = [['Load name', 'Zone', 'Design level', 'Design level method']]
    for load_type in list_of_loads:
        for load in load_type:
            if (load.key == 'Lights') or (load.key == 'ElectricEquipment'):
                if 'always_on' in load.Schedule_Name.lower():
                    active_loads.append([load.Name, load.Zone_or_ZoneList_Name, load.Design_Level, load.Design_Level_Calculation_Method])
            else:
                if 'always_on' in load.Number_of_People_Schedule_Name.lower():
                    active_loads.append([load.Name, load.Zone_or_ZoneList_Name, load.Design_Level, load.Design_Level_Calculation_Method])
    
    csv_file = open('./active_loads.csv', 'w')
    csv_writer = csv.writer(csv_file)
    csv_writer.writerows(active_loads)
    csv_file.close()

# idf_data = IDF('./step_test_loads_and_equipment_off.idf')
# turn_on_internal_loads(idf_data, 'ElectricEquipment', 'ALWAYS_ON')
# idf_data.save('./step_test_loads_and_equipment_off.idf')
