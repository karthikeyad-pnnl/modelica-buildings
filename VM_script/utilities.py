import os

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
    print('Found files: ', list_of_items)
    
    for item in list_of_items:
        identifier_flags = []
        if os.path.isfile(item):
            for identifier in list_of_identifiers:
                identifier_flags.append(identifier in item)

            if False in identifier_flags:
                next
            else:
                list_of_reqd_files.append(item)

    return list_of_reqd_files

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
