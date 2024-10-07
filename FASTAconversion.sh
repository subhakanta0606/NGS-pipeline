#Change directory to the target location
cd /home/subhakanta/Downloads/SRADirectory/FastqFiles/RES/GoodQuality/ASSEMBLE

#Remove the 'FASTA' directory if it exists
[ -d "FASTA" ] && rm -rf FASTA

#Create the 'FASTA' directory
mkdir FASTA

#Process each file with "assembled.fastq" extension
for file in `ls *assembled.fastq | cut -f1 -d "."`
do

	#Convert Fastq format to Fasta format using awk
	awk 'NR%4==1 {print ">"$0} NR%4==2 {print}' "$file".fastq.assembled.fastq > "${file}.fasta"

	#Move the resulting file to the 'FASTA' directory
	mv "${file}.fasta" FASTA/
done

