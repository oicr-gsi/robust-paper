#Ten Simple Rules for Making Research Software More Robust

Software produced for research, even published software, suffers from a number of common problems that make it difficult, if not impossible, to run outside the original institution or even the primary developer's computer. We present ten simple rules to make your software robust enough to run anywhere and delight your users and collaborators.

## Dependencies

* To build the PDF:
  * LaTeX packages appropriate for your computer. On Ubuntu 16.04, `sudo apt-get install texlive-full`

## Build

The paper is written in LaTeX and can be built using `make`;

    make pdf
