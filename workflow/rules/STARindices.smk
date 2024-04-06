configfile: "config/config.yaml"

rule StarIndicing:
  input:
    genome=config['genome'],
    annotation=config['annotationGTF']
  output:
    starDir=directory(config['StargenomeDir']),
    index_complete=config['output_dir'] + '.index_complete'
  message:
    "Indexing of genome to a large index file!... to " + config['StargenomeDir']
  log:
    "logs/StarIndicing.log"
  benchmark:
    "benchmarks/StarIndicing.benchmark.txt" 
  params:
    threads=config['threads'],
    sjdbOverhang=100
  conda:
    "envs/getTools.yaml"
  shell:
    """
    mkdir -p {output.starDir}
    STAR --runThreadN {params.threads} --runMode genomeGenerate --genomeDir {output.starDir} --genomeFastaFiles {input.genome} --sjdbGTFfile {input.annotation} --sjdbOverhang {params.sjdbOverhang} --outFileNamePrefix {output.starDir} 1> {log} 2> {log}
    touch {output.index_complete}
    """
