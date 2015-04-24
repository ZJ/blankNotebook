LaTeX Lab Notebook Template
============

This is a set of templates and scripts I personally use to keep an electronic lab notebook.  The nuts and bolts is mostly in the `bin/` directory, where the scripts to generate a today's entry (pulling data from the most recently dated prior entry) live, along with all the others.

##The Scripts##
####bin/today.sh####
This one builds today's entry.  If it already exists, it merely loads it in VIM.  If it does not exist, it creates it.  The template has:

* A header with today's date auto-inserted, and a field for a title for the entry (may be left blank)
* A marked area for the body of the entry
* A list of tasks set for today by the most recently dated entry.  Literally looks at all extant entries and finds the one that comes lexically before today's.
* An empty list of tasks for "tomorrow"

####bin/date.sh####
As for `bin/today.sh`, but acts for a specific date.  invoked as `bin/date.sh YYYYMMDD` for the date desired.  Can be used either to pull up old entries or to create them.

####bin/build.sh####
Assembles all entries together into a single file (`build/fullLabNB.tex`) to be run through a LaTeX engine.  Basically copies all files in the `src/` directories in order, sandwiched by the appropriate entries from `src/template`

##Makefiles##
For systems with `make`, makefiles are also present.  The base makefile has only two working targets:

* `make today` simply runs `bin/today.sh`
* `make` or `make fullLabNB.pdf` runs the full build process for a pdf.  This basically consists of concatenating all src files together with appropriate headers, and running `pdflatex` on the result twice.

##LaTex Header##
Find it in `src/template/fullHeader.tex`

####Packages used####
* **ulem** for the \sout{} command to strikethrough text
* **wrapfig** for figures that text can flow around
* **booktabs** for nicely formatted tables
* **enumitem** to customize space around lists
* **imakeidx** for a custom index for git commits
* **amssymb** for access to a bunch of symbols
* **listings** for source code listing
* **xcolor** for using color
* **tikz-timing** for timing diagrams for electronics
* **suffix** for defining custom commands
* **hyperref** for all the usual hyperlinking niceities

####Custom Commands####
* **\startDay{`<date>`}{`<title>`}** starts a `<date>`'s, with optional `<title>` also displayed.  Automatically adds a label as "date:`<date>`" for use with `\ref{}`
* **\commitR{`<repository>`}{`<hash>`}** add a formatted commit to the text.  Commits show in colored boxes in the format `<repository>`:`<hash>`, and an entry is added to the Git index for this commit.
* **\commitR*{`<repository>`}{`<hash>`}** as above, but the repository name isn't added to the text.  The index entry is still made as normal.
* **\commit{`<hash>`}** add a formatted commit, without referencing any repository.  Still added to the index.
* **\startDone{`<date>`}** starts a subsection labelled "Today's Tasks `<date>`:".  Subsection will not be listed in TOC.
* **\startTodo{`<date>`}** starts a subsection labelled "Tomorrow's Plan `<date>`:"  Subsection will not be listed in TOC.
* **\todo{`<title>`}{`<description>`}** Makes an todo-list item with an unchecked box.  Format is a bold-faced `<title>` followed by a paragraph `<description>`.
* **\tdcheck{`<title>`}{`<description>`}** As above, but with a green crossed out checkbox.
* **\tdfail{`<title>`}{`<description>`}** As above, but with a red checkbox with a red dash in it

####Title Page####
It also insert a title page, with `\title` set as "Lab Notebook", `\author` "Zach Smith", and `\date{\today}`.

##Possible Changes##
* Use LaTeX's `\input{}` instead of doing `cat` in the shell to combine entries
* Make the author and title load from an external, untracked file for portability
