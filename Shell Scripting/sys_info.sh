#!/bin/bash

# ==========================================
# System Information & Process Logger Script
# ==========================================

# 1. Variables storing system data
CURRENT_DATE=$(date)
HOST_NAME=$(hostname)
USER_NAME=$(whoami)

# 2. Print System Information
echo "=========================================="
echo "          SYSTEM INFORMATION              "
echo "=========================================="
echo "Date & Time : $CURRENT_DATE"
echo "Hostname    : $HOST_NAME"
echo "Current User: $USER_NAME"
echo "------------------------------------------"

# 3. Print Disk Usage
echo "[*] Disk Usage:"
df -h
echo "------------------------------------------"

# 4. Print Running Processes (First 15 for readable console display)
echo "[*] Currently Running Processes (Preview):"
ps aux | head -n 15
echo "------------------------------------------"

# 5. User Input using read -p
read -p "Enter directory name to create: " DIR_NAME
read -p "Enter file name to store processes (e.g., process_log.txt): " FILE_NAME

# 6. Create Directory and File
mkdir -p "$DIR_NAME"
touch "$DIR_NAME/$FILE_NAME"

# 7. Redirect Running Processes into the file using >
ps aux > "$DIR_NAME/$FILE_NAME"

echo "------------------------------------------"
echo "[+] Successfully saved process list to: $DIR_NAME/$FILE_NAME"
echo "=========================================="