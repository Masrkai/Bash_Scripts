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

# Define GitHub repository URLs (replace with your actual repository URLs)
nix_config_repo="git@github.com:Masrkai/Nix_Configuration.git"
bashrc_repo="git@github.com:Masrkai/Bashrc.git"  # Changed this to match your likely repository name

# Create necessary directories
mkdir -p "$nix_config_dir"
mkdir -p "$bashrc_dir"

# Function to copy files, commit changes, and push to GitHub
copy_commit_and_push() {
    src=$1
    dest=$2
    repo_dir=$3
    commit_msg=$4
    github_repo=$5

    if [ -e "$src" ]; then
        cp -r "$src" "$dest"
        cd "$repo_dir"
        
        # Initialize git repository if it doesn't exist
        if [ ! -d .git ]; then
            git init
            git remote add origin "$github_repo"
        else
            # Ensure the remote URL is using SSH
            git remote set-url origin "$github_repo"
        fi
        
        git add .
        git commit -m "$commit_msg"
        
        # Push changes to GitHub
        if git push -u origin main; then
            echo -e "${LightGreen}Changes pushed to GitHub for ${Cyan}$src${NC}"
        else
            echo -e "${Cyan}Warning: Failed to push changes for ${src} to GitHub.${NC}"
            echo "Error details:"
            git push -u origin main 2>&1  # This will show the detailed error message
        fi
    else
        echo -e "${Cyan}Warning: ${src} does not exist.${NC}"
    fi
}

# Copy, commit, and push NixOS configuration
copy_commit_and_push "$src_nixos" "$nix_config_dir/" "$nix_config_dir" "Update NixOS configuration" "$nix_config_repo"

# Copy, commit, and push .bashrc and .dir_colors
copy_commit_and_push "$src_bashrc" "$bashrc_dir/" "$bashrc_dir" "Update .bashrc" "$bashrc_repo"
copy_commit_and_push "$src_dir_colors" "$bashrc_dir/" "$bashrc_dir" "Update .dir_colors" "$bashrc_repo"

# Output completion message
echo -e "${LightGreen}The Configurations of ${Cyan}.bashrc ${LightGreen}and ${Cyan}nixos ${LightGreen}were copied, committed, and pushed to GitHub ${Cyan}successfully.${NC}"