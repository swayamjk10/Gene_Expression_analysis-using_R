library(ggplot2)

# 1. barplot
# for BRCA1
pdf("barplot_expression_samples_brca1.pdf", width = 10, height = 8)
dataset.long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(., aes(x = samples, y = FPKM, fill = tissue)) +
  geom_col() +
  labs(title = "Expression of BRCA1 samples",
       x = "Samples",
       y = "FPKM")
dev.off()

# for BRCA2
pdf("barplot_expressiona_samples_brca2.pdf", width = 10, height = 8)
dataset.long %>%
  filter(gene == 'BRCA2') %>%
  ggplot(., aes(x = samples, y = FPKM, fill = tissue)) +
  geom_col() +
  labs(title = "Expression of BRCA2 samples",
       x = "Samples",
       y = "FPKM")
dev.off()

# 2. density plots
# for BRCA1
pdf("densityplot_brca1.pdf", width = 10, height = 8)
dataset.long %>%
  filter(gene == 'BRCA1') %>%
  ggplot(., aes(x = FPKM, fill = tissue)) +
  geom_density(alpha = 0.4) +
  labs(title = "Expression of BRCA1 samples",
       x = "Samples",
       y = "FPKM")
  theme_minimal()
dev.off()

# for BRCA2
pdf("densityplot_brca2.pdf", width = 10, height = 8)
dataset.long %>%
  filter(gene == 'BRCA2') %>%
  ggplot(., aes(x = FPKM, fill = tissue)) +
  geom_density(alpha = 0.4) +
  theme_minimal()
dev.off()

# box plots
#density plots for gene expression for tissue & metastasis
dataset.brcas <- dataset.long %>%
  filter(gene %in% c('BRCA1', 'BRCA2')) 

#box plot for gene expression for tissue
pdf("boxplot_tissue.pdf", width = 10, height = 8)
  ggplot(dataset.brcas, aes(x = gene, y = FPKM, fill = tissue)) + 
  geom_boxplot() +
  theme_minimal()
dev.off()
 
#box plot for gene expression for metastasis
pdf("boxplot_metastasis.pdf", width = 10, height = 8)
  ggplot(dataset.brcas, aes(x = gene, y = FPKM, fill = metastasis)) + 
    geom_boxplot() +
    theme_minimal()
  dev.off()
  
# 4. scatterplot
pdf("scatterplot.pdf", width = 10, height = 8)
  dataset.long %>%
    filter(gene == 'BRCA1' | gene == 'BRCA2') %>%
    spread(key = gene, value = FPKM) %>%
    ggplot(., aes(x = BRCA1, y = BRCA2, color = tissue)) +
    geom_point() +
    geom_smooth(method = 'lm', se = FALSE)
dev.off()
  
# 5. heatmap for gene expression
  genes.of.interest <- c('BRCA1', 'BRCA2', 'TP53', 'ZNF559', 'ERBB2', 'ALK', 'MYCN')
  
  pdf("heatmap_gene_expression.pdf", width = 10, height = 8)
  dataset.long %>%
    filter(gene %in% genes.of.interest) %>%
    ggplot(., aes(x = samples, y = gene, fill = FPKM)) +
    labs(title = "Expression of specific breast cancer related genes in samples",
         x = "Samples",
         y = "Genes") +
    geom_tile() +
    scale_fill_gradient(low = 'white', high = 'green')
  
  dev.off()



