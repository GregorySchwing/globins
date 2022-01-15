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
for i in {0..24..1}
  do 
     mkdir MT_CPU_$i
     cp cpu.sh MT_CPU_$i
     cp -frd 1-6-production-MUT/* MT_CPU_$i/
     cd MT_CPU_$i
     sbatch cpu.sh
 done


