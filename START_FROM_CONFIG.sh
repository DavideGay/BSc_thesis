#!/bin/bash

if [ $# -ne 4 ]; then
    echo "Usage: $0 <g> <old_force> <new_force> <steps>"
    exit 1
fi

g_value="$1"
old_force="$2"
force="$3"
steps="$4"


cp config/friction/friction_$g_value/final_config_$old_force.lmpdat final_config_$old_force.lmpdat
mv final_config_$old_force.lmpdat start_config.lmpdat

cp input/apply_force.in apply_force.in

sed -i '' "s@variable g equal .*@variable g equal $g_value@g" apply_force.in

sed -i '' "s@variable Forcefrac equal .*@variable Forcefrac equal $force*v_F1s@g" apply_force.in
sed -i '' "s@run .*@run $steps@g" apply_force.in

echo "------------------------------------------------------------------------"
echo " "
echo "FRICTION simulation: g = $g_value"
echo " "
echo "Using force: F = $force F_1s from $old_force config"
echo "$steps simulation steps"
echo " "
echo "------------------------------------------------------------------------"

lmp -in apply_force.in

# Declare files and their corresponding destination folders
FILES=(
    "final_config.lmpdat"
    "pos_vel.dat"
    "sim_log.lammps"
    "friction.restart"
)
# Corresponding destination folders
DESTINATIONS=(
    "config/friction/friction_$g_value/"
    "output/friction/friction_$g_value/"
    "output/friction/friction_$g_value/logs/"
    "config/friction/friction_$g_value/restart/"
)

for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    destination="${DESTINATIONS[$i]}"

    mkdir -p "$destination"

    if [[ -f "$file" ]]; then
      filename="${file%.*}"  # Extract filename
      extension="${file##*.}"  # Extract extension

      new_name="${filename}_$force.${extension}"

      mv "$file" "${destination}${new_name}"

    else
        echo "Warning: $file not found!"
    fi
done

rm -f start_config.lmpdat log.lammps apply_force.in
