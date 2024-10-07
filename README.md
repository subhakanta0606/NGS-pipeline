# NGS-pipeline
This repository contains the code pipeline that I wrote for next generation sequencing (NGS) analysis under the guidance of Mr. Sunil Nagpal and Dr. Bhupesh Taneja. 

This project uses the Ubuntu package manager (API) to install ‘sratoolkit’ for processing sequencing data from the Bioproject ID “**PRJNA612815**”

#1. Installing sratoolkit:

Installation command:
``` bash
Sudo apt install sratoolkit

#2. Downloading SRA files:
The accession list of Bioproject ID PRJNA612815 was downloaded using the Run Selector option in NCBI (Soriano-Lerma A. et al., 2020).
The ‘prefetch’ command of ‘sratoolkit’ was then used to download the SRA files specific to the 16S sequence data (V3-V4 region)
(Code available in **SRA.sh**)
SRA files are organized into a directory named SRADirectory.

#3. Converting SRA to FASTQ
SRA files are converted to paired FASTQ files using the ‘fasterq-dump’ command in ‘sratoolkit’.
(Code available in **fasterq-dump.sh**)
This command will convert all SRA files (with accession IDs starting with "SRR") into FASTQ format, saving the results in the FastqFiles directory.
