#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <g> <force> <steps>"
    exit 1
fi

# ---  BACKUP ---
FILES=(
    "final_config_$2.lmpdat"
    "friction_$2.restart"
    "pos_vel_$2.dat"
    "sim_log_$2.lammps"
)
FOLDERS=(
    "config/friction/friction_$1/"
    "config/friction/friction_$1/restart/"
    "output/friction/friction_$1/"
    "output/friction/friction_$1/logs/"
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

cp config/friction/friction_$1/restart/friction_$2.restart friction_$2.restart
mv friction_$2.restart friction.restart
cp output/friction/friction_$1/logs/sim_log_$2.lammps sim_log_$2.lammps
mv sim_log_$2.lammps sim_log.lammps
cp input/apply_force_restart.in apply_force_restart.in

sed -i '' "s@variable g equal .*@variable g equal $1@g" apply_force_restart.in

sed -i '' "s@variable Forcefrac equal .*@variable Forcefrac equal $2*v_F1s@g" apply_force_restart.in
sed -i '' "s@run .*@run $3@g" apply_force_restart.in

echo "------------------------------------------------------------------------"
echo " "
echo "FRICTION simulation: g = $1"
echo " "
echo "Using force: F = $2 F_1s"
echo "$3 simulation steps. Restarted run."
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
    "config/friction/friction_$1/"
    "output/friction/friction_$1/"
    "output/friction/friction_$1/logs/"
    "output/friction/friction_$1/restart/"
)

for i in "${!FILES[@]}"; do
    file="${FILES[$i]}"
    destination="${DESTINATIONS[$i]}"
    mkdir -p "$destination"

    if [[ -f "$file" ]]; then
      filename="${file%.*}"  # Extract filename
      extension="${file##*.}"  # Extract extension
      new_name="${filename}_$2.${extension}"

      mv "$file" "${destination}${new_name}"

    else
        echo "Warning: $file not found!"
    fi
done


rm -f apply_force_restart.in log.lammps
