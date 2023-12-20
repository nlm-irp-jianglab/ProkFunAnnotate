#!/bin/bash
#SBATCH --cpus-per-task=32
#SBATCH --time=4:00:00
#SBATCH --mem=24g
module load singularity
module load snakemake

snakemake -s ./annotate_gb_snakemake --core 32 --use-singularity --singularity-args "\-B ./data/egg_data/:/opt/egg_data/,./data/kofam_data/:/opt/kofam_data/" --config "genomes=./genome_list.tsv" --latency-wait 10
