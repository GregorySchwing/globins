#!/bin/bash
# Job name
#SBATCH --job-name Simple
# Submit to the primary QoS
#SBATCH -q primary
# Request one node
#SBATCH -N 1
# Total number of cores, in this example it will 1 node with 1 core each. 
#SBATCH -n 1
# Request memory
#SBATCH --mem=1G
# Mail when the job begins, ends, fails, requeues 
#SBATCH --mail-type=ALL
# Where to send email alerts
#SBATCH --mail-user=go2432@wayne.edu
# Create an output file that will be output_<jobid>.out 
#SBATCH -o output_%j.out
# Create an error file that will be error_<jobid>.out
#SBATCH -e errors_%j.err
# Set maximum time limit 
#SBATCH -t 0-2:00:0
mkdir WT_0
cp gpu.sh WT_0
cp -frd 1-6-production-WT/* WT_0/
cd WT_0
sbatch gpu.sh

cd ..
mkdir WT_1
cp gpu.sh WT_1
cp -frd 1-6-production-WT/* WT_1/
cd WT_1
sbatch gpu.sh

cd ..
mkdir WT_2
cp gpu.sh WT_2
cp -frd 1-6-production-WT/* WT_2/
cd WT_2
sbatch gpu.sh

cd ..
mkdir WT_3
cp gpu.sh WT_3
cp -frd 1-6-production-WT/* WT_3/
cd WT_3
sbatch gpu.sh

cd ..
mkdir WT_4
cp gpu.sh WT_4
cp -frd 1-6-production-WT/* WT_4/
cd WT_4
sbatch gpu.sh
