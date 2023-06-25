

#!/bin/bash

# Hospital Management System using File


FILE_PATH="/home/mahesh/patient.txt"


display_menu() {
    echo "Please select an option:"
    echo "1. Add a new patient"
    echo "2. Search for a patient"
    echo "3. Update patient information"
    echo "4. Display the patient details"
    echo "5. Delete a patient"
    echo "6. Exit"
}
display_submenu() {
    echo "Please select an option:"
    echo "1. Display all the patient details"
    echo "2. Display the patient details based on the doctor name"
    echo "3. Display the patient details based on the disease name"
}

add_patient() {
    echo "Adding a new patient..."

    read -p "Enter patient name: " name
    read -p "Enter patient age: " age
    read -p "Enter patient gender: " gender
    read -p "Enter doctor name: " doctor
    read -p "Enter disease name: " disease

    id=$(date +%s)

    echo "$id|$name|$age|$gender|$doctor|$disease" >> "$FILE_PATH"

    echo "Patient added successfully!"
}

search_patient() {
    echo "Searching for a patient..."

    read -p "Enter patient name to search: " search_name

    search_results=$(grep -i "$search_name" "$FILE_PATH")

    if [[ -n $search_results ]]; then
        echo "Search Results:"
        echo "ID        | Name | Age | Gender | Doctor | Disease"
        echo "$search_results"
    else
        echo "No matching patients found."
    fi
}

update_patient() {
    echo "Updating patient information..."

    read -p "Enter patient ID to update: " patient_id

    patient_info=$(grep "^$patient_id|" "$FILE_PATH")

    if [[ -n $patient_info ]]; then
        read -p "Enter updated patient name: " name
        read -p "Enter updated patient age: " age
        read -p "Enter updated patient gender: " gender
        read -p "Enter updated doctor name: " doctor
        read -p "Enter updated disease name: " disease

        sed -i "s/^$patient_id|.*$/$patient_id|$name|$age|$gender|$doctor|$disease/" "$FILE_PATH"

        echo "Patient information updated successfully!"
    else
        echo "Patient not found."
    fi
}

delete_patient() {
    echo "Deleting a patient..."

    read -p "Enter patient ID to delete: " patient_id

    patient_info=$(grep "^$patient_id|" "$FILE_PATH")

    if [[ -n $patient_info ]]; then
        sed -i "/^$patient_id|/d" "$FILE_PATH"

        echo "Patient deleted successfully!"
    else
        echo "Patient not found."
    fi
}
display(){
    display_submenu
    read -p "Enter your display choice: " choice

    case $choice in
        1) display_all;;
        2) display_doctor;;
        3) display_di;;
        *) echo "Invalid choice.please try again.";;
    esac
   echo
}

display_all(){
    echo "Displaying all patient details"
    if [[ -s $FILE_PATH ]]; then
	echo "Patient Dtails:"
	echo "ID        | Name | Age | Gender | Doctor | Disease"
	cat "$FILE_PATH"
    else
	echo "No patient details found."
    fi
}
display_doctor(){
    echo "Displaying based on the doctor name"

    read -p "Enter doctor name to search: " search_name

    search_results=$(grep -i "$search_name" "$FILE_PATH")

    if [[ -n $search_results ]]; then
        echo "Search Results:"
        echo "ID        | Name | Age | Gender | Doctor | Disease"
        echo "$search_results"
    else
        echo "No matching patients found."
    fi
}
display_di(){
    echo "Displaying based on the disease"

    read -p "Enter disease name to search: " search_name

    search_results=$(grep -i "$search_name" "$FILE_PATH")

    if [[ -n $search_results ]]; then
        echo "Search Results:"
        echo "ID        | Name | Age | Gender | Doctor | Disease"
        echo "$search_results"
    else
        echo "No matching patients found."
    fi
}


echo "Welcome to the Hospital Management System!"
while true; do
    display_menu
    read -p "Enter your choice: " choice

    case $choice in
        1) add_patient;;
        2) search_patient;;
        3) update_patient;;
        4) display;;
        5) delete_patient;;
        6) echo "Exiting..."; break;;
        *) echo "Invalid choice.please try again.";;
    esac

    echo

done        
