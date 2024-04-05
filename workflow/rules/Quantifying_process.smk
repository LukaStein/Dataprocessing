configfile: "config/config.yaml"
RSEMfiles=config['output_dir'] + "RSEM_output/RSEMref"
expressionsDir=config['output_dir'] + "RSEM_output/RSEM_expressions/"

rule Quantification_Process:
  input:
    RSEMref_grp=RSEMfiles + ".grp",
    RSEMref_chrl=RSEMfiles + ".chrlist",
    RSEMref_n2g_idx=RSEMfiles + ".n2g.idx.fa",
    RSEMref_idx=RSEMfiles + ".idx.fa",
    RSEMref_ti=RSEMfiles + ".ti",
    RSEMref_seq=RSEMfiles + ".seq",
    RSEMref_transcripts=RSEMfiles + ".transcripts.fa",
    transcriptomeBam = config['output_dir'] + "mappingthereads/Aligned.toTranscriptome.out.bam"
  output:
    expressionsDir + "Quant.genes.results",
    expressionsDir + "Quant.isoforms.results",
    directory(expressionsDir + "Quant.stat")
  message:
    "Calculating expressions... to " + expressionsDir
  log:
    "logs/Quantification_Process.log"
  benchmark:
    "benchmarks/Quantification_Process.benchmark.txt"
  params:
    threads=config['threads'],
    seed=12345,
    memory=30000,
    fprob=0,
    expressionsDir=config['output_dir'] + "RSEM_output/RSEM_expressions",
    RSEMfiles=config['output_dir'] + "RSEM_output/RSEMref"
  conda:
    "envs/getTools.yaml"
  shell:
    """
    mkdir -p {params.expressionsDir} 
    rsem-calculate-expression --bam --no-bam-output --estimate-rspd --calc-ci --seed {params.seed} -p {params.threads} --ci-memory {params.memory} --paired-end --forward-prob {params.fprob} {input.transcriptomeBam} {params.RSEMfiles} {params.expressionsDir}/Quant 2> {log}
    """
