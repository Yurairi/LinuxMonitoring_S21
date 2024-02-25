#!/bin/bash

# Check if the directory path is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path="$1"

# Start measuring script execution time
start_time=$(date +%s)

# Total number of folders (including all nested ones)
total_folders=$(find "$directory_path" -type d | wc -l)

# Top 5 folders with the maximum size
top5_folders=$(du -h --max-depth=1 "$directory_path" | sort -rh | head -n 5 | awk '{printf "%d - %s, %s\n", NR, $2, $1}')

# Total number of files
total_files=$(find "$directory_path" -type f | wc -l)

# Number of specific file types
config_files=$(find "$directory_path" -type f -name "*.conf" | wc -l)
text_files=$(find "$directory_path" -type f -exec file --mime {} + | grep "text" | wc -l)
executable_files=$(find "$directory_path" -type f -executable | wc -l)
log_files=$(find "$directory_path" -type f -name "*.log" | wc -l)
archive_files=$(find "$directory_path" -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" \) | wc -l)
symbolic_links=$(find "$directory_path" -type l | wc -l)

# Top 10 files with the maximum size
top10_files=$(find "$directory_path" -type f -exec du -h {} + | sort -rh | head -n 10 | awk '{printf "%d - %s, %s\n", NR, $2, $1}')

# Top 10 executable files with the maximum size and MD5 hash
top10_executable_files=$(find "$directory_path" -type f -executable -exec du -h {} + | sort -rh | head -n 10 | \
  awk '{printf "%d - %s, %s, ", NR, $2, $1; cmd="md5sum " $2 " | cut -d'\'' '\'' -f1"; cmd | getline md5; close(cmd); printf "%s\n", md5}' | column -t)


# Calculate script execution time
end_time=$(date +%s)
execution_time=$(echo "$end_time - $start_time" | bc)

# Display information
echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$top5_folders" | column -t
echo "Total number of files = $total_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $config_files"
echo "Text files = $text_files"
echo "Executable files = $executable_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symbolic_links"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$top10_files" | column -t
echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
echo "$top10_executable_files" | column -t
echo "Script execution time (in seconds) = $execution_time"
