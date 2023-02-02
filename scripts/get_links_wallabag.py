#!/usr/bin/env python
import pandas
import os
import string
from urllib.parse import urlparse
import urllib.request
# from tqdm._tqdm_notebook import tqdm_notebook as tqdm
from tqdm import tqdm
import os.path
import time
import random
# from scihub import SciHub
import requests

# only these 5 variables have to be set
HOST = 'https://app.wallabag.it'

def grab_token():
    USERNAME = os.environ["WALLABAG_USERNAME"]
    PASSWORD = os.environ["WALLABAG_PASSWORD"]
    CLIENTID = os.environ["WALLABAG_CLIENT_ID"]
    SECRET = os.environ["WALLABAG_CLIENT_SECRET"]
    gettoken = {'username': USERNAME, 'password': PASSWORD, 'client_id': CLIENTID, 'client_secret': SECRET, 'grant_type': 'password'}
    r = requests.get('{}/oauth/v2/token'.format(HOST), gettoken)
    access = r.json().get('access_token')
    return access

def get_domain(url):
    parsed_uri = urlparse(url)
    result = '{uri.scheme}://{uri.netloc}/'.format(uri=parsed_uri)
    return result

def download_article(link, filename):
    urllib.request.urlretrieve(link, filename)

def get_scihub_links(df, commit=False, download_links = False, wait_time_max = 0):
    journals = "iopscience journals.aps journals.elsevier sciencedirect".split()
    filters =  ~df.resolved_url.dropna().str.contains('synopsis-for', regex=False)
    filters &=  ~df.resolved_url.dropna().str.contains('highlighted-articles', regex=False)
    filters &=  ~df.resolved_url.dropna().str.contains('article-selections', regex=False)
    journal_dfs = [df[df.resolved_url.str.contains(journal, regex=False) & filters] for journal in journals]
    scihub_articles = pandas.concat(journal_dfs)
    if download_links:
        sh = SciHub()

    if not scihub_articles.empty:
        for index, item in tqdm(scihub_articles.iterrows()):
            url = item.given_url
            success = True
            if download_links:
                path = f"/home/dominik/Inbox/ReadingList/papers/"
                wait_time = random.random() * wait_time_max
                time.sleep(wait_time)
                try:
                    download = sh.download(url, path
                    )
                except Exception as e:
                    print(f"Failed to download {url} due to {e}")
                    success = False
                else:
                    success = True
            if success:
                p.archive(item.id)
        if commit:
            p.commit()
    return scihub_articles

def format_filename(s):
    """Take a string and return a valid filename constructed from the string.
    Uses a whitelist approach: any characters not present in valid_chars are
    removed. Also spaces are replaced with underscores.

    Note: this method may produce invalid filenames such as ``, `.` or `..`
    When I use this method I prepend a date string like '2009_01_15_19_46_32_'
    and append a file extension like '.txt', so I avoid the potential of using
    an invalid filename.

    """
    valid_chars = "-_.() %s%s" % (string.ascii_letters, string.digits)
    filename = ''.join(c for c in s if c in valid_chars)
    filename = filename.replace(' ','_') # I don't like spaces in filenames.
    return filename

# coding: utf-8
import subprocess
import pathlib

def path_to_pubs(path):
    path = pathlib.Path(path)
    arxiv_id = ".".join(path.name.split(".")[:-1])
    command = ["pubs", "add", "-X", arxiv_id, "-Md", str(path), "-t", "Automated"]
    print(' '.join(command))
    subprocess.run(command)

def get_arxiv_links(df, download=True):
    arxiv_link_indices = df.given_url.str.contains("arxiv")
    arxiv_df = df.loc[arxiv_link_indices, :]
    if not arxiv_df.empty:
        for _, item in tqdm(arxiv_df.iterrows()):
            link = item.given_url.replace('abs', 'pdf')
            arxiv_index = link.split("/")[-1]
            filename = f"/tmp/" + format_filename(f"{arxiv_index}.pdf")
            if download:
                download_article(link, filename)
            path_to_pubs(filename)
            wallabag_archive(item.id)
    return arxiv_df

access = grab_token()
def get_wallabag_df():
    links = []
    url = f"{HOST}/api/entries.json"
    r = requests.get(url, {"access_token": access,
                           "archive": 0,
                           "detail": "metadata",
                           }).json()
    links.extend(r['_embedded']['items'])
    for page in range(r['page']+1, r['pages'] +1):
        r = requests.get(url, {"access_token": access,
                               "archive": 0,
                               "detail": "metadata",
                               "page": page,
                               }).json()
        links.extend(r['_embedded']['items'])

    return links

def wallabag_archive(ID):
    url = f"{HOST}/api/entries/{ID}.json"
    r = requests.patch(url, {"access_token": access,
                           "archive": 1,
                           }).json()
    return r

def main():
    response = get_wallabag_df()
    df = pandas.DataFrame(response)
    # github = get_github_links(df, p, True)
    arxiv = get_arxiv_links(df, True)

if __name__ == "__main__":
    main()
