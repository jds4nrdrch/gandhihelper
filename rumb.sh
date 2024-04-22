#!/bin/bash

start_process() {
    sudo /bin/chown gandhi:gandhi /home/gandhi/MusicBot/logs/musicbot.log
    sudo /bin/chown gandhi:gandhi /home/gandhi/MusicBot/logs/musicbot.log.last
    /bin/bash /home/gandhi/MusicBot/run.sh > /dev/null &
}

stop_process() {
    pkill -f "/home/gandhi/.pyenv/versions/3.9.19/bin/python run.py"
}

check_status() {
    if pgrep -f "/home/gandhi/.pyenv/versions/3.9.19/bin/python.*run.py" > /dev/null; then
        echo "Process is running."
    else
        echo "Process is not running."
    fi
}

update_bot() {
    current_date=$(date +'%d-%m-%Y')
    backup_path="$HOME/Documents/MusicBotBackups"
    date_path="$HOME/Documents/MusicBotBackups/$current_date"
    update_file="$HOME/MusicBot/update.sh"
    files_to_backup=(
        "$HOME/MusicBot/config/aliases.json"
        "$HOME/MusicBot/config/permissions.ini"
        "$HOME/MusicBot/config/options.ini"
    )
    mkdir -p "$date_path"
    if [ ! -d "$backup_path" ]; then
        mkdir -p "$backup_path"
    else
        for file_path in "${files_to_backup[@]}"; do
            # Extract the filename from the path
            file_name=$(basename "$file_path")
            # Copy the file to the destination folder
            cp "$file_path" "$date_path/$file_name"
            echo "File '$file_name' backed up to '$date_path'."
        done
        chmod +x $update_file
        echo "y" | bash $update_file > /dev/null
        
    fi 
}
case "$1" in
    -start)
        start_process
        echo "Process started."
        ;;
    -stop)
        stop_process
        echo "Process stopped."
        ;;
    -status)
        check_status
        ;;
    -update)
        update_bot
        echo "updated bot"
        ;;
    *)
        echo "Usage: $0 {-start|-stop|-status|-update}"
        exit 1
        ;;
esac

