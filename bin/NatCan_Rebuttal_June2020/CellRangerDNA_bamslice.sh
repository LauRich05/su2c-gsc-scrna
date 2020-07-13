#!/bin/bash
#SBATCH -t 24:00:00
#SBATCH --mem=60G
#SBATCH -p himem
#SBATCH -c 30
#SBATCH -N 1
#SBATCH --account=pughlab

##############################################################
#             Split 10X Genomics Bam using bamslice          #
#                         L.Richards                         #
#                         July 2020                          #
##############################################################
### Reference: https://support.10xgenomics.com/single-cell-dna/software/pipelines/latest/using/bamslice
###
### Example execution on H4H:
### sbatch /cluster/home/lrichard/github/SU2C_GSC_scRNA/bin/NatCan_Rebuttal_June2020/CellRangerDNA_bamslice.sh /cluster/projects/pughlab/projects/BTSCs_scRNAseq/Manuscript_G607removed/NatCan_Rebuttal/MutationCalling/bams/BT147_L.possorted_genome_bam.bam

##############################################################
### GENERAL OVERVIEW OF THIS SCRIPT
### 1) Run bamslice from cellranger-dna (v1.1.0)
### Splits up bams by cell barcode (ExtractCellBarcodes_Seurat.r)
##############################################################

module load cellranger-dna/1.1.0

SAMPLEID=G523_L
CB_CSV=/cluster/projects/pughlab/projects/BTSCs_scRNAseq/Manuscript_G607removed/NatCan_Rebuttal/MutationCalling/pilot/G523_L_BamSlice_Config.csv
BAMFILE=/cluster/projects/pughlab/projects/BTSCs_scRNAseq/Manuscript_G607removed/NatCan_Rebuttal/MutationCalling/bams/G523_L.possorted_genome_bam.bam

echo ""
echo "********************"
echo "Running CellRanger-DNA Bamslice"
date
echo "********************"

cellranger-dna bamslice --id=$SAMPLEID \
                        --csv=$CB_CSV \
                        --bam=$BAMFILE \
                        --jobmode="/cluster/projects/pughlab/projects/INSPIRE_scRNAseq/src/slurm.template" \
                        --mempercore=6 \
                        --maxjobs=40
