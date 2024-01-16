import os

directory = os.getcwd()

relative_directory_path = os.path.join(directory, 'fetch_sra')

folder_names = [folder for folder in os.listdir(relative_directory_path) if os.path.isdir(os.path.join(relative_directory_path, folder))]

output_file_path = os.path.join(directory, 'sample_id_list.txt')

with open(output_file_path, 'w') as file:
    for folder_name in folder_names:
        file.write(folder_name + '\n')

#Notification
print(f"List of folder names/IDs has been written to {output_file_path}")
