#!/bin/bash

cp INPUT/colloid.lmpdat colloid.lmpdat

cd OUTPUT
DIR="FIRE"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd FIRE
DIR="logs"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../..

cd CONFIG
DIR="FIRE"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ..

cp INPUT/FIRE.in FIRE.in


sed -i '' "s@variable g equal .*@variable g equal $1@g" FIRE.in

echo "------------------------------------------------------------------------"
echo " "
echo "FIRE minimization: g = $1"
echo " "
echo "------------------------------------------------------------------------"

lmp -in FIRE.in

mv FIRE_log.lammps OUTPUT/FIRE/logs/FIRE_log.lammps
mv OUTPUT/FIRE/logs/FIRE_log.lammps OUTPUT/FIRE/logs/FIRE_log_$1.lammps

mv FIRE_config.lmpdat CONFIG/FIRE/FIRE_config.lmpdat
mv CONFIG/FIRE/FIRE_config.lmpdat CONFIG/FIRE/FIRE_config_$1.lmpdat


rm -f colloid.lmpdat log.lammps FIRE.in
