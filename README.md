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
The file Fusarium_info contains relevant information about the genome assemblies used in this project. The column GenBank comprises all the accession numbers of the genome assemblies that were used, and te values show N/A when the assembly was not available. The genome assemblies were annotated using Augustus

```bash
augustus --gene
```
