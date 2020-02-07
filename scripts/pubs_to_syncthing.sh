#!/bin/bash
pubs doc export $(pubs list tag:TODO -k | xargs) ~/Sync/ReadNow/
