configfile: "config/config.yaml"

rule T_G_Quantifications:
  input:
    genome = config['genome'],
    annotation = config['annotationGTF']
  output:
    RSEMref_grp = config['output_dir'] + "RSEM_output/RSEMref.grp",
    RSEMref_chrl = config['output_dir'] + "RSEM_output/RSEMref.chrlist",
    RSEMref_n2g_idx = config['output_dir'] + "RSEM_output/RSEMref.n2g.idx.fa",
    RSEMref_idx = config['output_dir'] + "RSEM_output/RSEMref.idx.fa",
    RSEMref_ti = config['output_dir'] + "RSEM_output/RSEMref.ti",
    RSEMref_seq = config['output_dir'] + "RSEM_output/RSEMref.seq",
    RSEMref_transcripts = config['output_dir'] + "RSEM_output/RSEMref.transcripts.fa"
  message:
    "Quantifying expression of transcripts and genes... 7 files to " + f"{config['output_dir']}RSEM_output/RSEMref"
  log:
    "logs/T_G_Quantifications.log"
  conda:
    "envs/getTools.yaml"
  threads: 30
  shell:
    "rsem-prepare-reference --gtf {input.annotation} {input.genome} " + f"{config['output_dir']}RSEM_output/RSEMref " + "2> {log}"
