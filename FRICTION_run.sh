#!/bin/bash

# ARGUMENTS: g force timesteps   (force in units of F_1s)

# create output directory, if not present
cd OUTPUT
DIR="FRICTION"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd FRICTION
DIR="friction_$1"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../..
cd CONFIG
DIR="FRICTION"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd FRICTION
DIR="friction_$1"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../..
cd OUTPUT/FRICTION/friction_$1
DIR="logs"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../../..
cd CONFIG/FRICTION/friction_$1
DIR="restart"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../../..

# copy starting config (SA_config)
cp CONFIG/SA/SA_config_$1.lmpdat SA_config_$1.lmpdat
mv SA_config_$1.lmpdat start_config.lmpdat


cp INPUT/apply_force.in apply_force.in

sed -i '' "31s/.*/variable g equal $1/" apply_force.in
#sed -i '' "47s/.*/rotat .. $3/" apply_force.in

sed -i '' "53s/.*/variable Forcefrac equal $2*v_F1s/" apply_force.in
sed -i '' "79s/.*/run $3/" apply_force.in

echo "------------------------------------------------------------------------"
echo " "
echo "g = $1"
echo " "
echo "Using force: F = $2 F_1s"
echo "$3 simulation steps"
echo " "
echo "------------------------------------------------------------------------"

lmp -in apply_force.in

cp pos_vel.dat OUTPUT/FRICTION/friction_$1/pos_vel.dat
mv OUTPUT/FRICTION/friction_$1/pos_vel.dat OUTPUT/FRICTION/friction_$1/pos_vel_$2.dat

cp sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps
mv OUTPUT/FRICTION/friction_$1/logs/sim_log.lammps OUTPUT/FRICTION/friction_$1/logs/sim_log_$2.lammps

cp final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config.lmpdat
mv CONFIG/FRICTION/friction_$1/final_config.lmpdat CONFIG/FRICTION/friction_$1/final_config_$2.lmpdat

mv friction.restart friction_$2.restart
mv friction_$2.restart CONFIG/FRICTION/friction_$1/restart/friction_$2.restart

rm -f start_config.lmpdat log.lammps apply_force.in
