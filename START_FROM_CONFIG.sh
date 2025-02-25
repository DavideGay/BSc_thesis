#!/bin/bash

# ARGUMENTS: g f_old f_new ts

cp CONFIG/FRICTION/friction_$1/final_config_$2.lmpdat final_config_$2.lmpdat
mv final_config_$2.lmpdat start_config.lmpdat


cp INPUT/apply_force.in apply_force.in

sed -i '' "27s/.*/variable g equal $1/" apply_force.in
#sed -i '' "47s/.*/rotat .. $3/" apply_force.in

sed -i '' "51s/.*/variable Forcefrac equal $3*v_F1s/" apply_force.in
sed -i '' "79s/.*/run $4/" apply_force.in

echo "------------------------------------------------------------------------"
echo " "
echo "g = $1"
echo " "
echo "Using force: F = $3 F_1s from $2 config"
echo "$4 simulation steps"
echo " "
echo "------------------------------------------------------------------------"

lmp -in apply_force.in

cp pos_vel.data OUTPUT/FRICTION/friction_$1/pos_vel.data
mv OUTPUT/FRICTION/friction_$1/pos_vel.data OUTPUT/FRICTION/friction_$1/pos_vel_$3.data

cp sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps
mv OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log_$3.lammps

cp final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config.lmpdat
mv CONFIG/FRICTION/friction_$1/final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config_$3.lmpdat

rm -f start_config.lmpdat apply_force.in
