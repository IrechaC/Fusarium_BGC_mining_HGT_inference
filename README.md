# Master-Thesis-Analysis
This repository contains all the information comprising scripts, metadata and procedures that were carried out during the Fusarium project belonging to my masters thesis.
## Software Required
The software requiered to perform all the analysis are as follows:

[Augustus](https://github.com/Gaius-Augustus/Augustus) 3.2.2

[Antismash](https://github.com/antismash/antismash) 6.1.0

[BiGSCAPE](https://github.com/nselem/bigscape-corason) 1.1.2

[CORASON](https://github.com/nselem/bigscape-corason) 1.1.2

[proteinortho](https://gitlab.com/paulklemm_PHD/proteinortho) 6.1.0

## Database Construction
The file Fusarium_info contains relevant information about the genome assemblies used in this project. The column GenBank comprises all the accession numbers of the genome assemblies that were used, and te values show N/A when the assembly was not available through public repositories. The genome assemblies were downloaded using the accession numbers and stored in a single directory along with the extra genomes belonging to this and previous projects.

For further analysis, we will need two files per genome assembly:

- Fasta file containing only the predicted coding sequences
- GFF3 file containing the predticted annotation features.

Both files were generated using Augustus prediction mode for each genome assembly as follows:
```bash
for genome in *.fasta;
do;
augustus --species=fusarium --gff3=on ${genome} > ${CustomPrefix}_augustus.gff3;
done;
```
This command should produce the requiered GFF3 file per genome assembly. In order to obtain the fasta file containing the coding sequences we can use the [getAnnoFasta.pl](https://github.com/Gaius-Augustus/Augustus/blob/master/scripts/getAnnoFasta.pl) script belonging to the same package as follows:
```bash
perl getAnnoFasta.pl ${augustus_output}.gff --seqfile={genome_assembly}.fasta 
```
