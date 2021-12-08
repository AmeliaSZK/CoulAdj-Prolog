# CoulAdj-Prolog
Computes the list of adjacent colours for each colour in an image.

Primary objective is to help me learn Prolog. 

This project declares conformity to [SemVer 2.0.0](https://semver.org/spec/v2.0.0.html).
There is currently no API version number, because there has been no public release.

**This project is still in development and is not ready for public consumption.**

"Colour" and "color" will be used interchangeably and arbitrarily in both the code
and documentation.

# Educational Objectives
*   Prolog (obviously)
*   Using the buttons in Visual Studio Code as much as possible,
    especially to run (and debug?) programs
*   (How to properly benchmark programs with Python)

# About this Github repository

*   I made this Github repository public so I could share with my twitter friends.
*   It may be made private in the future.

# Known Requirements
*   [SWI-Prolog](https://www.swi-prolog.org/)
*   Linux (probably)

# How to run

If you are on Linux (Ubuntu?) and installed SWI-Prolog through
a Snap, you need to use one of these commands in a terminal to launch
SWI-Prolog:
```
swi-prolog.swipl
swi-prolog.swipl-win
```
The `swipl-win` will launch the GUI, and the other is for use in a
terminal.

At the time of writing, in early development, we use this procedure to
work on the project:

## Ubuntu
1. Open the repo in Visual Studio Code
1. Open an integrated terminal in Visual Studio Code
1. In this terminal, run the command `swi-prolog.swipl CoulAdj.pl`

By specifying `CoulAdj.pl` in argument, SWI-Prolog will consult the
file on launch. Use this command in SWI-Prolog to reconsult files
that changed:

```Prolog
?- make.
```

