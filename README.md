# Unifi backup tool

Script to copy backup files from UDM to your local machine.

You can manually create these, or have your UDM automatically generate them on a schedule.

## REQUIREMENTS

- `.env` file in same directory as script with required variables (see below)
- sshpass (macOS: https://formulae.brew.sh/formula/sshpass)

## RUN LOCALLY

- clone project

```bash
git clone https://github.com/JonathanCrider/unifi-backup.git
cd unifi-backup
```

- create .env in root of directory

```bash
touch .env
```

```env
# Example #
USERNAME=udm-user
PASSWORD=udm-password
GATEWAY="192.168.1.1" 

BACKUP_PATH=/usr/lib/unifi/data/backup/
LOCAL_FOLDER_PATH=~/unifi_backups/
```

- run file with bash

```bash
bash ./copy_backups.sh
```
