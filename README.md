
## *processAntiSmash*: summarise antiSMASH 5.0 KnownClusterBlast output
Nick Crosbie, October 2019

*Summarises antiSMASH 5.0 (Blin et al. 2019) KnownClusterBlast output (individual pairings) for Biosynthetic Gene Clusters at a user-specified threshold for percent identity and percent coverage. The output is combined with metadata from MIBiG JSON files and written to a single TSV file.*

**Dependencies:** GNU bash (recent version with readarray), gawk, jq

**Input requirements:** antiSMASH 5.0 output JSON file(s); Version 2.0 MIBiG data files in JSON format

**Example data:** three antiSMASH 5.0 output JSON files are included in the ```./processAntiSmash/exampleData``` directory

**Example output:** an example output TSV file (```clustersOutExample.tsv```) is included in the ```./processAntiSmash/exampleOutput``` directory

**Limitation:** To keep the number of columns in the output manageable, only three product compounds are written to ```clustersOut.tsv```

**Note:** antiSMASH 5.0 uses the DIAMOND software to produce blast-like output and 'blastscore' and 'evalue' are used in that context

<br>

**1. INSTALL THE SOFTWARE**

*processAntiSmash* and its dependencies can be installed **(i)** as a docker image, or **(ii)** by cloning the github repository and separately installing all dependencies. The former approach is easier as it requires fewer steps, less experience with the UNIX command line, and furthermore you can't accidentally clobber your favourite shell environment.

**(i) Install as a docker image (Mac or Debian/Ubuntu linux)**

1. Install Docker CE or Docker Desktop by following instructions at https://docs.docker.com/install/
2. Start the Docker application
3. Make a directory called ```as-files```
4. If on a Mac, then configure the shared paths from Docker Desktop at Preferences... -> File Sharing. Set ```path-to/as-files``` (you'll need to replace the ```path-to``` part)
5. Download the *processAntiSmash* docker image

```bash
docker pull milesforjazz/process-antismash
```

This will install the docker image ```milesforjazz/process-antismash``` on your system, which you can verify by issuing the following command

```bash
docker images
```

**(ii) Install by cloning from GitHub and separately installing the dependencies**

*On Debian/Ubuntu linux*

1. Install the dependencies

```bash
sudo apt-get update; sudo apt-get install git bash coreutils gawk jq
```

2. Clone the *processAntiSmash* repository by issuing the following command

```bash
git clone https://github.com/crosbien/processAntiSmash.git
```

*On Mac*

1. Install Homebrew by issuing the following command

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
2. Install the dependencies by issuing the following command

```bash
brew update; brew install git; brew install bash; brew install coreutils; brew install gawk; brew install jq
```
3. Clone the *processAntiSmash* repository by issuing the following command

```bash
git clone https://github.com/crosbien/processAntiSmash.git
```

<br>

**2. SETUP WORKING DIRECTORIES AND DOWNLOAD MIBiG FILES**

**(i) Setup the following working directories:**

```as-files/data``` (where you'll put your antiSMASH 5.0 output JSON files)

```as-files/out``` (where the TSV output file will be written)

**(ii) Copy your antiSMASH output JSON files to the ```as-files/data``` directory**

**(iii) Download and unpack MIBiG JSON files**

1. Issue the following command from the ``as-files`` directory to download the MIBiG JSON archive, unpack the files and rename the ```mibig_json_2.0``` directory to ```mibig``` 

```bash
curl https://dl.secondarymetabolites.org/mibig/mibig_json_2.0.tar.gz | tar xvz; mv mibig_json_2.0 mibig 
```

<br>

**3. USAGE**

**(i) Run as a docker container from the command line** (if you have installed the docker image)

1. Export variables to the shell by issuing the following from the command line, adjusting the ```PERC_ID``` (percent identity) and ```PERC_COV``` (percent coverage) values according to need (here both have been set to a value of 70)

```bash
export PERC_ID=70 && export PERC_COV=70 && export DATADIR=./datavol/data && export RESULTDIR=./datavol/out export MIBIG=./datavol/mibig
```

2. Run the *processAntiSmash* program as a docker container by issuing the following from the command line (you will need to change the ``path-to`` part of the following command to reflect where you have put your ```as-files``` directory)

```bash 
docker run -e PERC_ID -e PERC_COV -e DATADIR -e RESULTDIR -e MIBIG --name processAntiSmash --rm -v /path-to/as-files:/datavol milesforjazz/process-antismash
```

 The output file will be written to ```./path-to/as-files/out clustersOut.tsv```

**(ii) Run natively by issuing the following command:**

(if you have cloned the github repository and installed all dependencies) 

```bash
./path-to/mibig.sh 70 70 path-to/as-files/data path-to/as-files/out path-to/as-files/mibig_json_2.0
```


 The output file will be written to ```./path-to/as-files/out clustersOut.tsv```

<br>

**4. CITATION**

Crosbie ND (2019) *processAntiSmash*: a tool to summarise antiSMASH 5.0 KnownClusterBlast output. https://github.com/crosbien/processAntiSmash

<br>

**5. REFERENCE** 

Blin K, Shaw S, Steinke K, Villebro R, Ziemert N, Yup Lee S, Medema MH, Weber T (2019) antiSMASH 5.0 updates to the secondary metabolite genome mining pipeline. *Nucleic Acids Research* 47(W1):W81-W87. https://doi.org/10.1093/nar/gkz310