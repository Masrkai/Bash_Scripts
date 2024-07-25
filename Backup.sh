#!/bin/sh

# Define color variables
Cyan='\033[0;36m'
LightGreen='\033[1;32m'
NC='\033[0m'       # No Color

# Define paths
base_dir="/home/masrkai/Programs/System"
nix_config_dir="$base_dir/Nix_Configuration"
bashrc_dir="$base_dir/Bashrc"
src_nixos="/etc/nixos/"
src_bashrc="/home/masrkai/.bashrc"
src_dir_colors="/home/masrkai/.dir_colors"

# Create necessary directories
mkdir -p "$nix_config_dir"
mkdir -p "$bashrc_dir"

# Function to copy files and commit changes
copy_and_commit() {
    src=$1
    dest=$2
    repo_dir=$3
    commit_msg=$4

    if [ -e "$src" ]; then
        cp -r "$src" "$dest"
        cd "$repo_dir"
        git add .
        git commit -m "$commit_msg"
        echo -e "${LightGreen}Changes committed for ${Cyan}$src${NC}"
    else
        echo -e "${Cyan}Warning: ${src} does not exist.${NC}"
    fi
}

# Copy and commit NixOS configuration
copy_and_commit "$src_nixos" "$nix_config_dir/" "$nix_config_dir" "Update NixOS configuration"

# Copy and commit .bashrc
copy_and_commit "$src_bashrc" "$bashrc_dir/" "$bashrc_dir" "Update .bashrc"

# Copy and commit .dir_colors
copy_and_commit "$src_dir_colors" "$bashrc_dir/" "$bashrc_dir" "Update .dir_colors"

# Output completion message
echo -e "${LightGreen}The Configurations of ${Cyan}.bashrc ${LightGreen}and ${Cyan}nixos ${LightGreen}were copied and committed ${Cyan}successfully.${NC}"