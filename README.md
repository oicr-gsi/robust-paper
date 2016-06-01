#Ten Simple Rules for Making Research Software More Robust

* Morgan Taschuk (OICR)
* Greg Wilson (Software Carpentry/OICR)

> ## Abstract
>
> FIXME: abstract

As a relatively young field, bioinformatics is full of newly developed software. [EXAMPLES HERE] 
Efforts such as [ELIXIR tools and data registry](http://dx.doi.org/10.1093/nar/gkv1116) and the [Bioinformatics Links Directory](https://bioinformatics.ca/links_directory/) [(ref)](10.1093/nar/gks632)
have made efforts towards cataloguing the available software. 
As of May 2016, ELIXIR lists 2500 software entries and the Bioinformatics.ca lists 1700.
For many data types, there is no 'right' way to perform analysis as yet. 
As an example, although short read sequencers are ten years old, the leading 
sequencing companies regularly update their instruments and chemistry to push 
the boundaries of the possible ever higher[references: illumina HiseqX, 10X genomics, nanopore sequencing]. 
New sequencing initiatives are exploring the human microbiome, the depths of 
the ocean, and even the outer reaches of space. For many of these new data 
types, we have not reached the boundaries of what is possible. We are also 
sequencing data in quantities never before seen. The 1000 Genomes project seems 
quaint next to the UK's 100k project and Human Longevity's pledge to 
sequence 100 000 genomes per year by the end of 2016[(ref)](http://www.darkdaily.com/worlds-two-largest-whole-genome-sequencing-programs-give-pathologists-and-clinical-laboratory-managers-an-intriguing-look-at-new-diagnostic-opportunities-0502#axzz49tdSMDXq). 
PULL MORE STATS FROM [ICGCMED PAPER](http://icgcmed.org/files/ICGCmed_White_Paper_April_2016.pdf). 
As of release 21, the International Cancer Genome Consortium has sequenced 
15 000 individuals and the data are publicly available [(ref)](https://dcc.icgc.org).

This is a very exciting time for bioinformatics. As a direct result, many 
trainee projects produce code and software. This software supports their 
thesis project or post-doctoral research, runs on the data gathered by the 
student's lab, and produces excellent results in their hands. The trainee will 
be lead author on a few papers and leave their advisor's lab for a 
post-doctoral, academic or industry position with much-deserved acclaim.

Our story really starts after that student leaves the lab. Every student and 
research associate with a few years of experience feels a tremour of fear when 
their advisor says "Use \<graduated student\>'s code to analyze your data". 
In most cases, the software will be undocumented, have a number of 
eccentricities, and likely will not work without substantial modification. 
The student or employee will shake their fist and curse the graduated student's
name. She then has two choices: hack it to make it work or invest time into 
making the software robust.

Robust software can be installed on systems outside the original institution and
works for users than the original author. Its input and output data have a 
defined format. It has a minimum set of documentation that describes what its 
dependencies are, how to install it, and what the options are. Finally, it is 
amenable to testing by external software and is versioned.  Whether the aim is 
as simple as sharing the code with collaborators or as complex as using the 
software in a production analysis environment, increasing the robustness of your 
software decreases headaches all around.

These rules are for anyone who is placed in the position of making 
bioinformatics software robust and generally usable. We do not recommend specific
languages, libraries, packages, documentation styles or operating systems. We 
also do not advise these rules be applied to *every* coding effort. The vast 
majority of code produced in the marathon of a graduate thesis is 'throw-away' 
code that it used once to answer a specific question related to a specific 
dataset. However, once that little script is dragged out three or four times 
for slightly different purposes, it may be time to apply some robustness rules.


FIXME: explain the problem.

* The difference between software running and being usable.
  * "Works for me on my machine" vs. "works for other people on a cluster I've 
    never met".
* The "right" answer is to create a package on e.g. CPAN with full documentation
  and a set of regression tests.
  * But not everything worth doing is worth doing right.

How to tell if the software is working:

* Test in a 'vanilla' environment, such as another user's computer or a dummy 
  account with none of the settings of the original developer.
* Test with different sizes of data:
  ridiculously small, small, medium, and large.
  The software should run on all sizes given some parameter tweaking,
  or fail with a sensible error message if the data is too big.
* Compare results from multiple iterations that have the same parameters and 
  inputs.(See rule #8.)

## 1. Have a README that explains in a few lines what the software does and what its dependencies are.

* This is readable *before* the software is installed (or even downloaded).
* Should also include (or better yet, point to) the license for the software,
  so that (potential) users will know what they're allowed to do.
* FIXME: example from real software: https://github.com/dib-lab/khmer/blob/master/README.rst

## 2. Print usage information when launching from the command line that explains the software's features.

* And tell users where to find more information.
* FIXME: example from real software (some package you think does this well)

## 3. Do not require root or other special privileges.

* Because:
  * want to be able to try it out before installing system-wide on a cluster
  * don't want to pollute the system's own space
  * doing anything with root is risky...
* So allow for local install (e.g., under user's home directory in ~/packagename)
  * May mean modifying path...
  * ...which must be done carefully, but isn't as risky as doing things as root

## 4. Allow configuration of all major parameters from the command lines, including input files, thresholds, memory required, and other parameters.

* Configuration files are nice, but awkward to create on the fly when the tool 
  is being run from shell scripts etc.
* GVW: I usually tell people to
  * read relatively constant values from a ~/.packagerc file or the like so 
    that they don't have to be specified every time
  * echo parameters to output to support reproducibility
  * and will defer to you because you've done this a lot more

## 5. Eliminate hard-coded paths.

* Allow the user to set the name and location for the output files or results as 
  command-line parameters
  * Common offenders: reference datasets, output directories.
* Corollary: do not require navigating to a particular directory to work, or 
  operate on files only in the current working directory without allowing an 
  override.
  * "Where I have to be" is just another hard-coded path.

## 6. Do not rely on launching software from the command line or by "shelling out" from a script.

* Common offenders: samtools, Picard tools, tabix.
* Those tools may not be installed, or may not be on the path.
* Some leniency here for Bash, R, Python, Java, Perl, and other tools that are 
  included by default in Linux distributions.
  * But note: this may make software harder to use on Windows

## 7. Do not rely on the pre-installation of non-standard packages or libraries, unless clearly defined in docs.

* Common offenders include a lot of Perl, R, and Python libraries, and 
  user-local scripts.

## 8. Produce identical results when given identical inputs.

* The test set isn't useful without this.
* And people won't be able to debug problems without it either.
* Common offender: random number generators
  * So require their seed as a parameter.
  * Or if the seed is set internally (e.g., using clock time), echo it to the 
    output for re-use later.

## 9. Include a small test set that can be run to ensure the software is actually working.

* This is *not* to check that the software is working correctly (though that would be nice), just that it will actually run.
* Also serves as working example of how to run software (in case embedded documentation has fallen out of sync).
* Provide a single script called `runtests.sh` or the like, rather than documenting test cases and requiring people to type (or copy/paste)

## 10. Give the software a meaningful version number.

* Make it easy for users to figure out which version they actually have.
* Semantic versioning (and remember to change it on each release).
* Make the version number discoverable (e.g., echo it in usage).
