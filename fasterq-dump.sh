#change directory to SRADirectory 
cd SRADirectory

#Convert SRA files (starting with SRR ID) to FASTQ format
#Save the converted FASTQ files into "FastqFiles" directory

fasterq-dump SRR* -o FastqFiles


