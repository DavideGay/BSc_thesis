#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Usage: $0 <g>"
    exit 1
fi

g_value="$1"

cp input/colloid.lmpdat colloid.lmpdat

cp input/FIRE.in FIRE.in

sed -i '' "s@variable g equal .*@variable g equal $g_value@g" FIRE.in

echo "------------------------------------------------------------------------"
echo " "
echo "FIRE minimization: g = $g_value"
echo " "
echo "------------------------------------------------------------------------"

lmp -in FIRE.in

# Declare files and their corresponding destination folders
FILES=(
    "FIRE_config.lmpdat"
    "FIRE_log.lammps"
)

# Corresponding destination folders
DESTINATIONS=(
    "config/fire/"
    "output/fire/"
)

for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    destination="${DESTINATIONS[$i]}"

    mkdir -p "$destination"

    if [[ -f "$file" ]]; then
      filename="${file%.*}"  # Extract filename
      extension="${file##*.}"  # Extract extension

      new_name="${filename}_$g_value.${extension}"   # Rename with g value

      mv "$file" "${destination}${new_name}"

    else
        echo "Warning: $file not found!"
    fi
done


rm -f colloid.lmpdat log.lammps FIRE.in
