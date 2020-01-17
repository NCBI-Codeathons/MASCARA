mascara_atac<-function(sce_file="PBMC/scATAC-Healthy-Hematopoiesis-191120.rds",gtf="PBMC/Homo_sapiens.GRCh37.87.gtf",chsz="PBMC/hg19.chrom.sizes"){
		## Dependencies
		require(SingleCellExperiment)
		require(cicero)
		require(monocle3)

		## Format conversion
		sce<-as(readRDS(sce_file),Class="SingleCellExperiment")
		pk = rowRanges(sce)
		mtx = assays(sce)[["counts"]]
		cll = colnames(sce)
		mtx_conv<-as(mtx, 'dgTMatrix')
		pk_df<-data.frame((pk))
		peak.label  = paste(pk_df$seqnames, pk_df$start, pk_df$end, sep = "_")
		df = data.frame(Peak=peak.label[mtx_conv@i+1],Cell=cll[mtx_conv@j+1],Count=as.numeric(mtx_conv@x),stringsAsFactors = FALSE)
		mtx_conv.CDS = make_atac_cds(df, binarize = FALSE)
		
		## Reduction of dimension
		set.seed(2020) # this is for reproducibility
		mtx_conv.CDS<-detect_genes(mtx_conv.CDS)
		mtx_conv.CDS<-estimate_size_factors(mtx_conv.CDS)
		mtx_conv.CDS<-preprocess_cds(mtx_conv.CDS, norm_method = "none") # Because monocle3 is installed
		mtx_conv.CDS <- reduce_dimension(mtx_conv.CDS, max_components = 2, num_dim=6,reduction_method = 'tSNE', norm_method = "none")
		tsne_coords <- reducedDim(mtx_conv.CDS,type="tSNE")
		row.names(tsne_coords) <- row.names(pData(mtx_conv.CDS))
		cicero_cds <- make_cicero_cds(mtx_conv.CDS, reduced_coordinates = tsne_coords)
		
		## Interaction Network
		chr_sizes<-read.table(chsz)
	conns <- run_cicero(cicero_cds,chr_sizes)
		
		## Gene annotation file import
		gene_anno <- rtracklayer::readGFF(gtf) 
		gene_anno$chromosome <- paste0("chr", gene_anno$seqid)
		gene_anno$gene <- gene_anno$gene_id
		gene_anno$transcript <- gene_anno$transcript_id
		gene_anno$symbol <- gene_anno$gene_name

		## Gene expression prediction
		pos <- subset(gene_anno, strand == "+")
		pos <- pos[order(pos$start),]
		pos <- pos[!duplicated(pos$transcript),]
		pos$end <- pos$start + 1
		neg <- subset(gene_anno, strand == "-")
		neg <- neg[order(neg$start, decreasing = TRUE),]
		neg <- neg[!duplicated(neg$transcript),]
		neg$start <- neg$end - 1
		gene_annotation_sub <- rbind(pos, neg)
		gene_annotation_sub <- gene_annotation_sub[,c("chromosome","start","end","gene")]
		mtx_conv.CDS <- annotate_cds_by_site(mtx_conv.CDS, gene_annotation_sub)
		unnorm_ga <- build_gene_activity_matrix(mtx_conv.CDS, conns)
		unnorm_ga <- unnorm_ga[!Matrix::rowSums(unnorm_ga) == 0, !Matrix::colSums(unnorm_ga) == 0]
		num_genes <- pData(mtx_conv.CDS)$num_genes_expressed
		names(num_genes) <- row.names(pData(mtx_conv.CDS))
		cicero_gene_activities <- normalize_gene_activities(unnorm_ga, num_genes)

		## Conversion to sce
		sce_output<-SingleCellExperiment(assays=list(counts=cicero_gene_activities)))
		return(sce_output)
}