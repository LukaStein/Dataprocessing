if(!require(ggplot2)){
    install.packages("ggplot2")
    library(ggplot2)
}

args = commandArgs(trailingOnly=TRUE)
gene.results <- read.table(file=args[1], sep = "\t", header = TRUE)

expressed.genes <- log2(gene.results$TPM[gene.results$TPM > 0])
expressions.df <- data.frame(expressions=expressed.genes)
png(args[2])
p <- ggplot(expressions.df, aes(x=expressions)) + 
  geom_histogram(colour="black", fill="skyblue", bins=40) 

p + geom_vline(aes(xintercept=mean(expressions)),
               color="red", linetype="dashed", linewidth=1)  + ggtitle("Log2 gene expressions counts for TPM > 0")
dev.off()
