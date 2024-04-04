configfile: "config/config.yaml"

rule plot_geneExpressions:
  input:
    geneExpressions = config['expressions'] + 'Quant.genes.results', 
    transcriptsExpressions = config['expressions'] + 'Quant.isoforms.results',
    additionalFiles = config['expressions'] + 'Quant.stat'
  output:
    config['histogram'] + 'TPM_gene_expressions.png'
  message:
    'Creating gene expression histogram... to {output}'
  log:
    "logs/plot_geneExpressions.log"
  shell:
    "Rscript scripts/plot_expressions.R {input.geneExpressions} {output} 2> {log}"
