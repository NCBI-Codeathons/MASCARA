configfile: "config.yaml"

rule all:
    input: "data/output/network.tsv"

rule actionet_rna:
    input:
        rnaSCE=config['scRNASCE'],
        script="scripts/run_actionet.R"
    output:
        de="data/intermediate/rna.de.genes.rds",
        geneState="data/intermediate/rna.gene.cellstate.rds",
        tfState="data/intermediate/rna.tf.cellstate.rds"
    params:
        genome=config['genome']
    singularity:
        "docker://mfansler/mascara"
    shell:
        """
        {input.script} {input.rnaSCE} {params.genome}
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


