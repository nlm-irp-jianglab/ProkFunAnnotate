# ProkFunAnnotate

ProkFunAnnotate is a snakemake pipeline designed to generate the annotation files that are used by the ProkFunFind search program (https://github.com/nlm-irp-jianglab/ProkFunFind). 

ProkFunAnnotate can generate these annotations from a set of genome fasta files, or from a set of genbank + fasta files. 

## ProkFunAnnotate Tutorial
A tutorial showing how to run ProkFunAnnotate is available as part of the ProkFunFind documentation here: https://prokfunfind.readthedocs.io/en/latest/tutorial/7-pfa.html



## Downaloading Annotation Databases
Download data used for eggnog_mapper and kofamscan: 

download_snakemake: snakemake script to download data used for eggnog_mapper and kofamscan

usage: 

    script provided in download.sh 
    snakemake script needs to be run with --use-singularity command line option
    snakemake script also needs a configuration option provided through the --config 
        command line argument. this configuration option should be in the format of
        "data_dir={dir_path}" with {dir_path} being a path to the output directory. 
    the script will make a directory specified through the data_dir option, and 
        produce an egg_data and kofam_data directory within this data directory. 
        these directories will be used by the PFA snakemake script to provide 
        access to the data needed by the annotation programs. 

## Annotating genomes using ProkFunAnnotate

annotate_snakemake: snakemake script to run the PFA annotation pipeline for list of genomes.

usage:

    script provided in run_pfa.sh
    snakemake script needs to be run with --use-singularity option
    snakemake script also needs to have the data files downloaded in by the download_snakemake
        script to be bound to the singularity image using the --singularity-args option
        to specify the directories like this:
	     "\-B ./data/egg_data/:/opt/egg_data/,./data/kofam_data:/opt/kofam_data/"
        the data directories should be mounted to /opt/egg_data/ and /opt/kofam_data/
    snakemake script needs to be run with one additional option specified through the --config
        option. The option should be provided like this: --config "genomes=genome_list.tsv" where
        genomes_list.tsv is the path to a file containing a two column tab separated table 
        containing the genome file names without extensions (e.g., "GCF_0000000.1" for a genome
        in a file "GCF_0000000.1.fna") and the second column containing the path to the
        directory containing the genome files. This table can have multiple entries. This
        path is also where the output will be generated for the annotation steps.  

annotate_gb_snakemake: Snakemake script to run the PFA annotation pipeline for a list of genbank files. 

Usage:

    script provided in run_pfa_gb.sh 
    Same as the annotate_snakemake pipeline, but the genome files provided consist of a contig 
    fasta file (extension '.fasta') and genbank file (extension '.gb') like those that can 
    be downloaded directly from the NCBI Genbank database. Running this pipeline will keep the genes
    found in the genbank file and keep the gene names from that file as well. 

NOTE: the memory, temporary directory, and threads used by each program can be set directly in the 
annotate_snakemake file. By deafult each rule will use 8 threads and up to 24GB of memory. 

