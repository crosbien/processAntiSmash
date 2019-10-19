
## mibig.sh - summarise antiSMASH 5.0 KnownClusterBlast output
© Nick Crosbie, October 2019

*A shell script to summarise antiSMASH 5.0 (Blin et al. 2019) KnownClusterBlast output, producing a TSV file (```clustersOut.tsv```) containing KnownClusterBlast search results (individual pairings) for Biosynthetic Gene Clusters at a user-specified threshold for percent_ID and percent_coverage*

<br/>

**1. INSTALLING**

**Dependencies:** GNU bash (recent version with readarray), gawk, jq

**Input requirements:** antiSMASH 5.0 output JSON file(s); MIBiG data files in JSON format (obtain from https://mibig.secondarymetabolites.org/download)

**Installation:** <br/> 
The easiest way to install the mibig.sh dependencies is to use the Mac package manager, Homebrew. To install Homebrew, fire up your Mac Terminal application, copy the following to the command prompt, and press return:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
``` 
Then, to install the mibig.sh dependencies, copy the following to the command prompt and press return:
```
brew update; brew install git; brew install bash; brew install coreutils; brew install gawk; brew install jq
```
Now, clone the mibig.sh repository by issuing the following command from the directory of your choice:
```
git clone https://github.com/crosbien/processAntiSmash.git
```
Finally, update the MIBiG JSON files - these *must* be stored in the directory ```./processAntiSmash/mibig/mbig_json```

<br/>

**2. USING**

**Usage:** 
```
./mibig.sh percent_ID percent_coverage ./path-to-data-directory ./path-to-output-directory
```
This assumes you are issuing the ```./mibig.sh``` command from the ```./processAntiSmash/mibig``` directory

**Ouput:** <br/> 
The output file will be written to ```./path-to-output-directory/clustersOut.tsv```

**Limitation:** To keep the number of columns in the output manageable, only two MiBiG file chemical activies and three MiBiG file product compounds are written to ```clustersOut.tsv```

**Note:** antiSMASH 5.0 uses the DIAMOND software to produce blast-like output and 'blastscore' and 'evalue' are used in that context

<br/>

**3. EXAMPLES**

**Usage example:** 
```
./mibig.sh 95 95 ./testData ./testOutput
```   

**Example data:** three antiSMASH 5.0 output JSON files are included in the ```./processAntiSmash/testData``` directory

**Example output:** an example output TSV file (```clustersOutExample.tsv```) is included in the ```./processAntiSmash/testOutput``` directory

<br/>

**4. CITATION**
<br/>
Crosbie ND (2019) mibig.sh: A shell script to summarise antiSMASH 5.0 KnownClusterBlast output. https://github.com/crosbien/processAntiSmash

<br/>

**5. REFERENCE** 
<br/>
Blin K, Shaw S, Steinke K, Villebro R, Ziemert N, Yup Lee S, Medema MH, Weber T (2019) antiSMASH 5.0 updates to the secondary metabolite genome mining pipeline. *Nucleic Acids Research* 47(W1):W81-W87. https://doi.org/10.1093/nar/gkz310