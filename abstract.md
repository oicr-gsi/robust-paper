## Making research software more robust
Morgan Taschuk and Greg Wilson


At the cutting edge of research, bioinformatics software is often written by a
single person who is both developer and scientist, producing insightful, novel
results for their own projects. Upon presenting their work, other
people will want to use their methods. But much of academic software is written
in a prototypic, exploratory and rigid style that is incompatible with reuse. Often, the end user will
need to spend a considerable amount of time either reading code or in
communication with the original developers. More times than we like to admit,
we will simply give up on the software, either writing our own or finding
another that accomplishes the same purpose. This practice is detrimental to
creating reproducible results, to the pace of scientific research, and to
creating bioinformatics communities that build on each other's work.

This familiar problem has spawned a range of solutions, from virtual machines
and containerization[(1)][vms], to more training for bioinformaticians
[(2)][engineering], to reform of scientific reward [(3)][big-biology]. All of
these solutions require time and money, and none directly contribute to
scientific advancement. What can the front-line bioinformatician do right now
to create robust code suitable for reproducible publication, to encourage
collaboration, or to pass their project onto another?

We present a set of guidelines to encourage code reuse that can be applied
to any language, library, or environment for both open-source and closed-source software.
The recommendations include: creating a minimum set of documentation with a good README
and command-line usage information; avoiding the use of root privileges;
guidelines on hard-coding, config files, and command line arguments;
structuring test sets and scripts; setting version numbers; and making
dependencies and old releases available. By following these guidelines,
bioinformaticians can smooth the transition from exploratory code to software
that is intended for publication, production environments, and general
reuse by the scientific community.




[vms] : http://dx.doi.org/10.1109/MCSE.2012.62
[engineering] : http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4601517/
[big-biology]: http://www.nature.com/nbt/journal/v33/n7/full/nbt.3240.html
