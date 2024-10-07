# Change directory to the target location
cd /home/subhakanta/Downloads/SRADirectory/FastqFiles/RES/GoodQuality/ASSEMBLE/FASTA

# Remove the 'FASTA' directory if it exists
[ -d "rdp_classifier_2.13" ] && rm -rf rdp_classifier_2.13

# Bring the downloaded 'rdp_classifier_2.13' directory to "FASTA" directory
cp -r /home/subhakanta/Downloads/rdp_classifier_2.13 .

#copy all FASTA files to "rdp_classifier_2.13" directory
cp *.fasta rdp_classifier_2.13/FastaDirectory/

# Change directory to "rdp_classifier_2.13"
cd rdp_classifier_2.13

#Process FASTA files for classification
java -Xmx1g -jar dist/classifier.jar classify -c 0.8 -f fixrank -o PRJNA612815.classified -h PRJNA612815_Table.hier FastaDirectory/*.fasta
