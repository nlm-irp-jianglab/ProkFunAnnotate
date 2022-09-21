samples = []
samples_names = {}
for line in open(config['genomes']).readlines(): 
   samples.append(line.strip())
   ssplit = line.strip().split('/')
   name = ssplit[-1]
   path = "/".join(ssplit[:-1])+"/"
   samples_names['./'+line.strip()] = (name, path)

print(samples_names)



rule all:
   input:
      expand("./{sample}.gff3",sample=samples)#,
      #expand("./{sample}.kofam.tsv",sample=samples)#,
      #"{}.emapper.annotations".format(config["outdir"]),
      #"{}_InterProScan.tsv".format(config["outdir"])
      


rule run_prokka: 
   singularity: "docker://keithdt/prokfunannotate:latest"
   input: "{sample}.fna"
   output: 
      "{sample}.gff3",
      "{sample}.faa"
   params:
      cpus    = config.get("cpus", "2"),
      prefix  = lambda wildcards: samples_names[wildcards.sample][0],
      outdir  = lambda wildcards: samples_names[wildcards.sample][1]
   shell:
      """
      prokka --force --cpus {params.cpus} --prefix {params.prefix} --outdir {params.outdir} {input}
      """


rule run_emapper:
   singularity: "docker://keithdt/prokfunannotate:latest"
   input: "{sample}.faa"
   output: "{sample}.emapper.annotations"
   params:
      cpus    = config.get("cpus", "2"),
      tmp     = config.get("temp_dir", "/tmp/")
   shell:
      "emapper.py -i {input} -o {output} --temp_dir {params.tmp}  --data_dir /opt/egg_data/ --cpu {params.cpus}"

rule run_kofamscan:
   singularity: "docker://keithdt/prokfunannotate:latest"
   input: "{sample}.faa"
   output: "{sample}.kofam.tsv"
   params:
      cpus    = config.get("cpus", "2"),
      tmp = config.get("temp_dir", "/tmp/")
   shell:
      "exec_annotation --tmp-dir {params.tmp} -f detail-tsv -p /opt/kofam_data/profiles/ --ko-list /opt/kofam_data/ko_list --cpu {params.cpus} -o {output} {input}"

