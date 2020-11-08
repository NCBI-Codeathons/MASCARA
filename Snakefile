configfile: "config.yaml"

rule all:
    input: "data/output/final.rds"

rule actionet_rna:
    input:
        rnaSCE=config['scRNASCE'],
        script="scripts/run_actionet.R"
    output:
        ACTIONet_out="data/intermediate/rna.ACTIONet.out.rds"
    singularity:
        "docker://dmbala/mascara"
    shell:
        """
        {input.script} {input.rnaSCE}
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
        "docker://dmbala/mascara"
    shell:
        """
        {input.script} {input.atacSCE} {input.gtf}
        """

rule chromVAR:
    input:
        script="scripts/run_chromVAR.R",
        atacSCE=config['scATACSCE']
    output:
        sce="data/intermediate/sce.chromVAR.rds"
    singularity:
        "docker://dmbala/mascara"
    shell:
        """
        {input.script} {input.atacSCE}
        """
        
rule actionet_inferred_rna:
    input:
        rnaSCE="data/intermediate/sce.inferredRNA.rds",
        script="scripts/run_actionet_inferredRNA.R"
    output:
        ACTIONet_out="data/intermediate/ACTIONet_out_inferredRNA.rds"
    singularity:
        "docker://dmbala/mascara"
    shell:
        """
        {input.script} {input.rnaSCE}
        """

rule run_match_cellstates:
    input:
        script="scripts/run_match_cellstates.R",
        sceRNA="data/intermediate/rna.ACTIONet.out.rds",
        sceInferredRNA="data/intermediate/ACTIONet_out_inferredRNA.rds",
        sceChromVAR="data/intermediate/sce.chromVAR.rds"
    output:
        "data/output/final.rds"
    singularity:
        "docker://dmbala/mascara"
    shell:
        """
        Rscript {input.script} {input.sceRNA} {input.sceInferredRNA} {input.sceChromVAR}
        """
