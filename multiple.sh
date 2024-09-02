#!/bin/bash

# Set the reference genome file
REFERENCE="/mnt/storage10/pvenkatesh/Data/Reference_genome/MTB-h37rv_asm19595v2-eg18.fa"

CRAM_LST="/mnt/storage10/pvenkatesh/Data/Variant_calling/lst_1000.txt"

VCF_FILE="/mnt/storage10/pvenkatesh/Data/Variant_calling/joint.vcf.gz"

# variant calling using joit variant calling

bcftools mpileup -Ou -f "$REFERENCE" -b "$CRAM_LST" | bcftools call -m --ploidy 1 -Oz -o "$VCF_FILE"

# for normalisation
bcftools norm -m -v"/mnt/storage10/pvenkatesh/kmer_new/VCF_bcf.anno.called.vcf" > VCF_anno_variant_persite.vcf


