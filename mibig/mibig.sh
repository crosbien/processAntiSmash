################################################################### mibig.sh ###################################################################
##                                                                                                                                            ##
##  Munge antiSmash 5.0 (json) to output queried results, combine with MiBiG metadata and write to CSV                                        ##
##  Nicholas Crosbie, Oct. 2019                                                                                                               ##
##                                                                                                                                            ##
##  Usage: ./mibig percentID percentCoverage dataDirectory ouputDirectory                                                                     ##
##                                                                                                                                            ##
################################################################### mibig.sh ###################################################################

### LIMITATIONS
# Script will break if input datum contains a comma as output is csv.
# Only two chemical activies and three product compounds are written to output file.

### TODO:
# continue testing, e.g. on multiple data files
# either convert output to tsv or add pre-processing to guard agains aforementioned csv limitation

# 1. For each data file, do ...
for FILE in $3/*.json; do

  # 2. Return the pairing input sequence metadata for the selected query
  jq <$FILE -r --argjson ARG1 "$1" --argjson ARG2 "$2" '.records[0].modules["antismash.modules.clusterblast"].knowncluster.results[].ranking[][1].pairings[]  # pass data at this level in json (i.e. entry point for query)
  | select((.[2].perc_ident > $ARG1) and .[2].perc_coverage > $ARG2) # restrict query
  | .[2].annotation + "," + .[2].genecluster + "," + .[0]' >out1.txt

  # 3. Extract the MiBiG identifier field and remove final few characters
  awk -F, '{print $2}' out1.txt | cut -c 1-10 >out2.txt

  # 4. Create an array from out2.txt
  readarray mibigArray <out2.txt

  # 5. Extract metadata from each mibig.json file
  for i in "${mibigArray[@]}"; do
    k=$(echo $i | xargs) # strip whitespace
    jq -r '.general_params.biosyn_class[0] + ","
       + .general_params.compounds[0].chem_act[0] + ","
       + .general_params.compounds[0].chem_act[1] + ","
       + .general_params.compounds[0].compound + ","
       + .general_params.compounds[1].compound + ","
       + .general_params.compounds[2].compound' ./mibig_json/$k.json
  done >out3.txt

  # 6. Retrieve the annotations metadata
  ANNOTATIONS="$(jq <$FILE -r '.records[0].annotations.accessions[0] + ","
       + .records[0].annotations.organism')"

  #7. Retrieve data file name
  FILENAME="$(basename "$FILE")"
  
  # 8. Append the annotations and filename metadata
  sed -e "s/$/,$ANNOTATIONS,$FILENAME/" out3.txt >out4.txt

  # 9. Column-wise merge pairing metadata with mibig.json metadata (>> appends each data file output)
  paste -d, out1.txt out4.txt >>clusters.txt

done

# 10. Add a header row to smashOut.txt (echo -e means 'enable interpretation of backslash escapes')
echo -e 'Pairings.annotation,Pairings.genecluster,Pairings.input,Biosynthetic_class,Chemical_activity1,Chemical_activity2,Product_compound1,Product_compound2,Product_compound3,Accession,Organism,Data_file' >header.txt
cat header.txt clusters.txt >tmpfile
mv tmpfile $4/clustersOut.csv

# 11. Cleanup
rm out*.txt
rm header.txt
rm clusters.txt
