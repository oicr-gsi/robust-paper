# Ten Simple Rules for Robustifying Your Software

* Morgan Taschuk (OICR)
* Greg Wilson (Software Carpentry/OICR)

**Abstract**
> FIXME: abstract

As a relatively young field, bioinformatics is full of newly developed software. [EXAMPLES HERE] Efforts such as ELIXIR tools and data registry (10.1093/nar/gkv1116) and the Bioinformatics Links Directory (https://bioinformatics.ca/links_directory/) [10.1093/nar/gks632] have made efforts towards cataloguing the available software. As of May 2016, ELIXIR lists 2500 software entries and the Bioinformatics.ca lists 1700. 

For many data types, there is no 'right' way to perform analysis as yet. As an example, although short read sequencers are ten years old, the leading sequencing companies regularly update their instruments and chemistry to push the boundaries of the possible ever higher[references: illumina HiseqX, 10X genomics, nanopore sequencing]. New sequencing initiatives are exploring the human microbiome, the depths of the ocean, and even the outer reaches of space. For many of these new data types, we have not reached the boundaries of what is possible. We are also sequencing data in quantities never before seen. The 1000 Genomes project seems quaint now, next to the UK's 100k project and Human Longevity's pledge to sequence 100 000 genomes per year by the end of 2016[http://www.darkdaily.com/worlds-two-largest-whole-genome-sequencing-programs-give-pathologists-and-clinical-laboratory-managers-an-intriguing-look-at-new-diagnostic-opportunities-0502#axzz49tdSMDXq] [PULL MORE STATS FROM ICGCMED PAPER http://icgcmed.org/files/ICGCmed_White_Paper_April_2016.pdf]. As of release 21, the International Cancer Genome Consortium has sequenced 15 000 individuals and their tumours and their data is publicly available [https://dcc.icgc.org].

This is a very exciting time for bioinformatics. As a direct result, many trainee projects produce code and software. This software supports their thesis project or post-doctoral research, runs on the data gathered by the student's lab, and produces excellent results in their hands. The trainee will be lead author on a few papers and leave their advisor's lab for a post-doctoral, academic or industry position with much-deserved acclaim.

Our story really starts after that student leaves the lab. Every student and research associate with a few years of experience feels a tremour of fear when their advisor says "Use <graduated student>'s code to analyze your data". In most cases, the software will be undocumented, have a number of eccentricities, and likely will not work without substantial modification. It is a time sink, and the follow-up student will shake their fist and curse the graduated student's name. 


FIXME: explain the problem.

* The difference between software running and being usable.
  * "Works for me on my machine" vs. "works for other people on a cluster I've never met".
* The "right" answer is to create a package on e.g. CPAN with full documentation and a set of regression tests.
  * But not everything worth doing is worth doing right.

How to tell if the software is working:

* Test in a 'vanilla' environment,
  such as another user's computer or a dummy account with none of the settings of the original developer.
* Test with different sizes of data:
  ridiculously small, small, medium, and large.
  The software should run on all sizes given some parameter tweaking,
  or fail with a sensible error message if the data is too big.
* Compare results from multiple iterations that have the same parameters and inputs.
  (See rule #8.)

## 1. Have a README that explains in a few lines what the software does and what its dependencies are.

* This is readable *before* the software is installed (or even downloaded).

## 2. Print usage information when launching from the command line that explains the software's features.

* And tells users where to find more information.

## 3. Do not require root or other special privileges.

## 4. Allow configuration of all major parameters from the command lines, including input files, thresholds, memory required, and other params.

* Configuration files are nice, but awkward to create on the fly when the tool is being run from shell scripts etc.

## 5. Eliminate hard-coded paths.

* Allow the user to set the name and location for the output files or results.
  * Common offenders: reference datasets, output directories.
* Corollary: do not require navigating to a particular directory to work,
  or operate on files only in the current working directory without allowing an override.
  * "Where I have to be" is just another hard-coded path.

## 6. Do not rely on launching software from the command line or by "shelling out" from a script.

* Common offenders: samtools, Picard tools, tabix.
* Those tools may not be installed, or may not be on the path.
* Some leniency here for Bash, R, Python, Java, Perl, and other tools that are included by default in Linux distributions.

## 7. Include a small test set that can be run to ensure the software is actually working.

* This is *not* to check that the software is working correctly (though that would be nice), just that it will actually run.

## 8. Produce identical results when given identical inputs.

* The test set isn't useful without this.
* And people won't be able to debug problems without it either.
* Common offender: random number generators
  * So require their seed as a parameter.
  * Or if the seed is set internally (e.g., using clocktime), echo it to the output for re-use later.

## 9. Do not rely on the pre-installation of non-standard packages or libraries, unless clearly defined in docs.

* Common offenders include a lot of Perl, R, and Python libraries, and user-local scripts.

## 10. Give the software a meaningful version number.

* Make it easy for users to figure out which version they actually have.
* Semantic versioning (and remember to change it on each release).
* Make the version number discoverable (e.g., echo it in usage).
