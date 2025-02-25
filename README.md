This directory contains input files, scripts (and a few output files) used in Davide Gay's BSc thesis project
on studying static friction properties of a circular hexagonal lattice sample (2D) of colloidal particles
interacting with a decagonal quasiperiodic substrate potential.
Note that all code is written assuming a set ratio
a_pot/a_coll = 5.4/5.8, which corresponds to a Novaco angle of about 5.305°.
If you wish to run simulations with different parameters - or if you want to implement
a different intercolloidal potential - be sure to update the input files accordingly.

Here follow brief explanations on how to use the scripts:
- ‘FIRE_run.sh’:
Performs FIRE minimization from the ideal lattice configuration, after rotating the sample by the Novaco angle.
Usage: ‘source FIRE_run.sh <g>’.
- ‘SA_run.sh’:
Performs Simulated Annealing from the ideal lattice configuration, after rotating the sample by the Novaco angle.
Usage: ‘source FIRE_run.sh <g>’.
Check comments in simulated_annealing.in for details on the annealing schedule.
- ‘FRICTION_run.sh’:
Simulates a constant driving force F along the x axis applied to all particles,
starting from an annealed configuration.
Usage: ‘source FRICTION_run.sh <g> <F/F_1s> <timesteps>’
- ‘RESTART.sh’:
Allows to resume a previously ended FRICTION run.
Usage:‘source RESTART.sh <g> <F/F_1s> <timesteps>’
- ‘START_FROM_CONFIG.sh’:
Starts a new FRICTION run from the configuration resulting from another FRICTION run
(same g, but different force). Useful for increasing the force applied by small amounts,
thus shortening transient phases.
Usage: ‘source START_FROM_CONFIG.sh <g> <old_F/F_1s> <new_F/F_1s> <timesteps>’
