#!/usr/bin/env python
# coding: utf-8
import subprocess
import pathlib

def path_to_pubs(path):
    path = pathlib.Path(path)
    arxiv_id = path.name.split("_")[0].strip()#.strip("papers")
    command = ["pubs", "add", "-X", arxiv_id, "-Md", path.name, "-t Automated"]
    print(' '.join(command))
    subprocess.run(command)

for path in pathlib.Path.cwd().iterdir():
    path_to_pubs(path)
