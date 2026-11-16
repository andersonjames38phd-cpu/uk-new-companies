#!/usr/bin/env bash
# UK New Company Leads - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~uk-new-companies"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. New IT and software companies in London, last 7 days (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "daysBack": 7,
    "sicCodes": [
      "62020",
      "62012"
    ],
    "location": "London"
  }'

# 2. New construction companies, last 3 days (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "daysBack": 3,
    "sicCodes": [
      "41202",
      "43390"
    ]
  }'

# 3. Every new limited company yesterday, without directors (fast) (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "daysBack": 1,
    "includeOfficers": false,
    "maxResults": 5000
  }'
