#!/bin/bash

# Load the samtools module
# module load samtools/1.2

# Directory containing CRAM files
CRAM_DIR="/mnt/storage10/pvenkatesh/Data/small_dataset/"

# Output directory for fastq files
FASTQ_DIR="/mnt/storage10/pvenkatesh/Data/small_dataset/"


# Convert each CRAM file to fastq format
for CRAM_FILE in "${CRAM_DIR}"/*.cram; do
    # Check if the file is a CRAM file
    if [[ -f "${CRAM_FILE}" ]]; then
        # Extract the file name without extension
        FILENAME=$(basename "${CRAM_FILE}")
        FILENAME_NO_EXT="${FILENAME%.*}"
        
         # Convert CRAM to fastq
        samtools fastq -@12 "${CRAM_FILE}" > "${FASTQ_DIR}/${FILENAME_NO_EXT}.fastq"

    fi
done



