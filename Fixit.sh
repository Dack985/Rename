cat <<EOF | sudo tee '/etc/revert_renamed_commands.sh' > /dev/null
#!/bin/bash

# Define array of renamed commands and their original paths
renamed_commands=(
    "nano1:/usr/local/bin/nano1:/usr/bin/nano"
    "ls1:/usr/local/bin/ls1:/bin/ls"
    "ssh1:/usr/local/bin/ssh1:/usr/bin/ssh"
    "cd1:/usr/local/bin/cd1:/usr/bin/cd"
    "touch1:/usr/local/bin/touch1:/usr/bin/touch"
    "mkdir1:/usr/local/bin/mkdir1:/usr/bin/mkdir"
)

# Restore original commands by moving binaries back to original locations with original names
for command_info in "\${renamed_commands[@]}"; do
    IFS=':' read -r renamed_name renamed_path original_path <<< "\$command_info"
    if [ -x "\$renamed_path" ]; then
        sudo mv "\$renamed_path" "\$original_path"
        echo "Command '\$renamed_name' restored to original: \$original_path"
    else
        echo "Error: Renamed command '\$renamed_name' not found at '\$renamed_path'"
    fi
done

# Remove any aliases or modifications made during renaming process
echo "Removing alias for 'mv1'..."
sed -i '/alias mv1/d' ~/.bashrc
source ~/.bashrc

echo "Reversal of renaming completed successfully."
EOF
