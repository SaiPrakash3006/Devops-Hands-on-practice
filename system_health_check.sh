#!/bin/bash

# Exit if any command fails
set -e

# Optional: Treat unset variables as an error
set -o nounset

# Create a reports directory
REPORT_DIR="$HOME/sys_reports"
mkdir -p "$REPORT_DIR"

# Get current date & time for report name
REPORT_FILE="$REPORT_DIR/system_report_$(date +%F_%H-%M-%S).log"

# Start logging
echo "===== System Health Report: $(date) =====" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 1. CPU Info
echo ">> CPU Info:" >> "$REPORT_FILE"
echo "Number of CPU cores: $(nproc)" >> "$REPORT_FILE"
top -bn1 | grep "Cpu(s)" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# 2. Memory Usage
echo ">> Memory Usage:" >> "$REPORT_FILE"
free -h >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# 3. Disk Usage
echo ">> Disk Usage:" >> "$REPORT_FILE"
df -h >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# 4. Top 5 memory consuming processes
echo ">> Top 5 Memory Consuming Processes:" >> "$REPORT_FILE"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# 5. Running services (example: sshd, nginx)
echo ">> Status of Important Services:" >> "$REPORT_FILE"
ps -ef | grep -E 'sshd|nginx' | grep -v grep >> "$REPORT_FILE"

# 6. Show location of the report
echo ""
echo "✅ System report saved to: $REPORT_FILE"

