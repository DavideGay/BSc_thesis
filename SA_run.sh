#!/bin/bash

cp INPUT/colloid.lmpdat colloid.lmpdat

cd OUTPUT
DIR="SA"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd SA
DIR="logs"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../..
cd CONFIG
DIR="SA"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ..

cp INPUT/simulated_annealing.in simulated_annealing.in


sed -i '' "s@variable g equal .*@variable g equal $1@g" simulated_annealing.in

lmp -in simulated_annealing.in

mv SA_log.lammps OUTPUT/SA/logs/SA_log.lammps
mv OUTPUT/SA/logs/SA_log.lammps OUTPUT/SA/logs/SA_log_$1.lammps


# export (final) configurations as min_config_$g.lmpdat in appropriate folder
mv final_config.lmpdat CONFIG/SA/final_config.lmpdat
mv CONFIG/SA/final_config.lmpdat CONFIG/SA/SA_config_$1.lmpdat


rm -f colloid.lmpdat simulated_annealing.in log.lammps
