#!/bin/bash

# Usage:
if [[ -z "$1" ]]; then
    echo "Usage: $0 <g>"
    exit 1
fi


cp input/colloid.lmpdat colloid.lmpdat

cp input/simulated_annealing.in simulated_annealing.in

sed -i '' "s@variable g equal .*@variable g equal $1@g" simulated_annealing.in

echo "------------------------------------------------------------------------"
echo " "
echo "Simulated Annealing: g = $1"
echo " "
echo "------------------------------------------------------------------------"

lmp -in simulated_annealing.in

# Declare files and their corresponding destination folders
FILES=(
    "SA_config.lmpdat"
    "SA_log.lammps"
)

# Corresponding destination folders
DESTINATIONS=(
    "config/sim_ann/"
    "output/sim_ann/"
)

for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    destination="${DESTINATIONS[$i]}"

    mkdir -p "$destination"

    if [[ -f "$file" ]]; then
      filename="${file%.*}"  # Extract filename
      extension="${file##*.}"  # Extract extension

      new_name="${filename}_$1.${extension}"   # Rename with g value

      mv "$file" "${destination}${new_name}"

    else
        echo "Warning: $file not found!"
    fi
done


rm -f colloid.lmpdat simulated_annealing.in log.lammps
