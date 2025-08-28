import glob
import dadi

fs_files = glob.glob("dadi_results/southern/*.fs")

for fs_file in fs_files:
    fs = dadi.Spectrum.from_file(fs_file)
    print(f"{fs_file}: S = {fs.S()}")
