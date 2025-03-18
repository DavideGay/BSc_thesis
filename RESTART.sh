#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <g> <force> <steps>"
    exit 1
fi

g_value="$1"
force="$2"
steps="$3"

# ---  BACKUP ---
FILES=(
    "final_config_$force.lmpdat"
    "friction_$force.restart"
    "pos_vel_$force.dat"
    "sim_log_$force.lammps"
)
FOLDERS=(
    "config/friction/friction_$g_value/"
    "config/friction/friction_$g_value/restart/"
    "output/friction/friction_$g_value/"
    "output/friction/friction_$g_value/logs/"
)
for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    folder="${FOLDERS[$i]}"
    mkdir -p "${folder}backup/"

    if [[ -f "${folder}${file}" ]]; then
      cp "${folder}${file}" "${folder}backup/${file}"
    else
        echo "Warning: $file not found!"
    fi
done

cp config/friction/friction_$g_value/restart/friction_$force.restart friction_$force.restart
mv friction_$force.restart friction.restart
cp output/friction/friction_$g_value/logs/sim_log_$force.lammps sim_log_$force.lammps
mv sim_log_$force.lammps sim_log.lammps
cp input/apply_force_restart.in apply_force_restart.in

sed -i '' "s@variable g equal .*@variable g equal $g_value@g" apply_force_restart.in

sed -i '' "s@variable Forcefrac equal .*@variable Forcefrac equal $force*v_F1s@g" apply_force_restart.in
sed -i '' "s@run .*@run $steps@g" apply_force_restart.in

echo "------------------------------------------------------------------------"
echo " "
echo "FRICTION simulation: g = $g_value"
echo " "
echo "Using force: F = $force F_1s"
echo "$steps simulation steps. Restarted run."
echo " "
echo "------------------------------------------------------------------------"

lmp -in apply_force_restart.in

FILES=(
    "final_config.lmpdat"
    "pos_vel.dat"
    "sim_log.lammps"
    "friction.restart"
)

DESTINATIONS=(
    "config/friction/friction_$g_value/"
    "output/friction/friction_$g_value/"
    "output/friction/friction_$g_value/logs/"
    "output/friction/friction_$g_value/restart/"
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


rm -f apply_force_restart.in log.lammps
