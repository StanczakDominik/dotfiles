#!/usr/bin/env python3

import requests
import os
import typer
from rich import print

import logging
import contextlib
try:
    from http.client import HTTPConnection # py3
except ImportError:
    from httplib import HTTPConnection # py2

def debug_requests_on():
    '''Switches on logging of the requests module.'''
    HTTPConnection.debuglevel = 1

    logging.basicConfig(
        format='%(asctime)s %(name)-12s %(levelname)-8s %(message)s',
        datefmt='%m-%d %H:%M',
        filename='/home/dominik/.newsboat/requests.log',
        filemode='a')
    logging.getLogger().setLevel(logging.DEBUG)
    logging.getLogger().propagate = False
    requests_log = logging.getLogger("requests.packages.urllib3")
    requests_log.setLevel(logging.DEBUG)
    requests_log.propagate = False

def debug_requests_off():
    '''Switches off logging of the requests module, might be some side-effects'''
    HTTPConnection.debuglevel = 0

    root_logger = logging.getLogger()
    root_logger.setLevel(logging.WARNING)
    root_logger.handlers = []
    root_logger.propagate = False
    requests_log = logging.getLogger("requests.packages.urllib3")
    requests_log.setLevel(logging.WARNING)
    requests_log.propagate = False

@contextlib.contextmanager
def debug_requests():
    '''Use with 'with'!'''
    debug_requests_on()
    yield
    debug_requests_off()

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
    logging.debug(str(locals()))
    a = 1 if read else 0                       # should the article be already read? 0 or 1
    f = 1 if favorited else 0                       # should the article be added as favorited? 0 or 1

    with debug_requests():
        access = grab_token()
        article = {'url': url, 'archive': a , 'starred': f, 'access_token': access}
        r = requests.post('{}/api/entries.json'.format(HOST), article)

if __name__ == "__main__":
    typer.run(main)
