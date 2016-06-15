#Ten Simple Rules for Making Research Software More Robust

* Morgan Taschuk (OICR)
* Greg Wilson (Software Carpentry/OICR)

> ## Abstract
>
> **FIXME: abstract**

## Introduction

As a relatively young field, bioinformatics is full of newly developed software.
**FIXME: EXAMPLES HERE**
Efforts such as [the ELIXIR tools and data registry][elixir-registry]
and the [Bioinformatics Links Directory][bioinfo-links-dir]
[(ref)][bioinfo-links-dir-ref]
have made efforts towards cataloguing the available software.
As of May 2016, ELIXIR lists 2500 software entries and the Bioinformatics.ca lists 1700.
For many data types, there is no 'right' way to perform analysis as yet.
For example, although short read sequencers are ten years old, the leading
sequencing companies regularly update their instruments and chemistry to push
the boundaries of the possible ever higher
**FIXME: illumina HiseqX, 10X genomics, nanopore sequencing**.
New sequencing initiatives are exploring the human microbiome, the depths of
the ocean, and even the outer reaches of space. For many of these new data
types, we have not reached the boundaries of what is possible. We are also
sequencing data in quantities never before seen. The 1000 Genomes project seems
quaint next to the UK's 100k project and Human Longevity's pledge to
[sequence 100,000 genomes per year by the end of 2016][sequence-100k].
As of release 21, the International Cancer Genome Consortium has sequenced
15 000 individuals and the data are [publicly available[icgc].
**FIXME: PULL MORE STATS FROM [ICGCMED PAPER][icgcmed-white-paper]**.

This is a very exciting time for bioinformatics. As a direct result, many
trainee projects produce code and software to support their
thesis project or post-doctoral research.  This software runs on the data gathered by the
student's lab, and produces excellent results in their hands.

But what happens after that student leaves that lab?  Everyone
with a few years of experience feels a tremor of fear when told,
"Use \<graduated student\>'s code to analyze your data".
In most cases, that software will be undocumented and work in unexpected ways
(if it works at all without substantial modification).
In most cases,
the new user winds up shaking their fist and cursing the graduated student's
name.  She then has two choices: hack the existing code to make it work for her,
or start over.

The root cause of this problem is that most of the software
researchers produce isn't *robust*.  The difference between running
and being robust is the difference between "works for me on my
machine" and "works for other people on a cluster I've never used".
In particular, robust software:

*   Is kept under version control.
*   Can be installed on systems outside the original institution
*   Works for users other than the original author
*   Has well-defined input and output formats
*   Has documentation that describes what its dependencies are,
    how to install it, and what the options are.
*   Comes with enough tests to show that it actually runs.

These are all necessary steps toward creating a reusable library that
can be shared through a site like CPAN or CRAN, and apply to both
closed-source and open-source software.  They do not depend on
specific languages, libraries, packages, documentation styles, or
operating systems.  Whether the aim is as simple as sharing the code
with collaborators or as complex as using the software in a production
analysis environment, increasing the robustness of your software
decreases headaches all around.

Note: we do not recommend that these rules be applied to *every*
coding effort. The vast majority of code produced in the marathon of a
graduate thesis is "throw-away" code that is used once to answer a
specific question related to a specific dataset. However, once that
little script is dragged out three or four times for slightly
different purposes, it may be time to apply ten simple rules for
robust software.  As the saying goes, not everything worth doing is
worth doing right away.

Throughout this document we will be using a small software package
called [debarcer][debarcer] to illustrate
the rules of robust software.  We are grateful to its author, Paul
Krzyzanowski, for many insightful discussions.

## 1. Have a README that explains in a few lines what the software does and what
its dependencies are.

The README is the first stop for any potential users interested in your
software. At a minimum, it needs to provide or point to everything a new user
needs to get started, where they can turn to for help, and which licenses apply
to the software package. Exhaustive details regarding parameters and usage are
not usually necessary in a README if they are present in usage (#2), although a
working example using test data (per #9) is always appreciated.

**Explain what the software does:** At the beginning of the README, explain what
the software does in one or two sentences. The description does not need to be
long or detailed. There's nothing more frustrating than spending the time to
download and install some software only to find out that it doesn't do what you
thought it did.

    Debarcer (De-Barcoding and Error Correction) is a package for working with
    next-gen sequencing data that contains molecular barcodes.

**List required dependencies:** Often, software depends on very specific
versions of libraries, modules, or operating systems. This is entirely
reasonable as long as it is properly documented.  Often, multiple libraries
exist with the same or very similar names, so either provide the commands
necessary to download the dependencies or link to the software homepage. Include
the version number for each dependency. Especially if you use older versions,
include links where the packages can be downloaded. Package managers like apt,
pip and homebrew stop offering older packages after a few years. [IS THIS TRUE
OF PIP AND HOMEBREW?]

If your dependency is to an internal package that is not available on the
internet, you have several options depending on the sensitivity of the code in
question. If it is plain text, you can add it directly to you repository with
appropriate attribution. If the dependency is a binary, we recommend using a
[binary repository manager][binary-repo-manager] such as
Artifactory or ProGet. These managers keep versioned copies of software at
constant URLs so they can be downloaded as long as the manager continues to run.
As a last resort, you can place it at an internal location on shared disk,
remove all write permissions, and link to it from your README, although this
method is heavily discouraged because of the potential for the directory to go
missing because of factors outside the developer's control.

**Installation instructions:** If the software needs to be compiled or
installed, list those instructions in the readme. New users may not be familiar
with your build system, even if it is `make`. Also mention here if you
recommend they use a pre-compiled binary instead through a system such as pip
or apt.

**Input and output files**: All possible input and output files should be
listed in this section. Do the files conform to a particular industry standard,
an extension of an existing format, or is it your own format? If using a
standard format, link to the specification and version. If you extend the
standard or have your own format, define it here explicitly, listing all the
required fields and acceptable values. (You get bonus points if you include a
script to convert between standard format and your file format). If there is no
rigorous format (such as with log files), show an example file, or the first
few lines, and explain what the sections mean.

Input files and their formats are included in most documentation. However, the
definitions of the output files are often missing. In addition to the expected
output, software will often produce intermediate files, auxilliary files, and
log files. We believe *all* output files should be listed in the README. Log
and auxilliary files are often full of valuable information that can be mined
for the user's specific purpose. Even if the files are considered
self-explanatory. Sometimes your users will need to answer a question of the
format, "Does X tell you the percentage of reads trimmed to remove adapter
sequences?" and you can check the documentation and confidently say "yes, it is
in the log file".


**Attributions and licensing:** Attributions are how you credit your main
contributors; licenses are how you want others to use and credit your software.
Both are important in your README. Leave no question in anyone's mind about
whether your software can be used commercially, how much modification is
permitted, and how other software needs to attribute to you. If your software
is not open source, include a statement here. Attributions can also contain a
list of 'expert' users that can be contacted if new users have problems with
the software. (for better or for worse)

* This is readable *before* the software is installed (or even downloaded).
* Should also include (or better yet, point to) the license for the software,
  so that (potential) users will know what they're allowed to do.
* **FIXME: example from real software: https://github.com/dib-lab/khmer/blob/master/README.rst**

## 2. Print usage information when launching from the command line that explains the software's features.

Users who simply use your software after installation may not have
access your well-crafted README. The usage information provides a first line of
help. 

Ideally, usage is a terse, informative command-line help message that guides
the user in the correct use of your software. Note that I say "terse": usage
that extends for multiple screens, especially when printed to standard error
instead of standard out, is a nuisance. Usage gives you all of the information
necessary to run the software. It is usually invoked either by running the
software without any arguments; running the software with incorrect arguments;
or by explicitly choosing a help or usage option.

Some examples of good usage:

```
$ mkdir --help
Usage: mkdir [OPTION]... DIRECTORY...
Create the DIRECTORY(ies), if they do not already exist.

Mandatory arguments to long options are mandatory for short options too.
  -m, --mode=MODE   set file mode (as in chmod), not a=rwx - umask
  -p, --parents     no error if existing, make parent directories as needed
  -v, --verbose     print a message for each created directory
  -Z, --context=CTX  set the SELinux security context of each created
                      directory to CTX
      --help     display this help and exit
      --version  output version information and exit

Report mkdir bugs to bug-coreutils@gnu.org
GNU coreutils home page: <http://www.gnu.org/software/coreutils/>
General help using GNU software: <http://www.gnu.org/gethelp/>
For complete documentation, run: info coreutils 'mkdir invocation'

$ R --help

Usage: R [options] [< infile] [> outfile]
   or: R CMD command [arguments]

Start R, a system for statistical computation and graphics, with the
specified options, or invoke an R tool via the 'R CMD' interface.

Options:
  -h, --help            Print short help message and exit
  --version             Print version info and exit
  --encoding=ENC        Specify encoding to be used for stdin
  ...			...

Please use 'R CMD command --help' to obtain further information about
the usage of 'command'.

...

Report bugs at bugs.r-project.org


$ svn --help
usage: svn <subcommand> [options] [args]
Subversion command-line client, version 1.8.8.
Type 'svn help <subcommand>' for help on a specific subcommand.
Type 'svn --version' to see the program version and RA modules
  or 'svn --version --quiet' to see just the version number.

Most subcommands take file and/or directory arguments, recursing
on the directories.  If no arguments are supplied to such a
command, it recurses on the current directory (inclusive) by default.

Available subcommands:
   add
   blame (praise, annotate, ann)
   cat
   changelist (cl)
   checkout (co)
   ...

Subversion is a tool for version control.
For additional information, see http://subversion.apache.org/
```

There is no standard format for usage statements, but good ones have several
key aspects:

**The syntax for running the program**: Defines the relative location of
optional and required flags and arguments for execution. Include the name of
the program, the relative location of any flags, and the required arguments.
Arguments in [square brackets] tend to be optional. Multiple periods (e.g.
"[OPTION]...") indicate that more than one can be provided.

**A text description of its purpose**: Similar to the README, the description
reminds users of the software's primary function.

**Most commonly used flags, a description of each flag, and the default
value**: Not all flags need to appear in the usage, but the most commonly used
ones should be listed here. Users will rely on this for quick reference when
working with your software.

**Where to find more information**: Whether an email address, web site or man
page, there should be an indication where the user can go to find more
information about the software. 

**Printed to standard out** : This is debateable, but the author(s) prefer
their usage printed to standard out so that it can be piped into `less` or
`grep`ed through.

**Exit with an appropriate exit code**: When usage is invoked through providing
incorrect parameters, exit with a non-zero code. However, when help is
explicitly requested, the software should not exit with an error.
Occasionally, requesting help is used to verify that a dependency is available.



* And tell users where to find more information.
* **FIXME: example from real software (some package you think does this well)**

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

## Conclusion

How to tell if the software is working:

*   Test in a 'vanilla' environment, such as another user's computer or a dummy
    account with none of the settings of the original developer.
*   Test with different sizes of data:
    ridiculously small, small, medium, and large.  The software should run on all
    sizes given some parameter tweaking, or fail with a sensible error message if
    the data is too big.
*   Compare results from multiple iterations that have the same parameters and
    inputs.(See rule #8.)

[binary-repo-manager]: https://en.wikipedia.org/wiki/Binary_repository_manager
[bioinfo-links-dir]: https://bioinformatics.ca/links_directory/
[bioinfo-links-dir-ref]: http://dx.doi.org/10.1093/nar/gks632
[debarcer]: https://github.com/oicr-gsi/debarcer
[elixir-registry]: http://dx.doi.org/10.1093/nar/gkv1116
[icgc]: https://dcc.icgc.org
[icgcmed-white-paper]: http://icgcmed.org/files/ICGCmed_White_Paper_April_2016.pdf
[sequence-100k]: http://www.darkdaily.com/worlds-two-largest-whole-genome-sequencing-programs-give-pathologists-and-clinical-laboratory-managers-an-intriguing-look-at-new-diagnostic-opportunities-0502#axzz49tdSMDXq
