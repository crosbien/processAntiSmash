################################################################### mibig.sh ###################################################################
##                                                                                                                                            ##
##  Wrangle antiSmash 5.0 (json) to output queried results, combine with MiBiG metadata and write to TSV                                      ##
##  Nicholas Crosbie, October 2019                                                                                                            ##
##                                                                                                                                            ##
##  Usage: ./mibig percentID percentCoverage dataDirectory ouputDirectory                                                                     ##
##                                                                                                                                            ##
################################################################### mibig.sh ###################################################################

### LIMITATIONS
# Only two chemical activies and three product compounds are written to output TSV file

# 1. For each data file, do ...
for FILE in $3/*.json; do

  # 2. Return the pairing input sequence metadata for the selected query
  jq <$FILE -r --argjson ARG1 "$1" --argjson ARG2 "$2" '.records[0].modules["antismash.modules.clusterblast"].knowncluster.results[].ranking[][1].pairings[]  # pass data at this level in json (i.e. entry point for query)
  | select((.[2].perc_ident > $ARG1) and .[2].perc_coverage > $ARG2) # restrict query
  | [.[2].annotation, .[2].genecluster, .[0]] | @tsv' > out1.txt

  # 3. Extract the MiBiG identifier field and remove final few characters
  awk -F\t '{print $2}' out1.txt | cut -c 1-10 >out2.txt

  # 4. Create an array from out2.txt
  readarray mibigArray <out2.txt

  # 5. Extract metadata from each mibig.json file
  for i in "${mibigArray[@]}"; do
    k=$(echo $i | xargs) # strip whitespace
    jq -r '[.general_params.biosyn_class[0],
            .general_params.compounds[0].chem_act[0],
            .general_params.compounds[0].chem_act[1],
            .general_params.compounds[0].compound,
            .general_params.compounds[1].compound,
            .general_params.compounds[2].compound] | @tsv' ./mibig_json/$k.json
  done >out3.txt

  # 6. Retrieve the annotations metadata
  ANNOTATIONS="$(jq <$FILE -r '[.records[0].annotations.accessions[0], .records[0].annotations.organism] | @tsv')"

  #7. Retrieve data file name
  FILENAME="$(basename "$FILE")"
  
  # 8. Append the annotations and filename metadata
  <out3.txt awk -F\t -v a="$ANNOTATIONS" -v b="$FILENAME" 'BEGIN{OFS="\t";} { print $0,a,b; }' > out4.txt

  # 9. Column-wise merge pairing metadata with mibig.json metadata (>> appends each data file output)
  paste -d'\t' out1.txt out4.txt >>clusters.txt

done

# 10. Add a header row to smashOut.txt (echo -e means 'enable interpretation of backslash escapes')
echo -e 'Pairings.annotation\tPairings.genecluster\tPairings.input\tBiosynthetic_class\tChemical_activity1\tChemical_activity2\tProduct_compound1\tProduct_compound2\tProduct_compound3\tAccession\tOrganism\tData_file' >header.txt
cat header.txt clusters.txt >tmpfile
mv tmpfile $4/clustersOut.tsv

# 11. Cleanup
rm out*.txt
rm header.txt
rm clusters.txt
