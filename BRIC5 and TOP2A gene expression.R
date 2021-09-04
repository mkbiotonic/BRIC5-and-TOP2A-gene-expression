file.exists("E-GEOD-50760-experiment-design.tsv")

library(ggplot2)
library(ggpubr)

info = read.delim("E-GEOD-50760-experiment-design.tsv")
rownames(info) <- info$Run
keep <- c("Sample.Characteristic.biopsy.site.", "Sample.Characteristic.individual.")
info <- info[,keep]
colnames(info) <- c("tissueType", "individualID")
info$individualID <- factor(info$individualID)
head(info)


data = read.delim("E-GEOD-50760-raw-counts.tsv")
data = data[, -1]
mat1 = data
mat1 = aggregate(mat1[, 2:ncol(mat1)], list(mat1[,1]), mean)

rownames(mat1) = mat1[,1]
mat1 = mat1[,-1]

head(mat1)


data = mat1
#head(data)
data[1:5, 1:5]
data = round(data, 0)

identical(colnames(data), rownames(info))

#order the matrix using colnames
data = data[, order(colnames(data))]

#order the matrix using rownames
info = info[order(rownames(info)), ]

identical(colnames(data), rownames(info))


mat = cbind.data.frame(info, t(data[c("EGFR", "TOP2A"), ]))
head(mat)




ggplot(mat, aes(x = tissueType, y = EGFR)) + geom_boxplot()


ggplot(mat, aes(x = tissueType, y = TOP2A)) + geom_boxplot()


pdf("EGRF_TOP2AB.pdf")
ggplot(mat, aes(x = tissueType, y = EGFR)) + geom_boxplot()


ggplot(mat, aes(x = tissueType, y = TOP2A)) + geom_boxplot()
dev.off()
