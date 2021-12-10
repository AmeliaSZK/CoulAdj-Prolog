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
*   Python 3

# How to run

General procedure to run non-interactively:
```
$ swi-prolog.swipl CoulAdj.pl pixel_values.pl results.tsv
```
The file `pixel_values.pl` must contain Prolog "facts" in a specific format.
This format is describe in the first line of each existing file.
(I know this isn't much documentation, but sample files have already been made,
and this project is still in active development, so this area of the
specification is still highly volatile)

To run a quick test of correctness:
```
$ swi-prolog.swipl CoulAdj.pl tests/knowledge-bases/pixels-size-p.pl tests/results/result-size-p.tsv
```
After running this command, check with git if there was a change in `tests/results/result-size-p.tsv`.
If the file is still the same, your results should be correct.
(I say "should", because this is just a quick test, and I'm only documenting
it because right now, the Python script to (only) check correctness isn't even written.)

## Benchmarks
In order to run the benchmark script, `benchmark.py`, go look at its source,
at the top of the file, and make sure that the variable `swi_prolog_executable`
points to the correct SWI-Prolog executable on your machine.

How to run the benchmarks:
```
$ python3 benchmark.py
```
At the time of writing, expect the full benchmark to take about *5 minutes*.
Or maybe 10.

You can reduce this to about 20 seconds by going in the python script (`benchmark.py`),
at the bottom of the file, and removing the size 16 from the tested sizes.

So, to reduce the benchmark duration to 20 seconds, this code:
```Python
for size in [1,2,4,8,16]:
    test_one_size(size)
```
Needs to become this:
```Python
for size in [1,2,4,8]:
    test_one_size(size)
```

Also, this change may have already been done, and I just haven't updated 
the readme yet.



# Acquisition of big test samples
_As of now, the implementation is still quadratic, so we recommend
that you do **not** acquire the bigger samples._

This repo comes with several test samples in `tests/knowledge-bases` that are
meant to profile the performance. The problem is that these files can get big.
The files already included are those that are below 1 MB in size. 
This section explains how to acquire all the other sizes.
Acquiring these files is optional, as the benchmarking script was written
with the assumptions that they may be missing.

## Requirements
*   7zip
*   825 MB (recommended)
*   200 MB (minimum)

There are 5 files that are kept on another repo, in two separate archives.
These files are:
```
pixels-size-32.pl
pixels-size-64.pl
pixels-size-128.pl
pixels-size-256.pl
pixels-size-512.pl
```
Sizes 32 to 256 are in a single archive of 1.3 MB.
Size 512 is in its own archive of 4.7 MB.

The following table details the uncompressed size of each file:

| File | Uncompressed Size |
|------|-------------------|
| pixels-size-32.pl  |   2.2 MB |
| pixels-size-64.pl  |   8.9 MB |
| pixels-size-128.pl |  36.0 MB |
| pixels-size-256.pl | 148.8 MB |
| pixels-size-512.pl | 604.8 MB |

## Procedure
This procedure assumes you'll want all sizes.
If you intend to skip the size 512, skip the relevant steps
1. Go to the Github [CoulAdj Test Samples repository](https://github.com/AmeliaSZK/CoulAdj-TestSamples)
1. Download `prolog-pixels-sizes-32-to-256.7z`
1. Download `prolog-pixels-size-512.7z`
1. In the `CoulAdj-Prolog` repo, the one that contains the readme file that you
are reading right now, extract both archives in `tests/knowledge-bases/`

**Before** extraction, this what `tests/knowledge-bases/` should contain:
```
.gitignore
pixels-size-1.pl
pixels-size-2.pl
pixels-size-4.pl
pixels-size-8.pl
pixels-size-16.pl
pixels-size-p.pl
```

**After** extraction, this what `tests/knowledge-bases/` should contain:
```
.gitignore
pixels-size-1.pl
pixels-size-2.pl
pixels-size-4.pl
pixels-size-8.pl
pixels-size-16.pl
pixels-size-32.pl
pixels-size-64.pl
pixels-size-128.pl
pixels-size-256.pl
pixels-size-512.pl
pixels-size-p.pl
```

