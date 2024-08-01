#!/bin/bash

file=$1

prefix=$(echo $file | cut -d'.' -f1)
gff_file=${prefix}_augustus.gff

perl ~/Tesis_Analisis/Otros_scripts/getAnnoFasta.pl $gff_file --seqfile=$file
