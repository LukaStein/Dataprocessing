configfile: "config/config.yaml"

rule StarIndicing:
  input:
    genome=config['genome'],
    annotation=config['annotationGTF']
  output:
    starDir=directory(config['StargenomeDir']),
    index_complete=config['StargenomeDir'] + '.index_complete'
  message:
    "Indexing of genome to a large index file!... to " + config['StargenomeDir']
  log:
    "logs/StarIndicing.log"
  params:
    threads=30,
    sjdbOverhang=100
  conda:
    "envs/getTools.yaml"
  shell:
    "STAR --runThreadN {params.threads} --runMode genomeGenerate --genomeDir {output.starDir} --genomeFastaFiles {input.genome} --sjdbGTFfile {input.annotation} --sjdbOverhang {params.sjdbOverhang} --outFileNamePrefix {output.starDir} 2> {log}"
