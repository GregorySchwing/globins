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
mkdir MT_CPU_0
cp cpu.sh MT_CPU_0
cp -frd 1-6-production-MUT/* MT_CPU_0/
cd MT_CPU_0
sbatch cpu.sh

mkdir MT_CPU_1
cp cpu.sh MT_CPU_1
cp -frd 1-6-production-MUT/* MT_CPU_1/
cd MT_CPU_1
sbatch cpu.sh

mkdir MT_CPU_2
cp cpu.sh MT_CPU_2
cp -frd 1-6-production-MUT/* MT_CPU_2/
cd MT_CPU_2
sbatch cpu.sh

mkdir MT_CPU_3
cp cpu.sh MT_CPU_3
cp -frd 1-6-production-MUT/* MT_CPU_3/
cd MT_CPU_3
sbatch cpu.sh

mkdir MT_CPU_4
cp cpu.sh MT_CPU_4
cp -frd 1-6-production-MUT/* MT_CPU_4/
cd MT_CPU_4
sbatch cpu.sh
