#!/bin/bash
WORDCOUNT=$(/home/dominik/.local/bin/jrnl -from 2000 | sed -e 's/| //' | wc -w)
curl -X POST https://www.beeminder.com/api/v1/users/stanczakdominik/goals/jrnl/datapoints.json -d auth_token=$BEEMINDER_TOKEN -d value=$WORDCOUNT
