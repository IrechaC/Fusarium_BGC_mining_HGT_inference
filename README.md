# Master-Thesis-Analysis
This repository contains all the information comprising scripts, metadata and the overall pipeline that were carried out during the Fusarium project belonging to my masters thesis.
The pipeline follows the next steps:

- Database Construction
    - Download genome assemblies
    - Add general features (Genome size, Gene and GC content)
- Statistical analysis between features
- BGC Mining
    - FungiSMASH analysis
    - BiG-SCAPE analysis
    - Heatmap with BiG-SCAPE results
    - CORASON analysis
- Horizontal Gene Transfer (HGT) inference
  - Run Proteinortho
  - Single Copy Orthologs (SCO) phylogenetic reconstruction
  - Distance method implementation
 
## Software Required
The software required to perform all the analysis are as follows:

[Augustus](https://github.com/Gaius-Augustus/Augustus) 3.2.2

[Seqkit](https://github.com/shenwei356/seqkit) 2.3.0

[Antismash](https://github.com/antismash/antismash) 6.1.0

[BiGSCAPE](https://github.com/nselem/bigscape-corason) 1.1.2

[CORASON](https://github.com/nselem/bigscape-corason) 1.1.2

[proteinortho](https://gitlab.com/paulklemm_PHD/proteinortho) 6.1.0

[MAFFT](https://github.com/GSLBiotech/mafft) 7.0.0

[IQTree](https://github.com/Cibiv/IQ-TREE) 2.2.0

## Database Construction
The file Assemblies_list.txt contains all the accession numbers of the genome assemblies to be analized. Additionally, two more genome assemblies from a previous sequencing project identified as *F. verticillioides* S23 and *F. irregulare* 1A were included. Download the genome assemblies using the accession numbers and store them in a single directory:

First, install the ncbi-datasets package:

```bash
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets'
chmod +x datasets
```

Source: (https://www.ncbi.nlm.nih.gov/datasets/docs/v2/download-and-install/)

Then, use the [Download.Script.sh](Scripts/Download.Script.sh) to read the [Accessions_list.txt] and download all the assemblies files. Script originally taken from (https://github.com/asadprodhan/How-to-download-genomes-using-the-accession-number?tab=readme-ov-file). You must keep the script and the accessions list file in the same directory:

```bash
mkdir -p MyProject/Data/Raw.Genome.Sequences
mv Accessions_list.txt MyProject/Data/Raw.Genome.Sequences
mv Download.Script.sh MyProject/Data/Raw.Genome.Sequences
cd MyProject/Data/Raw.Genome.Sequences
ls
Accessions_list.txt
Download.Script.sh
./Download.Script.sh
```

At this point, you should have all the unziped fasta files corresponding to the genome sequences listed in Accessions_list.txt.

For further analysis, you will need two files per genome assembly:

- Fasta file containing only the predicted coding sequences
- GFF3 file containing the predticted annotation features.

Both files can be generated using Augustus prediction mode for each genome assembly. It is strongly recommended that you replace the default name of the files with a custom prefix easy to identify and manipulate from this point on. You can do it with the fasta files or with the augusutus results which are the actual files necessaries for the rest of the pipeline.

```bash
cd ~/MyProject/Data/
mkdir Augustus.Files/
cd Augustus.Files/

for genome in ../Raw.Genome.Sequences/*.fasta;
do;
augustus --species=fusarium --gff3=on ${genome} > ${CustomPrefix}.gff3;
done;
```

This command should produce the required GFF3 file per genome assembly. In order to obtain the fasta file containing the coding sequences we can use the [getAnnoFasta.pl](https://github.com/Gaius-Augustus/Augustus/blob/master/scripts/getAnnoFasta.pl) script belonging to the same package as follows:

```bash
perl getAnnoFasta.pl ${augustus_output}.gff3 --seqfile={genome_assembly}.fasta 
```

After executing the two previous commands, we should have the Fasta and GFF3 files per genome assembly neccessaries for the rest of the analysis.

The first analysis aims to compare three genomic features among the genome sequences. In order to achieve that, we calculated the size of each genome using Seqkit and store them in a .tsv file:

```bash
seqkit stats --infile-list <(find Directory_Containing_Assemblies/ -name "*.fasta") --tabular -o Size_fastas.tsv
```

Then, we manually calculated the gene content of each genome sequence by using the grep command with the coding sequence output from Augustus:

```bash
grep -c '>' *augustus_coding_sequence.fasta >> Genes_fastas.tsv
```

Finally, we use a custom R script ([GC_Calculator](scripts/GC_Calculator.R)) to calculate the GC content of each genome assembly. This script only requires the Seqinr package to work and can be recursively applied to several assemblies at once:

```bash
for sequence in *.fasta;
do;
RScript GC_Calculator.R ${sequence} >> GC_Content_info.txt
done;
```

This information, along with other relevant data from the repositories webpage, were merged into a single metadata file named [Fusarium_info.csv](Fusarium_info.csv), wich was henceforth used for the analysis.

```bash
mkdir MyProject/Data/Metadata
mv Fusarium_info.csv MyProject/Data/Metadata
```

## GC Content, Genome Size and Gene Content Comparison






