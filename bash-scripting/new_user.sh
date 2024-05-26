#!/bin/env bash

### USAGE: ./new_script <user name>

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if username is provided
if [ -z "$1" ]; then
    echo "Usage: $0 username"
    exit 1
fi

USERNAME=$1

# Create the user with a home directory
useradd -m $USERNAME

# Check if the useradd command succeeded
if [ $? -eq 0 ]; then
    echo "User '$USERNAME' has been added to system!"
else
    echo "Failed to add a user!"
    exit 1
fi

# Set the initial password for the user
echo "Please enter the password for the user $USERNAME:"
passwd $USERNAME

# Check if the passwd command succeeded
if [ $? -eq 0 ]; then
    echo "Password has been set for user '$USERNAME'."
else
    echo "Failed to set the password!"
    exit 1
fi

echo "User creation and password setting process completed successfully."
