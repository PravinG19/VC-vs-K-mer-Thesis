#!/bin/bash

#Pyseer for / change the file accordingly to phenotype[rifampicin, ethambutol and etc)
pyseer --phenotypes "/mnt/storage10/pvenkatesh/pyseer/pyseer_output/variant_calling/phenotypes_new/rifampicin_phenotypes.txt" \
 --vcf "/mnt/storage10/pvenkatesh/pyseer/pyseer_output/variant_calling/VCF_anno_variant_persite.vcf" \
 --distances "/mnt/storage10/pvenkatesh/pyseer/pyseer_output/variant_calling/phylogeny_k.tsv" --min-af 0.02 --max-af 0.98  > rifampicin_SNPs.txt

#filter based on the above files 
cat <(echo "#CHR.SNP.BP.minLOG10(P).log10(p).r^2") <(paste <(sed '1d' rifampicin_SNPs.txt| cut -d "_" -f 2) <(sed '1d' rifampicin_SNPs.txt | cut -f 4) | awk '{p = -log($2)/log(10); print "26",".",$1,p,p,"0"}') | tr ' ' '\t' > rifampicin_snps.plot
