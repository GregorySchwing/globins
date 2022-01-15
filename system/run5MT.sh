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
#SBATCH -t 0-0:30:0
mkdir MT_0
cp gpu.sh MT_0
cp -frd 1-6-production-MUT/* MT_0/
cd MT_0
sbatch gpu.sh

mkdir MT_1
cp gpu.sh MT_1
cp -frd 1-6-production-MUT/* MT_1/
cd MT_1
sbatch gpu.sh

mkdir MT_2
cp gpu.sh MT_2
cp -frd 1-6-production-MUT/* MT_2/
cd MT_2
sbatch gpu.sh

mkdir MT_3
cp gpu.sh MT_3
cp -frd 1-6-production-MUT/* MT_3/
cd MT_3
sbatch gpu.sh

mkdir MT_4
cp gpu.sh MT_4
cp -frd 1-6-production-MUT/* MT_4/
cd MT_4
sbatch gpu.sh
