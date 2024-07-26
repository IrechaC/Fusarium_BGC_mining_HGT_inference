#test if there is at least one argument: if not, return an error
Fasta <- commandArgs(trailingOnly = TRUE)
if (length(Fasta)==0) {
  stop("At least one argument must be supplied", call. = FALSE)
}
#test for seqinr package installed
if (require("seqinr")==FALSE){
  install.packages("seqinr")
}

library(seqinr)
GC_Calculator <- function(Genome_Sequence){
Genome <- read.fasta(file = Genome_Sequence, seqtype = "DNA",
                     forceDNAtolower = TRUE)
total_gc <- 0
longitud_total <- 0
for (chromosome in 1:length(Genome)){
  
  
  longitud_chrom <- length(Genome[[chromosome]])
  longitud_total <- longitud_total + longitud_chrom
  for(i in 1:longitud_chrom){
    
    if (Genome[[chromosome]][i] == "g"|Genome[[chromosome]][i] == "c")
    {total_gc <- total_gc+1}
    
  }
}
GCmol=(((total_gc)/longitud_total)) * 100
print(paste ("The GC content of the sequence", Genome_Sequence, "is", GCmol, "mol%"))
}

GC_Calculator(Fasta)
