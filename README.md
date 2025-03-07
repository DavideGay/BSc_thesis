##  Static depinning transition of a Crystal/Quasicrystal interface.

This directory contains  LAMMPS input files, scripts (and a few output files) used in Davide Gay's BSc thesis project
on studying static friction properties of a circular hexagonal lattice sample (2D) of colloidal particles
interacting with a decagonal quasiperiodic substrate potential.
Note that a set ratio of $a_{pot}/a_{coll} = 5.4/5.8$ is assumed, which corresponds to a Novaco angle of about 5.305°.
If you wish to run simulations with different parameters - or if you want to implement
a different intercolloidal potential - be sure to update the input files accordingly.

Here follow brief explanations on how to use the scripts:
- `FIRE_run.sh`:
Performs FIRE minimization from the ideal lattice configuration, after rotating the sample by the Novaco angle.
Usage: `source FIRE_run.sh g_value` with the desired value of g.
- `SA_run.sh`:
Performs Simulated Annealing from the ideal lattice configuration, after rotating the sample by the Novaco angle.
Usage: `source FIRE_run.sh g_value`.
Check comments in simulated_annealing.in for details on the annealing schedule.
- `FRICTION_run.sh`:
Simulates a constant driving force F along the x axis applied to all particles,
starting from an annealed configuration.
Usage: `source FRICTION_run.sh g_value F/F_1s timesteps` with the desired value of force and integration steps.
- `RESTART.sh`:
Allows to resume a previously ended FRICTION run.
Usage:`source RESTART.sh g_value F/F_1s timesteps`.
- `START_FROM_CONFIG.sh`:
Starts a new FRICTION run from the configuration resulting from another FRICTION run
(same g, but different force). Useful for increasing the force applied by small amounts,
thus shortening transient phases.
Usage: `source FRICTION_run.sh g_value old_F/F_1s new_F/F_1s timesteps`.

All scripts will put the resulting files in dedicated directories inside of
CONFIG (for system configurations) and OUTPUT (for logs and data output).
