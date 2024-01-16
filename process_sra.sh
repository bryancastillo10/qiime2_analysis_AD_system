mkdir fetch_sra
cd fetch_sra

#accession number of the target gene
prefetch  PRJDB12248
cd -

mkdir -p raw

for sra_files in fetch_sra/*/*.sra; do
    sra_accession=$(basename "$sra_files".sra)
    fastq-dump --gzip --outdir raw --split-files "$sra_files"
done


