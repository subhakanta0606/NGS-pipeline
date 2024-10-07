# NGS-pipeline
**Author: Subhakanta Behera**

This repository contains the code pipeline that I wrote for next generation sequencing (NGS) analysis under the guidance of **Mr. Sunil Nagpal** and **Dr. Bhupesh Taneja**. 
The pipeline is based on the analysis of data from BioProject ID PRJNA612815.

#1. Data Acquisition:
The accession list for BioProject ID PRJNA612815 was downloaded using the run selector option in NCBI (Soriano-Lerma A. et al., 2020).
The sratoolkit was installed using the Ubuntu package manager (APT).
Installation command:
**sudo apt install sratoolkit**
The ‘prefetch’ command of ‘sratoolkit’ was used to download the SRA files specific to the 16S sequence data (V3-V4 region) [Code available in **SRA.sh**]
SRA files are organized into a directory named "SRADirectory".

#2. Converting SRA to FASTQ
SRA files are converted to paired FASTQ files using the ‘fasterq-dump’ command in ‘sratoolkit’.
[Code available in **fasterq-dump.sh**]
This command will convert all SRA files (with accession IDs starting with "SRR") into FASTQ format, saving the results in the FastqFiles directory.

#3. Adapter and Primer Trimming
FASTQ files were processed to remove Illumina adapters and 16S primers using the cutadapt tool. The following primers were used for the V3-V4 region of 16S rRNA:
Forward: 5' CCTACGGGNGGCWGCAG 3'
Reverse: 5' GACTACHVGGGTATCTAATCC 3'
[Code available in **CutAdapt.sh**]
This script produces two outputs: a directory named "RES" and a file named "samplelist.txt" inside the "FastqFiles" directory. It achieves this by compressing all the FASTQ files located within the "FastqFiles" directory.
The "RES" directory holds the processed reads, and the "samplelist.txt" file preserves all the
SRA accession IDs.
The '--no-indels' option ensures exact matching for adapter removal, and the 'e 0.15' option sets the error rate threshold for adapter matching. The '--discard-untrimmed' option removes read pairs lacking the specified adapters.

#4. Quality Filtering
**The PRINSEQ tool (downloaded from the website https://sourceforge.net/projects/prinseq/files/)** was used to filter reads based on quality. Reads with a minimum mean quality of 25 (phred score) were retained.
[Code available in **PrinSeq.sh**]
It takes the forward and reverse FASTQ files of the sample, specified by '-fastq' and '-fastq2', respectively. The '-min_qual_mean 25' option sets the minimum read mean quality to be 25. The '-out_format 3' option indicates that the filtered output files will be in FASTQ format. The '-out_bad null' option ensures that any sequences that fail the quality filtering are not saved as separate files.  
In end, this script filters reads with minimum phred score 25 in 'GoodQuality' directory.
Note: 
We can generate the quality report by using FASTQC tool command line:
**fastqc <filename> -o Quality**
It will produce the quality report of mentioned 'filename' in 'Quality' directory.

#5. Assembly of Forward and Reverse reads
**The PEAR tool (downloaded from the website http://www.exelixis-lab.org/web/software/pear)** was used to assemble the forward and reverse reads. A minimum overlap region of 30 bases was allowed for stitching the reads together.
Note: Illumina V3 chemistry allowed sequencing of 300 bases each of forward and reverse reads. Given the target region was V3-V4 (~470bp), it theoretically allowed a potential overlapping region of 100 bases. In order to increase the chances of successful assembly, we therefore allowed a minimum overlap region of 30 bases (as specified -v 30) for the PEAR tool to stitch the forward and reverse reads together.
[Code available in **Pear.sh**] 
This script will move the assembled sequence to the 'ASSEMBLE' directory.

#6. FASTQ to FASTA Conversion
FASTQ files were converted to FASTA format for compatibility with the RDP classifier.
[Code available in **FASTAconversion.sh**]
This script moves the converted files to FASTA directory.

#7 Taxonomic Classification
The Ribosomal Database Project (RDP) classifier was used to generate Phylum, Class, Order, Family, and Genus level classification of reads across all files.
[Code available in **RDPclassifier.sh**]
The provided Java command executes the 'rdp_classifier_2.13' tool, a classification tool for DNA sequences in FASTA format. The classification method chosen is 'fixrank', with a confidence threshold of 0.8 specified by '-c 0.8'. Sequences with a confidence value below 0.8 are marked as 'Unassigned'. The command processes input FASTA files from the 'FastaDirectory' and saves the classification results in the file 'PRJNA612815.classified' by using '-o PRJNA612815.classified'. Here, (.classified) file stores the confidence of read classification at any given level of taxonomy. The (.hier) file stores the final tabulated count data summary created using (.classified) summary for all reads.


