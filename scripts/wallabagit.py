#!/usr/bin/env python3

import requests
import os
import typer
from rich import print

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



def main(url: str,
         title: str,
         description: str,
         feed_title: str,
         read: bool = False,
         favorited: bool = False):
    a = 1 if read else 0                       # should the article be already read? 0 or 1
    f = 1 if favorited else 0                       # should the article be added as favorited? 0 or 1

    access = grab_token()
    article = {'url': url, 'archive': a , 'starred': f, 'access_token': access}
    r = requests.post('{}/api/entries.json'.format(HOST), article)

if __name__ == "__main__":
    typer.run(main)
