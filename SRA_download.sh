#!/bin/env sh

#PBS -l mem=12gb,nodes=1:ppn=1,walltime=24:00:00 
#PBS -m abe 
#PBS -M mfrodrig@umn.edu 
#PBS -q lab

#   Filepaths provided by user:
#   Location of SRA download script, from Tom Kono's Misc_Utils
SRA_FETCH=${HOME}/software/tkono/Misc_Utils/SRA_Fetch.sh
#   Directory where SRA files will be downloaded
OUTPUT=/scratch/fernanda/baseline
#   Collect file from command line
SRA_FILES=${HOME}/baseline/SRR_Acc_List-2.txt

#   Make sure the file exists
if ! [[ -f "${SRA_FILES}" ]]
    then echo "Failed to find ${SRA_FILES}, exiting..." >&2
    exit 1
    fi 

#   Make the array using command substitution
declare -a SRA_ARRAY=($(cat "${SRA_FILES}")) 

#   Print the values of the array to screen
printf '%s\n' "${SRA_ARRAY[@]}"

#   Iterate over every each of the run numbers in a lit of SRA files
#   and download to specified directory
for i in "${SRA_ARRAY[@]}"
    #   -r option means provided accession is a run number
    #   -d option outputs all SRA files into OUTPUT
    do bash $SRA_FETCH -r $i -d $OUTPUT
    done