"""UK New Company Leads - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# New IT and software companies in London, last 7 days
run = client.actor("Turboextract/uk-new-companies").call(run_input={
    "daysBack": 7,
    "sicCodes": [
        "62020",
        "62012"
    ],
    "location": "London"
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("company"), item.get("incorporatedOn"), item.get("postcode"), item.get("industries"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
