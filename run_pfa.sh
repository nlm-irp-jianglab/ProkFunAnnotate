#!/bin/bash
#SBATCH --cpus-per-task=32
#SBATCH --time=4:00:00

module load singularity
module load snakemake

snakemake -s annotate_snakemake --core 32 --use-singularity --singularity-args "\-B ./test_data2/egg_data/:/opt/egg_data/,./test_data2/kofam_data/:/opt/kofam_data/" --configfile config.yaml --latency-wait 10
