import subprocess, time, os.path

swi_prolog_executable = "swi-prolog.swipl"
couladj_prolog = "CoulAdj.pl"

pixels_directory = "tests/knowledge-bases/"
result_directory = "tests/results/"
golden_results = "tests/golden.tsv"

print("benchmark started")

size = 1
pixels_filename = f"pixels-size-{size}.pl"
result_filename = f"result-size-{size}.tsv"
pixels_path = os.path.join(pixels_directory, pixels_filename)
result_path = os.path.join(result_directory, result_filename)

subprocess.run(
    [swi_prolog_executable, 
    couladj_prolog, 
    pixels_path, 
    result_path]).check_returncode()








