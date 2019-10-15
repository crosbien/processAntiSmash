
## mibig.sh - summarise antiSMASH JSON output
*A shell script to summarise antiSMASH JSON output, producing a TSV file containing blast hits for biosynthetic gene clusters at a user-specified threshold for percent_ID and percent_coverage*

**Author:** Nick Crosbie, October 2019

**Dependencies:** GNU bash (version with readarray), gawk, jq, cut, xargs, paste

**Input requirements:** antiSMASH output JSON file(s); MIBiG data files in JSON format (obtain from https://mibig.secondarymetabolites.org/download)

**Installation**
- clone the repository (https://github.com/crosbien/processAntiSmash.git)
- install dependencies
- update MIBiG JSON files - these **must** be stored in the directory **/processAntiSmash/mibig/mbig_json** 

**Usage:** ```./mibig.sh percent_ID percent_coverage path-to-data-directory path-to-output-directory```

**Usage example:** ```./mibig.sh 95 95 ../testData ../output```   (command **must** be issued from the **/processAntiSmash/mibig** directory)

**Example data:** three antiSMASH 5 output JSON files are included in the directory **/processAntiSmash/testData**

**Example output:** an example output TSV file is included in the directory **/processAntiSmash/output**

**Note:** antiSMASH 5 uses DIAMOND to produce blast-like output, and the term 'blast' is used in that context.

**Citation:** Crosbie ND (2019) mibig.sh: A command line tool to process antiSMASH 5 output. https://github.com/crosbien/processAntiSmash

