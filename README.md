# process antiSMASH 5 output

## mibig.sh 
## A command line tool to convert antiSMASH 5 output to a csv file containing blast hits for biosynthetic gene clusters at a user-specified significance for percent_ID and percent_coverage

**Author:** Nick Crosbie, October 2019

**Dependencies:** GNU bash (version with readarray), awk, sed, jq, cut, xargs, paste

**Input requirements:** antiSMASH 5 output json file(s); MIBiG data files in json format (obtain from https://mibig.secondarymetabolites.org/download)

**Installation**
- clone the repository (https://github.com/crosbien/processAntiSmash.git)
- install dependencies
- update MIBiG json files - these **must** be stored in the directory **/processAntiSmash/mibig/mbig_json** 

**Usage:** ./mibig.sh percent_ID percent_coverage path-to-data-directory path-to-output-directory

**Usage example:** ./mibig.sh 95 95 ../testData ../output   (command **must** be issued from the **/processAntiSmash/mibig** directory)

**Example data:** three antiSMASH 5 output json files are included in the directory **/processAntiSmash/testData**

**Example output:** an example output csv is included in the directory **/processAntiSmash/output**

**Note:** antiSMASH 5 uses DIAMOND to produce blast-like output, and the term 'blast' is used in that context.

**Citation:** Crosbie ND (2019) mibig.sh: A command line tool to process antiSMASH 5 output. https://github.com/crosbien/processAntiSmash

