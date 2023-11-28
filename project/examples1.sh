#!/bin/bash

# Function to validate if the user exists
validate_user() {
    if ! id "$1" >/dev/null 2>&1; then
        echo "User '$1' does not exist. Please choose an existing username."
        exit 1
    fi
}

# Function to create a user and add to a specified group
create_user_and_add_to_group() {
    read -p "Enter the username: " username
    validate_user "$username"

    sudo useradd -m "$username"
    echo "User '$username' created."

    read -p "Do you want to add the user to a group? (y/n): " add_to_group
    if [[ $add_to_group == "y" ]]; then
        read -p "Enter the group name to add the user to: " existing_group
        validate_group "$existing_group"
        sudo usermod -aG "$existing_group" "$username"
        echo "User '$username' added to the existing group '$existing_group'."
    else
        echo "User '$username' was not added to any group."
    fi
}

# Function to add a user to an existing group
add_user_to_group() {
    read -p "Enter the username: " username
    validate_user "$username"

    while true; do
        read -p "Do you want to add the user to a group? (y/n): " add_to_group
        case $add_to_group in
            [yY])
                read -p "Enter the group name to add the user to: " existing_group
                if grep -q "$existing_group" /etc/group; then
                    sudo usermod -aG "$existing_group" "$username"
                    echo "User '$username' added to the existing group '$existing_group'."
                else
                    echo "Group '$existing_group' does not exist. Please create the group first or choose another existing group."
                    exit 1
                fi
                break
                ;;
            [nN])
                echo "User '$username' was not added to any group."
                break
                ;;
            *)
                echo "Invalid input. Please enter 'y' or 'n'."
                ;;
        esac
    done
}

# Function to change user password
change_password() {
    read -p "Enter the username for password change: " username
    validate_user "$username"

    # Prompt the user to change the password
    sudo passwd "$username"
    echo "Password for user '$username' changed successfully."
}

# Function to add SSH key to authorized_keys file
add_ssh_key() {
    read -p "Enter the username: " username
    read -p "Do you want to add an SSH key to the authorized_keys file for user '$username'? (y/n): " add_ssh
    if [[ $add_ssh == "y" ]]; then
        read -p "Enter the SSH public key: " ssh_key
        sudo -u "$username" mkdir -p "/home/$username/.ssh"
        echo "$ssh_key" | sudo -u "$username" tee -a "/home/$username/.ssh/authorized_keys" >/dev/null
        sudo -u "$username" chmod 700 "/home/$username/.ssh"
        sudo -u "$username" chmod 600 "/home/$username/.ssh/authorized_keys"
        echo "SSH key added to authorized_keys for user '$username'."
    else
        echo "No SSH key added for user '$username'."
    fi
}

# Function to delete a user and remove from all groups
delete_user() {
    read -p "Enter the username to delete: " username
    validate_user "$username"

    # Remove user from all groups (except their primary group)
    groups=$(id -Gn "$username" | tr ' ' ',')
    sudo userdel -r "$username"

    echo "User '$username' deleted and removed from groups: $groups."
}

# Menu for user actions
echo "Choose an action:"
echo "1. Create User and add to group"
echo "2. Add user to group"
echo "3. Delete user and remove from all groups"
echo "4. Set ot Reset the password"
echo "5. Add ssh key for the user"
read -p "Enter your choice (1,2,3,4 or 5): " choice

case $choice in
    1) create_user_and_add_to_group ;;
    2) add_user_to_group ;;
    3) delete_user ;;
    4) change_password ;;
    5) add_ssh_key ;;
    *) echo "Invalid choice. Exiting." ;;
esac
