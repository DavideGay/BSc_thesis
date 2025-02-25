#!/bin/bash

cp INPUT/colloid.lmpdat colloid.lmpdat

cd OUTPUT/SA
DIR="logs"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
DIR="data"
if [ ! -d "$DIR" ]; then
  mkdir "$DIR"
fi
cd ../..

cp INPUT/simulated_annealing.in simulated_annealing.in

#while IFS=' ' read -r g; do

sed -i '' "27s/.*/variable g equal $1/" simulated_annealing.in
#sed -i '' "67s/.*/fix eq_langevin internal langevin $T1 $T1 1000 1    # fix ID group_ID langevin Tstart Tstop damp seed/" simulated_annealing.in
#sed -i '' "77s/.*/fix SA1_langevin internal langevin $T1 $T2 5000 1    # fix ID group_ID langevin Tstart Tstop damp seed/" simulated_annealing.in
#sed -i '' "86s/.*/fix SA2_langevin internal langevin $T2 0.0 5000 1    # fix ID group_ID langevin Tstart Tstop damp seed/" simulated_annealing.in

lmp -in simulated_annealing.in

mv SA_log.lammps OUTPUT/SA/logs/SA_log.lammps
mv OUTPUT/SA/logs/SA_log.lammps OUTPUT/SA/logs/SA_log_$1.lammps

#mv SA.data OUTPUT/SA/data/SA.data
#mv OUTPUT/SA/data/SA.data OUTPUT/SA/data/SA_$g.data

# export (final) configurations as min_config_$g.lmpdat in appropriate folder
mv final_config.lmpdat CONFIG/SA/final_config.lmpdat
mv CONFIG/SA/final_config.lmpdat CONFIG/SA/SA_config_$1.lmpdat

#done < "INPUT/MIN.in"

rm -f colloid.lmpdat simulated_annealing.in
