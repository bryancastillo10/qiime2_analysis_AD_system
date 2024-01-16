## AD Metagenome Analysis
This repository is a demonstration of obtaining raw sequences from the NCBI database using the SRA-toolkit, followed by
passing through those sequences to QIIME pipeline for pre-processing, and some downstream processing as suggested by the 
reference study.

### Requirements
-   Linux Environment (WSL is also applicable)
-   QIIME2 2023.9 (Amplicon Distribution)
-   Python Libraries (pandas, numpy, matplotlib, seaborn)
-   Dokdo API in Jupyter Notebook Usage
    
### Data Retrieval and Preparation
```mermaid 
    flowchart TD;
    %% Colors %%
    classDef blue fill:#0072B2,stroke:#000,stroke-width:2px,color:#fff
    classDef yellow fill:#F0E442,stroke:#000,stroke-width:2px,color:#000

    %% Initial %%
    S1[(NCBI Database)]:::blue --> |from SRA| S21(FASTQ File):::yellow
    S21 --> |compiled into| S3(Manifest File):::yellow
    S1 --> |from BioSample| S22(Metadata):::yellow 
    S3 & S22 ==> Q[[QIIME2 Pipeline]]:::blue

    linkStyle 0,2 stroke:blue
 
```
  process_sra.sh is a shell script file available to perform the sequence retrieval and conversion of .sra to .fastq files


### QIIME2 Pipeline
```mermaid 
    flowchart TD;
    %% Color %%
    classDef green fill:#009E73,stroke:#000,stroke-width:2px,color:#fff
    classDef blue fill:#0072B2,stroke:#000,stroke-width:2px,color:#fff
    classDef yellow fill:#F0E442,stroke:#000,stroke-width:2px,color:#000

    %% Flow %%
    Q0([Import Data]):::yellow  --x Q1(Demultiplex):::blue
    Q1 --> Q2(Denoising):::blue
    Q2 ---o Q31([Feature Table]):::yellow 
    Q2 ---o Q32([Representative Sequences]):::yellow 
    Q32 --> Q7(Other Downstream Analysis):::green

    Q31 --> Q41(Diversity Analysis):::green
    Q31 --> Q42(Differential Abundance):::green 
    Q32 --> Q5(Alignment and Phylogeny):::blue
    Q5 --> Q6(Taxonomic Bar Plots):::green 

```

