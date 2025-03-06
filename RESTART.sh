#!/bin/bash

# ARGUMENTS: g frac ts

cd OUTPUT/FRICTION/friction_$1
DIR="backup"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd logs
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../../../..

cd CONFIG/FRICTION/friction_$1
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd restart
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../../../..

# CONFIG
cp CONFIG/FRICTION/friction_$1/final_config_$2.lmpdat CONFIG/FRICTION/friction_$1/backup/final_config_$2.lmpdat

# RESTART FILE
cp CONFIG/FRICTION/friction_$1/restart/friction_$2.restart CONFIG/FRICTION/friction_$1/restart/backup/friction_$2.restart
cp CONFIG/FRICTION/friction_$1/restart/friction_$2.restart friction_$2.restart
mv friction_$2.restart friction.restart

# .DAT
cp OUTPUT/FRICTION/friction_$1/pos_vel_$2.dat OUTPUT/FRICTION/friction_$1/backup/pos_vel_$2.dat
cp OUTPUT/FRICTION/friction_$1/pos_vel_$2.dat pos_vel_$2.dat
mv pos_vel_$2.dat pos_vel.dat

# LOG
cp OUTPUT/FRICTION/friction_$1/logs/sim_log_$2.lammps OUTPUT/FRICTION/friction_$1/logs/backup/sim_log_$2.lammps
cp OUTPUT/FRICTION/friction_$1/logs/sim_log_$2.lammps sim_log_$2.lammps
mv sim_log_$2.lammps sim_log.lammps


cp INPUT/apply_force_restart.in apply_force_restart.in

sed -i '' "22s/.*/variable g equal $1/" apply_force_restart.in

sed -i '' "44s/.*/variable Forcefrac equal $2*v_F1s/" apply_force_restart.in

sed -i '' "70s/.*/run $3/" apply_force_restart.in

echo "------------------------------------------------------------------------"
echo " "
echo "g = $1"
echo " "
echo "Using force: F = $2 F_1s"
echo "$3 simulation steps. Restarted run."
echo " "
echo "------------------------------------------------------------------------"

lmp -in apply_force_restart.in

cp pos_vel.dat OUTPUT/FRICTION/friction_$1/pos_vel.dat
mv OUTPUT/FRICTION/friction_$1/pos_vel.dat OUTPUT/FRICTION/friction_$1/pos_vel_$2.dat

cp sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps
mv OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log_$2.lammps

cp final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config.lmpdat
mv CONFIG/FRICTION/friction_$1/final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config_$2.lmpdat

mv friction.restart friction_$2.restart
mv friction_$2.restart CONFIG/FRICTION/friction_$1/restart/friction_$2.restart

rm -f apply_force_restart.in log.lammps
