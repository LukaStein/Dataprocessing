configfile: "config/config.yaml"
expressionsDir=config['output_dir'] + "RSEM_output/RSEM_expressions/"

rule plot_geneExpressions:
  input:
    geneExpressions=expressionsDir + 'Quant.genes.results', 
    transcriptsExpressions=expressionsDir + 'Quant.isoforms.results',
    additionalFiles=expressionsDir + 'Quant.stat'
  output:
    config['histogram'] + 'TPM_gene_expressions.png'
  message:
    'Creating gene expression histogram... to {output}'
  log:
    "logs/plot_geneExpressions.log"
  benchmark:
    "benchmarks/plot_geneExpressions.benchmark.txt"
  shell:
    "Rscript scripts/plot_expressions.R {input.geneExpressions} {output} 2> {log}"
