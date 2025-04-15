#!/bin/bash

# copy unifi dream machine pro autobackup files to local machine
# MUST INCLUDE
# .env file in same directory as script with USERNAME, PASSWORD, and GATEWAY for the unifi console login
# sshpass (macOS: https://formulae.brew.sh/formula/sshpass)
# brew install sshpass

# Author:
# 2025 Jonathan Crider | https://github.com/JonathanCrider

BACKUP_PATH=/usr/lib/unifi/data/backup/
LOCAL_FOLDER_PATH=~/unifi_backups/

# retrieve variables from .env
set -o allexport
. ./.env
set +o allexport

hasRequirements() {
  # return 0 === true
  has_sshpass=$(sshpass -V | head -1) # pipe to head, only want the first line of -V which is the version
  echo $has_sshpass

  if [[ ! $has_sshpass ]]
    then
      printf "\nplease install sshpass, then try again\n"
      return 1 # Return non-zero integer to indicate fail (0 is successful in bash/zsh, any other number is failure)
  fi

  if [[ ! $USERNAME || ! $PASSWORD || ! $GATEWAY ]]
    then
      printf "\nmissing required variables, please check they are correct and try again\n"
      return 1
  fi

  echo "Requirements met, continuing...\n"
}

copyFiles() {
  # check requirements and skip if not met
  hasRequirements || return 1

  echo copying backups from $BACKUP_PATH to $LOCAL_FOLDER_PATH
  # sshpass -p $PASSWORD scp -r "$USERNAME@$GATEWAY:$BACKUP_PATH" "$LOCAL_FOLDER_PATH"
  sshpass -p "$PASSWORD" rsync -avz -e "ssh -o StrictHostKeyChecking=no" "$USERNAME@$GATEWAY:$BACKUP_PATH" "$LOCAL_FOLDER_PATH"

  echo success, opening local folder
  open "$LOCAL_FOLDER_PATH" &>/dev/null
}

copyFiles
