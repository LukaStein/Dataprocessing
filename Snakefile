configfile: "config/config.yaml"

include: "workflow/rules/STARindices.smk"
include: "workflow/rules/Mapping_the_Reads.smk"
include: "workflow/rules/transcriptome_reconstruction_assembly.smk"
include: "workflow/rules/transcript_gene_quantifications.smk"
include: "workflow/rules/Quantifying_process.smk"
include: "workflow/rules/plot_geneExpressions.smk"

rule all:
  input:
    config['histogram'] + 'TPM_gene_expressions.png'

	
