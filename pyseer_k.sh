#!/bin/bash

pyseer --lmm --phenotypes "/mnt/storage10/pvenkatesh/pyseer/pyseer_output/kmers/phenotypes_new/rifampicin_phenotypes.txt" --kmers "/mnt/storage10/pvenkatesh/kmers.pyseer.txt.gz" --similarity "/mnt/storage10/pvenkatesh/pyseer/pyseer_output/kmers/phylo_distance.tsv" --output-patterns kmer_patterns.txt --cpu 8 > rifampicin_kmers.tx
