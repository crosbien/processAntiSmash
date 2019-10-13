# process-antiSMASH

## blastHits.sh

**Description:** Processes antiSMASH 4.1.0 results to output a tab delimited file containing blast hits for gene clusters at a user-specified significance (percent_ID and percent_coverage).

**Author:** Nick Crosbie, August 2018

**Input requirements:** antiSMASH 4.1.0 output

**Dependencies:** GNU bash, grep, awk, cut, paste, uniq, sort, join

**Usage:** ../bin/blastHits.sh percent_ID percent_coverage

**Example:** ../bin/blastHits.sh 70 70

**Test**
- unpack the example "antiSMASHed" genomes (tar achives contained in /example-genomes) to a sister directory of /bin named /genome. 
- from the /genome directory, execute "../bin/blastHits.sh 70 70" without the quotation marks. This will create a file named *smashOut.txt* in the /genome directory, the contents of which should match the *ex-smashOut.txt* file located in the /example-output directory. 
- to run on your own data, replace the example antiSMASHed genomes with your own antiSMASH output.  Note that you can change the percent_ID and percent_coverage threshold values to you liking.

**Note:** antiSMASH 4.1.0 uses DIAMOND to produce blast-like output, and the term 'blast' is used in that context.

*Please consider acknowledging the author if the script proves useful to your research.*

