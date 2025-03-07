#!/bin/bash

# ARGUMENTS: g f_old f_new ts

cp CONFIG/FRICTION/friction_$1/final_config_$2.lmpdat final_config_$2.lmpdat
mv final_config_$2.lmpdat start_config.lmpdat


cp INPUT/apply_force.in apply_force.in

sed -i '' "31s/.*/variable g equal $1/" apply_force.in
#sed -i '' "47s/.*/rotat .. $3/" apply_force.in

sed -i '' "53s/.*/variable Forcefrac equal $3*v_F1s/" apply_force.in
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

cp pos_vel.dat OUTPUT/FRICTION/friction_$1/pos_vel.dat
mv OUTPUT/FRICTION/friction_$1/pos_vel.dat OUTPUT/FRICTION/friction_$1/pos_vel_$3.dat

cp sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps
mv OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log_$3.lammps

cp final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config.lmpdat
mv CONFIG/FRICTION/friction_$1/final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config_$3.lmpdat

mv friction.restart friction_$3.restart
mv friction_$3.restart CONFIG/FRICTION/friction_$1/restart/friction_$3.restart

rm -f start_config.lmpdat log.lammps apply_force.in
