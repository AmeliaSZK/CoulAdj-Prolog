import subprocess

print("benchmark started")

subprocess.run(
    ["swi-prolog.swipl", 
    "CoulAdj.pl", 
    "tests/knowledge-bases/pixels-size-p.pl", 
    "tests/results/result-size-p.tsv"]).check_returncode()








