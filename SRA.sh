# Search for lines containing "saliva" and "V3V4" in the downloaded SraRunTable.txt file,
# extract the first column (sample IDs), and download the data using prefetch.

# Remove the existing 'SRADirectory' directory if it exists, and create a new one
# It is always recomemended to check if any data exist in preexisting directory and then remove it

[ -d "SRADirectory" ] && rm -rf SRADirectory
mkdir SRADirectory


for accession in $(grep -i "saliva" SraRunTable.txt | grep -i "V3V4" | cut -f1 -d ",")
	do
  	prefetch "$accession" -O SRADirectory
	done
