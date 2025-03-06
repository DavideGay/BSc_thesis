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

#while IFS=' ' read -r g; do
sed -i '' "31s/.*/variable g equal $1/" FIRE.in

lmp -in FIRE.in

mv FIRE_log.lammps OUTPUT/FIRE/logs/FIRE_log.lammps
mv OUTPUT/FIRE/logs/FIRE_log.lammps OUTPUT/FIRE/logs/FIRE_log_$1.data

mv FIRE_config.lmpdat CONFIG/FIRE/FIRE_config.lmpdat
mv CONFIG/FIRE/FIRE_config.lmpdat CONFIG/FIRE/FIRE_config_$1.lmpdat

#done < "INPUT/MIN.in"

rm -f colloid.lmpdat log.lammps FIRE.in
