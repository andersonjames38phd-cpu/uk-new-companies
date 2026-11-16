// UK New Company Leads - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// New construction companies, last 3 days
const run = await client.actor('Turboextract/uk-new-companies').call({
    "daysBack": 3,
    "sicCodes": [
        "41202",
        "43390"
    ]
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.company, item.incorporatedOn, item.postcode, item.industries);
}
