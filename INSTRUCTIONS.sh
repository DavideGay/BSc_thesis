#!/bin/bash

# Run this with 'bash INSTRUCTIONS.sh'
# This is an example of g=0.07 simulations.

# If a configuration F has not yet reached a steady state, use RESTART.sh

bash SA_run.sh 0.07

bash FRICTION_run.sh 0.07 0.01 100000
bash START_FROM_CONFIG.sh 0.07 0.01 0.02 200000
bash START_FROM_CONFIG.sh 0.07 0.02 0.03 600000
bash START_FROM_CONFIG.sh 0.07 0.03 0.04 400000
bash START_FROM_CONFIG.sh 0.07 0.04 0.05 300000
bash START_FROM_CONFIG.sh 0.07 0.05 0.06 300000
bash START_FROM_CONFIG.sh 0.07 0.06 0.07 200000
bash START_FROM_CONFIG.sh 0.07 0.07 0.08 150000
bash START_FROM_CONFIG.sh 0.07 0.08 0.09 150000
bash START_FROM_CONFIG.sh 0.07 0.09 0.1 100000
bash START_FROM_CONFIG.sh 0.07 0.1 0.11 100000
bash START_FROM_CONFIG.sh 0.07 0.11 0.12 80000
bash START_FROM_CONFIG.sh 0.07 0.12 0.13 60000

bash FRICTION_run.sh 0.07 0.2 60000
bash FRICTION_run.sh 0.07 0.3 50000
bash FRICTION_run.sh 0.07 0.4 40000
bash FRICTION_run.sh 0.07 0.5 30000
bash FRICTION_run.sh 0.07 0.6 20000
bash FRICTION_run.sh 0.07 0.7 20000

# This should take around 30+ min for simulated annealing and 6+ hours for friction simulations
# (around 12+ min per 100000 steps)
