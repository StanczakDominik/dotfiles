#!/usr/bin/env python3
"""
How can I list all existing workspaces in JupyterLab?

as answered @
https://stackoverflow.com/questions/52656747/how-can-i-list-all-existing-workspaces-in-jupyterlab/53011827#53011827
"""
import argparse

# construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-f", "--full", action="store_true", required=False,
    help="prints full path")
ap.add_argument("-u", "--url", action="store_true", required=False,
    help="prints full path")
ap.add_argument("-H", "--host", required=False, help="use the given host", default='localhost')
ap.add_argument("-P", "--port", required=False, help="use the given port", default='8888')
args = vars(ap.parse_args())

import os, glob, json
for fname in glob.glob(os.path.join(os.environ['HOME'], ".jupyter/lab/workspaces/*")):
    with open (fname, "r") as read_file:
        id = json.load(read_file)['metadata']['id']

    if args['full']:
        print('id', id, '/ fname', fname)
    elif args['url']:
        print(f"http://{args['host']}:{args['port']}{id}")
    else:
        print('id', id)
