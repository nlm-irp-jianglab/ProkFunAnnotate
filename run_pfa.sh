#!/bin/bash
#SBATCH --cpus-per-task=32
#SBATCH --time=4:00:00

module load singularity
module load snakemake

snakemake --core 4 --use-singularity --singularity-args "\-B ./data/egg_data/:/opt/egg_data/,./data/kofam_data/:/opt/kofam_data/" --configfile config.yaml --latency-wait 10
