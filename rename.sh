sudo tee /etc/rename > /dev/null <<EOF
#!/bin/bash

# Define new command names and paths
new_commands=(
    "nano1:/usr/local/bin/nano1:/usr/bin/nano"
    "ls1:/usr/local/bin/ls1:/bin/ls"
    "ssh1:/usr/local/bin/ssh1:/usr/bin/ssh"
    "cd1:/usr/local/bin/cd1:/usr/bin/cd"
    "touch1:/usr/local/bin/touch1:/usr/bin/touch"
    "mkdir1:/usr/local/bin/mkdir1:/usr/bin/mkdir"
)

# Rename commands by moving binaries to new locations with new names
for command_info in "\${new_commands[@]}"; do
    IFS=':' read -r new_name new_path original_path <<< "\$command_info"
    if [ -x "\$original_path" ]; then
        sudo mv "\$original_path" "\$new_path"
        echo "Command '\$new_name' renamed successfully: \$new_path"
    else
        echo "Error: Original command '\$new_name' not found at '\$original_path'"
    fi
done

# Additional commands or logic can be added here

# Example: Add an alias for mv
echo "Creating alias for 'mv' as 'mv1'..."
echo "alias mv1='mv'" >> ~/.bashrc
source ~/.bashrc

echo "Renaming of commands completed successfully."
EOF
