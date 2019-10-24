
## *processAntiSmash* - summarise antiSMASH 5.0 KnownClusterBlast output
© Nick Crosbie, October 2019

*A shell script to summarise antiSMASH 5.0 (Blin et al. 2019) KnownClusterBlast output (individual pairings) for Biosynthetic Gene Clusters at a user-specified threshold for percent_ID and percent_coverage. The output is combined with metadata from MIBiG JSON files and written to a single TSV file (```clustersOut.tsv```)*



**1. INSTALLING**

*processAntiSmash* can be installed as a Docker image or by cloning the github repository and installing all dependencies. The former approach is more consistent across computing platforms and easier as it requires fewer steps and less experience with the UNIX command line.

**Dependencies:** GNU bash (recent version with readarray), gawk, jq

**Input requirements:** antiSMASH 5.0 output JSON file(s); MIBiG data files in JSON format (obtain from https://mibig.secondarymetabolites.org/download)

**Install Docker image**

Download the *processAntiSmash* tgz file:

ADD METHOD TO DO THIS:

```bash
docker load < process-antismash.tgz"
``` 


**Clone and install all dependencies**

*On Debian or Ubuntu linux*

*On Mac*

Install Homebrew, fire up your Mac Terminal application, copy the following to the command prompt, and press return:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
``` 
Then, to install the mibig.sh dependencies, copy the following to the command prompt and press return:
```bash
brew update; brew install git; brew install bash; brew install coreutils; brew install gawk; brew install jq
```
Now, clone the mibig.sh repository by issuing the following command from the directory of your choice:
```bash
git clone https://github.com/crosbien/processAntiSmash.git
```
Finally, update the MIBiG JSON files - these *must* be stored in the directory ```./processAntiSmash/mibig/mbig_json```


**2. USING**

**Usage:**

*Run as a Docker container from the command line*




*Run natively from the command line*

```bash
./mibig.sh percent_ID percent_coverage ./path-to-data-directory ./path-to-output-directory ./path-to-MIBiG-directory
```
This assumes you are issuing the ```./mibig.sh``` command from the ```./processAntiSmash/mibig``` directory

**Ouput:** <br/> 
The output file will be written to ```./path-to-output-directory/clustersOut.tsv```

**Limitation:** To keep the number of columns in the output manageable, only two MiBiG file chemical activies and three MiBiG file product compounds are written to ```clustersOut.tsv```

**Note:** antiSMASH 5.0 uses the DIAMOND software to produce blast-like output and 'blastscore' and 'evalue' are used in that context



**3. EXAMPLES**

**Usage example:** 
```bash
./mibig.sh 95 95 ./exampleData ./exampleOutput
```   

**Example data:** three antiSMASH 5.0 output JSON files are included in the ```./processAntiSmash/exampleData``` directory

**Example output:** an example output TSV file (```clustersOutExample.tsv```) is included in the ```./processAntiSmash/exampleOutput``` directory



**4. CITATION**

Crosbie ND (2019) *processAntiSmash*: a tool to summarise antiSMASH 5.0 KnownClusterBlast output. https://github.com/crosbien/processAntiSmash



**5. REFERENCE** 

Blin K, Shaw S, Steinke K, Villebro R, Ziemert N, Yup Lee S, Medema MH, Weber T (2019) antiSMASH 5.0 updates to the secondary metabolite genome mining pipeline. *Nucleic Acids Research* 47(W1):W81-W87. https://doi.org/10.1093/nar/gkz310