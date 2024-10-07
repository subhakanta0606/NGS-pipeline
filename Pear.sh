# Create the 'ASSEMBLE' directory if it doesn't exist
[ -d "ASSEMBLE" ] && rm -rf ASSEMBLE
mkdir ASSEMBLE

# Process each unique sample
for files in `ls SRR* | cut -f1 -d "_" | sort | uniq`
    do
    # Run 'pear' with specified options to merge paired-end reads and there should be minimu 30 bp overlap
    ./pear -f $files"_1.fastq" -r ${files}"_2.fastq" -v 30 -o $files.fastq"

    # Move the resulting merged file to the 'ASSEMBLE' directory
    mv "${files}.fastq" ASSEMBLE
    done
