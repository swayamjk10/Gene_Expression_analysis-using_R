# load libraries
library(dplyr)
library(tidyverse)
library(GEOquery)

# read in the data ---------
dataset <- read.csv(file = "GSE183947_fpkm.csv")
dim(dataset)

# get metadata --------
gse <- getGEO(GEO = 'GSE183947', GSEMatrix = TRUE)

gse

metadata <- pData(phenoData(gse[[1]]))
head(metadata)

# select, mutate, rename ------------
metadata.transform <- metadata %>%
  select(1,10,11,17) %>%
  rename(tissue = characteristics_ch1) %>%
  rename(metastasis = characteristics_ch1.1) %>%
  rename(tumor_sample = title) %>%
  mutate(tissue = gsub("tissue: ", "", tissue)) %>%
  mutate(metastasis = gsub("metastasis: ", "", metastasis)) 

head(dataset)

# reshaping data - from wide to long--------
dataset.long <- dataset %>%
  rename(gene = X) %>%
  gather(key = 'samples', value = 'FPKM', -gene) 
head(dataset.long)

# join dataframes = dat.long + metadata.modified

dataset.long <- dataset.long %>%
  left_join(., metadata.transform, by = c("samples" = "description")) 

head(dataset.long)

# filter, group_by, summarize and arrange 
dataset.long %>%
  filter(gene == 'BRCA1' | gene == 'BRCA2') %>%
  group_by(gene, tissue) %>%
  summarize(mean_FPKM = mean(FPKM),
            median_FPKM = median(FPKM)) %>%
  arrange(-mean_FPKM)





