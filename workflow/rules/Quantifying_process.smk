configfile: "config/config.yaml"

rule Quantification_Process:
  input:
    RSEMref_grp = config['output_dir'] + "RSEM_output/RSEMref.grp",
    RSEMref_chrl = config['output_dir'] + "RSEM_output/RSEMref.chrlist",
    RSEMref_n2g_idx = config['output_dir'] + "RSEM_output/RSEMref.n2g.idx.fa",
    RSEMref_idx = config['output_dir'] + "RSEM_output/RSEMref.idx.fa",
    RSEMref_ti = config['output_dir'] + "RSEM_output/RSEMref.ti",
    RSEMref_seq = config['output_dir'] + "RSEM_output/RSEMref.seq",
    RSEMref_transcripts = config['output_dir'] + "RSEM_output/RSEMref.transcripts.fa",
    transcriptomeBam = config['output_dir'] + "mappingthereads/Aligned.toTranscriptome.out.bam"
  output:
    config['expressions'] + "Quant.genes.results",
    config['expressions'] + "Quant.isoforms.results",
    directory(config['expressions'] + "Quant.stat")
  message:
    "Calculating expressions... to " + config['expressions']
  log:
    "logs/Quantification_Process.log"
  params:
    threads=40,
    seed=12345,
    memory=30000,
    fprob=0
  conda:
    "envs/getTools.yaml"
  shell:
    "rsem-calculate-expression --bam --no-bam-output --estimate-rspd --calc-ci --seed {params.seed} -p {params.threads} --ci-memory {params.memory} --paired-end --forward-prob {params.fprob} {input.transcriptomeBam} " + f"{config['output_dir']}RSEM_output/RSEMref {config['expressions']}Quant " + "2> {log}"
