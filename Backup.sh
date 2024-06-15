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

# Copy files and directories if they exist
if [ -d "$src_nixos" ]; then
  cp -r "$src_nixos"/* "$nix_config_dir/"
else
  echo -e "${Cyan}Warning: ${src_nixos} does not exist.${NC}"
fi

if [ -f "$src_bashrc" ]; then
  cp "$src_bashrc" "$bashrc_dir/"
else
  echo -e "${Cyan}Warning: ${src_bashrc} does not exist.${NC}"
fi

if [ -f "$src_dir_colors" ]; then
  cp "$src_dir_colors" "$bashrc_dir/"
else
  echo -e "${Cyan}Warning: ${src_dir_colors} does not exist.${NC}"
fi


# Output completion message
echo -e "${LightGreen}The Configurations of ${Cyan}.bashrc ${LightGreen}and ${Cyan}nixos ${LightGreen}were copied ${Cyan}successfully.${NC}"
