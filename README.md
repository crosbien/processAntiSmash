
## mibig.sh - summarise antiSMASH 5.0 KnownClusterBlast output
© Nick Crosbie, October 2019

*A shell script to summarise antiSMASH 5.0 (Blin et al. 2019) KnownClusterBlast output, producing a TSV file (```clustersOut.tsv```)containing KnownClusterBlast search results for biosynthetic gene clusters at a user-specified threshold for percent_ID and percent_coverage*



<br/>

**1. INSTALLING**

  - **Dependencies:** GNU bash (recent version with readarray), gawk, jq, cut, xargs, paste

  - **Input requirements:** antiSMASH 5 output JSON file(s); MIBiG data files in JSON format (obtain from https://mibig.secondarymetabolites.org/download)

  - **Installation**
    - install dependencies (brew, apt-get, etc. )
    - clone the repository (https://github.com/crosbien/processAntiSmash.git)
    - update MIBiG JSON files - these **must** be stored in the directory ```/processAntiSmash/mibig/mbig_json```

<br/>

**2. USING**

  - **Usage:** ```./mibig.sh percent_ID percent_coverage path-to-data-directory path-to-output-directory```

  - **Ouput:** ```./path-to-output-directory/clustersOut.tsv```

  - **Limitation:** To keep the number of columns in the output manageable, only two MiBiG file chemical activies and three MiBiG file product compounds are written to ```clustersOut.tsv```

  - **Note:** antiSMASH 5.0 uses the DIAMOND software to produce blast-like output and 'blastscore' and 'evalue' are used in that context

<br/>

**3. EXAMPLES**

  - **Usage example:** ```./mibig.sh 95 95 ../testData ../testOutput```   (command **must** be issued from the directory ```/processAntiSmash/mibig```)

  - **Example data:** three antiSMASH 5 output JSON files are included in the directory ```/processAntiSmash/testData```

  - **Example output:** an example output TSV file (```clustersOutExample.tsv```) is included in the directory ```/processAntiSmash/testOutput```

<br/>

**4. CITATION AND REFERENCE**

  - **Citation for mibig.sh tool:** Crosbie ND (2019) mibig.sh: A shell script to summarise antiSMASH 5.0 KnownClusterBlast output. https://github.com/crosbien/processAntiSmash

  - **Reference:** Blin K, Shaw S, Steinke K, Villebro R, Ziemert N, Yup Lee S, Medema MH, Weber T (2019) antiSMASH 5.0 updates to the secondary metabolite genome mining pipeline. *Nucleic Acids Research* 47(W1):W81-W87. https://doi.org/10.1093/nar/gkz310