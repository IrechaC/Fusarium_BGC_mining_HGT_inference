library(tictoc)
setwd("/home/irecha/Genomas/Fastas_Genomic_compressed/")
Genomas <- list.files()
GC <- c()
New_GC_DF <- data.frame(Name = as.character(Genomas), GC_Content = 0)
tic()
for (fasta in Genomas) {
  
  Genome <- read.fasta(file = fasta, seqtype = "DNA",
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
    print(paste (fasta,"GC content is", GCmol, "mol%"))
    GC <- c(GC, GCmol)
}
toc()