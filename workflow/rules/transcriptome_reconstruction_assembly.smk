configfile: "config/config.yaml"

rule TranscriptomeModeler:
  input:
    annotation=config['annotationGTF'],
    bam=config['output_dir'] + "mappingthereads/Aligned.sortedByCoord.out.bam"
  output: config['output_dir'] + "cufflinks_output/transcripts.gtf" 
  message:
    "Reconstructing and assembly of transcriptome... to {output}"
  log:
    "logs/TranscriptomeModeler.log"
  benchmark:
    "benchmarks/TranscriptomeModeler.benchmark.txt"
  params:
    threads=config['threads'],
    cufflinkDir=config['output_dir'] + "cufflinks_output"
  conda:
    "envs/getTools.yaml"
  shell:
    """
    mkdir -p {params.cufflinkDir} 
    cufflinks -p {params.threads} -g {input.annotation} -o {params.cufflinkDir} -u --library-type fr-firststrand {input.bam} 1> {log} 2> {log}
    """
