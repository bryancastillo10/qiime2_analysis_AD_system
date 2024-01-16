# This section shows the list of QIIME2 commands used in this project

# Make Output Folder
mkdir output

# Importing Raw FastQ File
qiime tools import --type 'SampleData[PairedEndSequencesWithQuality]' \
    --input-path manifest.tsv \
    --output-path output/paired-end-sample.qza \
    --input-format PairedEndFastqManifestPhred33V2


# DADA2 Paired-End Denoising
qiime dada2 denoise-paired \
    --i-demultiplexed-seqs output/paired-end-sample.qza \
    --p-trunc-len-f 300 --p-trim-left-f 17 \
    --p-trunc-len-r 255 --p-trim-left-r 21 \
    --o-representative-sequences output/rep-seqs.qza \
    --o-table output/table.qza \
    --o-denoising-stats output/dada2-stats.qza

# Feature Table Summarize and Tabulation
qiime feature-table summarize \
  --i-table output/table.qza \
  --o-visualization output/table.qzv \
  --m-sample-metadata-file sample-metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data output/rep-seqs.qza \
  --o-visualization output/rep-seqs.qzv

# Phylogenetic Tree Analysis
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences output/rep-seqs.qza \
  --o-alignment output/aligned-rep-seqs.qza \
  --o-masked-alignment output/masked-aligned-rep-seqs.qza \
  --o-tree output/unrooted-tree.qza \
  --o-rooted-tree output/rooted-tree.qza

# Alpha Rarefaction Curve
qiime diversity alpha-rarefaction \
  --i-table output/table.qza \
  --i-phylogeny output/rooted-tree.qza \
  --p-max-depth 2952 \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization output/alpha-rarefaction.qzv 

# Taxonomy
# requires to download the pre-trained Classifier or train your own Naive-Bayes Classifier
# gg-13-8-99-nb-classifier.qza 
qiime feature-classifier classify-sklearn \
  --i-classifier gg_2022_10_backbone_full_length.nb.qza \
  --i-reads output/rep-seqs.qza \
  --o-classification output/taxonomy.qza


qiime metadata tabulate \
  --m-input-file output/taxonomy.qza \
  --o-visualization output/taxonomy.qzv

qiime taxa barplot \
  --i-table output/table.qza \
  --i-taxonomy output/taxonomy.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization output/taxa-bar-plots.qzv

### By Relative Abundance
qiime taxa collapse \
  --i-table output/table.qza \
  --i-taxonomy output/taxonomy.qza \
  --p-level 4 \
  --o-collapsed-table output/order-taxa.qza

qiime feature-table relative-frequency \
  --i-table output/order-taxa.qza \
  --o-relative-frequency-table output/order-taxa.qza

qiime metadata tabulate \
  --m-input-file output/order-taxa.qza \
  --o-visualization output/order-taxa.qzv

qiime feature-table heatmap \
  --i-table output/table.qza \
  --m-sample-metadata-file sample-metadata.tsv \
  --m-sample-metadata-column Loading\
  --p-metric 'euclidean' \
  --p-color-scheme 'BuGn' \
  --o-visualization output/heatmap.qzv