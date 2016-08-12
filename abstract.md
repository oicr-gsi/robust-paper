# Making research software more robust
Morgan Taschuk and Greg Wilson


Bioinformatics software is often written by a 
single person who is both developer and scientist, intent on producing insightful, novel 
results for their own projects. 
Other people may want to use their methods, but much of academic software is written 
in an ad hoc, exploratory style that is incompatible with reuse. Often, the end user will
need to spend a considerable amount of time either reading code or in
communication with the original developer(s) in order to get the software running. More times than we like to admit,
we will simply give up on the software and either write our own or find
something else that accomplishes the same purpose. This practice is detrimental to
creating reproducible results, to the pace of scientific research, and to
sharing practical knowledge within our community. 
This familiar problem has spawned a range of suggested solutions, from virtual machines
and containerization [1], to more training for bioinformaticians
[2], to reform of scientific reward [3]. All of
these solutions require time and money. 

As an alternative, we present a set of guidelines to encourage code reuse that can be applied
to any language, library, or environment for both open-source and closed-source software.
The recommendations include: creating a minimum set of documentation with a good README
and command-line usage information; avoiding the use of root privileges;
guidelines on hard-coding, config files, and command line arguments;
structuring test sets and scripts; setting version numbers; and making
dependencies and old releases available. By following these guidelines,
bioinformaticians can smooth the transition from exploratory code to software
that is intended for publication, production environments, and general
reuse by the scientific community.




- [1]: Howe, B. _Computing in Science & Engineering_ 14:4, 36-41 http://dx.doi.org/10.1109/MCSE.2012.62 (2012). 
- [2]: Lawlor, B. & Walsh, P. _Bioengineered_ 6:4, 193-203 http://dx.doi.org/10.1080/21655979.2015.1050162 (2015). 
- [3]: Prins, P. et al. _Nature Biotech._ 33:7 686-687 http://dx.doi.org/10.1038/nbt.3240 (2015). 
