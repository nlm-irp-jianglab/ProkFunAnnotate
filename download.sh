#!/bin/bash
#SBATCH --cpus-per-task=4
#SBATCH --time=4:00:00

module load singularity
module load snakemake

snakemake -s download_snakemake --use-singularity --cores 4 --config "data_dir=test_data2"
