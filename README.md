
## *processAntiSmash*: summarise antiSMASH 5.0 KnownClusterBlast output
Nick Crosbie, October 2019

*Summarises antiSMASH 5.0 (Blin et al. 2019) KnownClusterBlast output (individual pairings) for Biosynthetic Gene Clusters at a user-specified threshold for percent identity and percent coverage. The output is combined with metadata from MIBiG JSON files and written to a single TSV file.*

**Dependencies:** GNU bash (recent version with readarray), gawk, jq

**Input requirements:** antiSMASH 5.0 output JSON file(s); MIBiG data files in JSON format

**Example data:** three antiSMASH 5.0 output JSON files are included in the ```./processAntiSmash/exampleData``` directory

**Example output:** an example output TSV file (```clustersOutExample.tsv```) is included in the ```./processAntiSmash/exampleOutput``` directory

**Limitation:** To keep the number of columns in the output manageable, only two MiBiG file chemical activies and three MiBiG file product compounds are written to ```clustersOut.tsv```

**Note:** antiSMASH 5.0 uses the DIAMOND software to produce blast-like output and 'blastscore' and 'evalue' are used in that context



**1. INSTALL THE SOFTWARE**

*processAntiSmash* and its dependencies can be installed **(i)** as a docker image, or **(ii)** by cloning the github repository and separately installing all dependencies. The former approach is easier as it requires fewer steps, less experience with the UNIX command line, and furthermore you can't accidentally clobber your favourite shell environment.

**(i) Install as a docker image (Mac or Debian/Ubuntu linux)**

1. Install docker by following instructions at https://docs.docker.com/install/
2. Download the *processAntiSmash* docker image:

```bash
docker pull milesforjazz/process-antismash
```

This will install the docker image ```milesforjazz/process-antismash`` on your system, which you can verify by issuing the following command:

```bash
docker images
```

**(ii) Install by cloning from GitHub and separately installing the dependencies**

*On Debian/Ubuntu linux*

1. Install the dependencies:

```bash
sudo apt-get update; sudo apt-get install git bash coreutils gawk jq
```

2. Clone the *processAntiSmash* repository by issuing the following command:

```bash
git clone https://github.com/crosbien/processAntiSmash.git
```

*On Mac*

1. Install Homebrew by issuing the following command:

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
2. Install the dependencies by issuing the following command:

```bash
brew update; brew install git; brew install bash; brew install coreutils; brew install gawk; brew install jq
```
3. Clone the *processAntiSmash* repository by issuing the following command:

```bash
git clone https://github.com/crosbien/processAntiSmash.git
```



**2. SETUP WORKING DIRECTORIES AND DOWNLOAD MIBiG FILES**

**(i) Setup the following working directories:**

```..as-files\data``` (where you'll put your antiSMASH 5.0 output JSON files)

```..as-files\out``` (where the TSV output file will be written)

**(ii) Download and unpack MIBiG JSON files**

1. If you don't have **wget**, then install it first with ``brew install wget`` (Mac) or ```sudo apt-get install wget``` (Debian or Ubuntu linux). Then  issue the following command from the ``as-files`` directory to download the MIBiG JSON files:

```bash
wget https://dl.secondarymetabolites.org/mibig/mibig_json_2.0.tar.gz
```

2. Unpack the tar.gz archive, by issuing the following from the ``as-files`` directory:

```bash
tar -xvf mibig_json_2.0.tar.gz
```

This will create a ```mibig_json_2.0``` directory in your ```as-files``` directory, and will contain the unpacked MIBiG JSON files. You'll need to rename that directory by issuing the following command from the ```as-files``` directory:

```bash
mv mibig_json_2.0 mibig
```



**3. USAGE**

**(i) Run as a docker container from the command line (if you have installed the docker image)**

1. Export variables to the shell by issuing the following from the command line, adjusting the ```PERC_ID``` (percent identity) and ```PERC_COV``` (percent coverage) values according to need (here both have been set to a value of 70)

```bash
export PERC_ID=70 && export PERC_COV=70 && export DATADIR=./datavol/data && export RESULTDIR=./datavol/out export MIBIG=./datavol/mibig
```

2. Run the *processAntiSmash* program as a docker container by issuing the following from the command line (note: you will need to change the ``path-to`` part of the following command to reflect where you have put your ```as-files``` directory):

```bash 
docker run -e PERC_ID -e PERC_COV -e DATADIR -e RESULTDIR -e MIBIG --name processAntiSmash --rm -v /path-to/as-files:/datavol milesforjazz/process-antismash
```

 The output file will be written to ```./path-to/as-files/out clustersOut.tsv```

**(ii) Run natively (if you have cloned the github repository and installed all dependencies) by issuing the following command:**

```bash
./path-to/mibig.sh 70 70 path-to/as-files/data path-to/as-files/out path-to/as-files/mibig_json_2.0
```


 The output file will be written to ```./path-to/as-files/out clustersOut.tsv```



**4. CITATION**

Crosbie ND (2019) *processAntiSmash*: a tool to summarise antiSMASH 5.0 KnownClusterBlast output. https://github.com/crosbien/processAntiSmash



**5. REFERENCE** 

Blin K, Shaw S, Steinke K, Villebro R, Ziemert N, Yup Lee S, Medema MH, Weber T (2019) antiSMASH 5.0 updates to the secondary metabolite genome mining pipeline. *Nucleic Acids Research* 47(W1):W81-W87. https://doi.org/10.1093/nar/gkz310