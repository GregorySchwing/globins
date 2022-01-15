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
mkdir MT_CPU_5
cp cpu.sh MT_CPU_5
cp -frd 1-6-production-MUT/* MT_CPU_5/
cd MT_CPU_5
sbatch cpu.sh

cd ..
mkdir MT_CPU_6
cp cpu.sh MT_CPU_6
cp -frd 1-6-production-MUT/* MT_CPU_6/
cd MT_CPU_6
sbatch cpu.sh

cd ..
mkdir MT_CPU_7
cp cpu.sh MT_CPU_7
cp -frd 1-6-production-MUT/* MT_CPU_7/
cd MT_CPU_7
sbatch cpu.sh

cd ..
mkdir MT_CPU_8
cp cpu.sh MT_CPU_8
cp -frd 1-6-production-MUT/* MT_CPU_8/
cd MT_CPU_8
sbatch cpu.sh

cd ..
mkdir MT_CPU_9
cp cpu.sh MT_CPU_9
cp -frd 1-6-production-MUT/* MT_CPU_9/
cd MT_CPU_9
sbatch cpu.sh
