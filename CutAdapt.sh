# Remove the existing 'RES' directory if it exists, and create a new one
[ -d "RES" ] && rm -rf RES
mkdir RES

# Generate a list of unique sample names from the input files
ls *.gz | cut -d "_" -f1 | sort | uniq > samplelist.txt

# Process each sample in the samplelist.txt file
for samples in `cat samplelist.txt`
do
    # Trim adapters from forward and reverse reads using cutadapt
    cutadapt --no-indels -e 0.15 -g ^GACTACHVGGGTATCTAATCC -G ^CCTACGGGNGGCWGCAG --discard-untrimmed>
    cutadapt --no-indels -e 0.15 -g ^CCTACGGGNGGCWGCAG -G ^GACTACHVGGGTATCTAATCC --discard-untrimmed>

    # Concatenate and compress the trimmed forward reads
    gunzip RES/"$samples"_1.fastq.gz
    gunzip RES/"$samples"_1r.fastq.gz
    cat RES/"$samples"_1.fastq RES/"$samples"_1r.fastq > RES/"$samples"_1new.fastq
    rm RES/"$samples"_1.fastq RES/"$samples"_1r.fastq
    gzip RES/"$samples"_1new.fastq
    mv RES/"$samples"_1new.fastq.gz RES/"$samples"_1.fastq.gz

    # Concatenate and compress the trimmed reverse reads
    gunzip RES/"$samples"_2.fastq.gz
    gunzip RES/"$samples"_2r.fastq.gz
    cat RES/"$samples"_2.fastq RES/"$samples"_2r.fastq > RES/"$samples"_2new.fastq
    rm RES/"$samples"_2.fastq RES/"$samples"_2r.fastq
    gzip RES/"$samples"_2new.fastq
    mv RES/"$samples"_2new.fastq.gz RES/"$samples"_2.fastq.gz

done 

#Shell script for processing FASTQ files with cutadapt tool for adapter or any primer trimming.
