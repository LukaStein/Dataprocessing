configfile: "config/config.yaml"

rule TranscriptomeModeler:
  input:
    annotation = config['annotationGTF'],
    bam = config['output_dir'] + "mappingthereads/Aligned.sortedByCoord.out.bam"
  output: config['output_dir'] + "cufflinks_output/transcripts.gtf" 
  message:
    "Reconstructing and assembly of transcriptome... to {output}"
  log:
    "logs/TranscriptomeModeler.log"
  params:
    threads=30
  conda:
    "envs/getTools.yaml"
  shell:
    "cufflinks -p {params.threads} -g {input.annotation} " + f"-o {config['output_dir']}cufflinks_output/ " + "-u --library-type fr-firststrand {input.bam} 2> {log}"
