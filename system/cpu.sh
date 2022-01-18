#!/bin/bash
# Job name
#SBATCH --job-name CPU
# Submit to the gpu QoS, the requeue QoS can also be used for gpu's 
#SBATCH -q primary
# Request one node
#SBATCH -N 1
# Total number of cores, in this example it will 1 node with 1 core each.
#SBATCH -n 8
# Request memory
#SBATCH --mem=8G
# Mail when the job begins, ends, fails, requeues
#SBATCH --mail-type=ALL
# Where to send email alerts
#SBATCH --mail-user=go2432@wayne.edu
# Create an output file that will be output_<jobid>.out
#SBATCH -o output_%j.out
# Create an error file that will be error_<jobid>.out
#SBATCH -e errors_%j.err
# Set maximum time limit
#SBATCH -t 4-0:0:0
python3 run_NAMD_GOMC.py -f user_input_NAMD_GOMC_CPU.json > log
python3 combine_data_NAMD_GOMC.py -f user_input_combine_data_NAMD_GOMC.json -w MB 














