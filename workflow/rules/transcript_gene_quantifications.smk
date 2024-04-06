configfile: "config/config.yaml"
RSEMdir=config['output_dir'] + "RSEM_output/"

rule T_G_Quantifications:
  input:
    genome=config['genome'],
    annotation=config['annotationGTF']
  output:
    RSEMref_grp=RSEMdir + "RSEMref.grp",
    RSEMref_chrl=RSEMdir + "RSEMref.chrlist",
    RSEMref_n2g_idx=RSEMdir + "RSEMref.n2g.idx.fa",
    RSEMref_idx=RSEMdir + "RSEMref.idx.fa",
    RSEMref_ti=RSEMdir + "RSEMref.ti",
    RSEMref_seq=RSEMdir + "RSEMref.seq",
    RSEMref_transcripts=RSEMdir + "RSEMref.transcripts.fa"
  message:
    "Quantifying expression of transcripts and genes... 7 files to" + RSEMdir
  log:
    "logs/T_G_Quantifications.log"
  benchmark:
    "benchmarks/T_G_Quantifications.benchmark.txt"
  conda:
    "envs/getTools.yaml"
  threads: config['threads']
  params: 
    RSEMdir=config['output_dir'] + "RSEM_output"
  shell:
    """
    mkdir -p {params.RSEMdir} 
    rsem-prepare-reference --gtf {input.annotation} {input.genome} {params.RSEMdir}/RSEMref 1> {log} 2> {log}
    """
