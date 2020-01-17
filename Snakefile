configfile: "config.yaml"

rule all:
    input: "data/output/network.tsv"

rule actionet_rna:
    input:
        rnaSCE=config['scRNASCE'],
        script="scripts/run_actionet.R"
    output:
        ACTIONet_out="data/intermediate/rna.ACTIONet.out.rds"
    singularity:
        "docker://mfansler/mascara"
    shell:
        """
        {input.script} {input.rnaSCE}
        touch {output}
        """

rule cicero:
    input:
        atacSCE=config['scATACSCE'],
        gtf=config['gtfFile'],
        script="scripts/run_cicero.R"
    output:
        sce="data/intermediate/sce.inferredRNA.rds"
    params:
        genome=config['genome']
    singularity:
        "docker://mfansler/mascara"
    shell:
        """
        {input.script} {input.atacSCE} {input.gtf}
        touch {output}
        """


