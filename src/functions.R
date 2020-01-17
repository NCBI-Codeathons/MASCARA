run.ACTIONet.RNA <- function(sce.RNA) {
	sce.RNA = reduce.sce(sce.RNA)
	ACTIONet.out.RNA = run.ACTIONet(sce.RNA)

	return(ACTIONet.out.RNA)
}

run.ACTIONet.ATAC <- function(sce.ATAC) {
	assays(sce.ATAC)[["counts"]] = round(assays(sce.ATAC)[["counts"]]*1000000)

	sce.ATAC = reduce.sce(sce.ATAC)
	ACTIONet.out.ATAC = run.ACTIONet(sce.ATAC)

	return(ACTIONet.out.ATAC)
}

function(ACTIONet.out.RNA, ACTIONet.out.inferredRNA, top.genes = 200, archAnnot.RNA = NULL, archAnnot.inferredRNA = NULL) {
	if(is.null(archAnnot.RNA)) {
		archAnnot.RNA = paste("A", 1:ncol(ACTIONet.out.RNA$unification.out$cellstates.core), sep = "")
	}
	if(is.null(archAnnot.inferredRNA)) {
		archAnnot.inferredRNA = paste("A", 1:ncol(ACTIONet.out.inferredRNA$unification.out$cellstates.core), sep = "")
	}

	RNA.profile = ACTIONet.out.RNA$unification.out$cellstates.core
	inferredRNA.profile = ACTIONet.out.inferredRNA$unification.out$cellstates.core
	
	RNA.DE.profile = assays(ACTIONet.out.RNA$unification.out$DE.core)[["significance"]]
	inferredRNA.DE.profile = assays(ACTIONet.out.inferredRNA$unification.out$DE.core)[["significance"]]
	
	
	rs.RNA = Matrix::rowSums(RNA.profile)
	rs.inferredRNA = Matrix::rowSums(inferredRNA.profile)
	
	selected.genes = intersect(rownames(RNA.DE.profile)[rs.RNA > 0], rownames(inferredRNA.DE.profile)[rs.inferredRNA > 0])
	
	RNA.profile = RNA.profile[selected.genes, ]
	inferredRNA.profile = inferredRNA.profile[selected.genes, ]
	
	RNA.DE.profile = RNA.DE.profile[selected.genes, ]
	inferredRNA.DE.profile = inferredRNA.DE.profile[selected.genes, ]
	
	
	
	RNA.markers = lapply(1:ncol(RNA.DE.profile), function(j) rownames(RNA.DE.profile)[order(RNA.DE.profile[, j], decreasing = T)][1:top.genes])
	
	W = geneset.enrichment.gene.scores(inferredRNA.DE.profile, RNA.markers)
	
	
	ii = 1:nrow(W)
	jj = apply(W, 1, which.max)
	w = apply(W, 1, max)
	
	cellState.mappings = data.frame(RNA = ii, inferredRNA = jj, weight = w)
	
	GCN.RNA = cor(as.matrix(t(RNA.profile[, ii])))
	GCN.RNA.DE = lapply(ii, function(j) {
		print(j)
		x = RNA.DE.profile[, j]
		x = x / max(x)
		GCN = sqrt(x %*% t(x))
	})
	GCN.RNA.DE.reweighted = lapply(GCN.RNA.DE, function(GCN) GCN * GCN.RNA)
	names(GCN.RNA.DE.reweighted) = names(GCN.RNA.DE) = archAnnot.RNA[ii]
	
	
	GCN.inferredRNA = cor(as.matrix(t(inferredRNA.profile[, jj])))
	GCN.inferredRNA.DE = lapply(jj, function(j) {
		print(j)
		x = inferredRNA.DE.profile[, j]
		x = x / max(x)
		GCN = sqrt(x %*% t(x))
	})
	GCN.inferredRNA.DE.reweighted = lapply(GCN.inferredRNA.DE, function(GCN) GCN * GCN.inferredRNA)
	names(GCN.inferredRNA.DE.reweighted) = names(GCN.inferredRNA.DE) = archAnnot.inferredRNA[jj]
	
	TF2cell.mat = assays(sce.chromVAR)[["z"]]
	TF2cellstates.mat = TF2cell.mat %*% ACTIONet.out.inferredRNA$unification.out$C.core
	
	res = list(RNA.GCN = GCN.RNA.DE.reweighted, ATAC.GCN = GCN.inferredRNA.DE.reweighted, prioritized.TFs = TF2cellstates.mat)

	saveRDS(res, file = "final_networks.RDS")
	
	return(res)
}
