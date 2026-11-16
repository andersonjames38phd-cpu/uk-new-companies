# UK New Company Leads from Companies House

[![Apify Actor](https://img.shields.io/badge/Apify-Actor-blue?logo=apify)](https://apify.com/Turboextract/uk-new-companies)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Pricing](https://img.shields.io/badge/pricing-%240.003%20per%20company-brightgreen)](#pricing)

**Get every company incorporated in the UK in the last few days, with its directors.** Filter by SIC code, company type and registered office location, and get the company number, incorporation date, registered office, SIC codes with plain-English industries, and each current officer's name, role, appointment date and nationality. Data comes straight from the official Companies House register.

Around 3,000 UK companies are incorporated every working day, and 14,480 between 10 and 16 November 2026. Each one needs a bank account, an accountant, insurance, a website and software in its first month.

**Try it now →** [apify.com/Turboextract/uk-new-companies](https://apify.com/Turboextract/uk-new-companies)

---

## Why this exists

- Around 3,000 UK companies are incorporated every working day.
- Each needs a bank account, an accountant, insurance and a website in its first month.
- Companies House search shows 20 results a page and directors on a separate page.
- UK company data providers charge monthly subscriptions.

---

## Who this is for

- **Accountants and bookkeepers** reaching new limited companies before their first accounts are due
- **Business banks, fintechs and payment providers** onboarding new companies
- **Insurance brokers** selling business, professional indemnity and employer's liability cover
- **Web, marketing and branding agencies** pitching a first website
- **SaaS sales teams** targeting new businesses in a specific SIC code
- **Researchers** tracking business formation by industry and region

---

## What you get per company

```json
{
  "company": "ASH DIGITAL & AI SOLUTIONS LTD",
  "companyNumber": "17583219",
  "status": "Active",
  "companyType": "Private limited company",
  "incorporatedOn": "2026-11-16",
  "registeredOffice": "Flat 5 Sandby House, Peckham Road, London, England SE5 8QN",
  "postcode": "SE5 8QN",
  "sicCodes": ["58290", "62012", "62020"],
  "industries": [
    "Other software publishing",
    "Business and domestic software development",
    "Information technology consultancy activities"
  ],
  "officers": [
    { "name": "M. A. H.", "role": "Director", "appointedOn": "2026-11-16", "nationality": "British", "countryOfResidence": "England" },
    { "name": "Y. W.", "role": "Director", "appointedOn": "2026-11-16", "nationality": "British", "countryOfResidence": "England" }
  ],
  "companyUrl": "https://find-and-update.company-information.service.gov.uk/company/17583219"
}
```

---

## How it works

```mermaid
flowchart LR
    A[Date range, SIC codes, location] --> B[Companies House advanced search]
    B --> C[One search per day and SIC code]
    C --> D[Current officers for each company]
    D --> E[SIC codes to industry names]
    E --> F[One row per new company]
```

The actor reads the public Companies House register one incorporation day at a time, newest first, and paces its requests politely. No API key needed.

---

## Quick start

1. Click **Try for free**.
2. Keep **Incorporated in the last N days** at `3`.
3. Add **SIC codes** like `62020` (IT consultancy) or `56101` (restaurants), or a **Registered office location** like `Manchester`.
4. Keep **Include directors** on for named contacts.
5. Click **Start**, then schedule it daily.

### API

```bash
curl -X POST "https://api.apify.com/v2/acts/Turboextract~uk-new-companies/run-sync-get-dataset-items?token=YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "daysBack": 7,
    "sicCodes": ["62020", "62012"],
    "location": "London",
    "maxResults": 500
  }'
```

### Python

```python
from apify_client import ApifyClient

client = ApifyClient("YOUR_TOKEN")
run = client.actor("Turboextract/uk-new-companies").call(run_input={
    "daysBack": 3,
    "sicCodes": ["41202", "43390"],
    "includeOfficers": True,
})
for c in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(c["company"], c["postcode"], [o["name"] for o in c["officers"]])
```

---

## Input fields

| Field | Default | What it does |
|---|---|---|
| `daysBack` | 3 | Incorporated in the last N days |
| `dateFrom` / `dateTo` | – | Exact date range |
| `sicCodes` | – | 5-digit SIC codes |
| `nameIncludes` | – | Company name contains a word |
| `location` | – | Town, city or postcode of the registered office |
| `companyTypes` | ltd | Private limited, PLC, LLP and more |
| `activeOnly` | true | Skip dissolved companies |
| `includeOfficers` | true | Add current directors and secretaries |
| `maxResults` | 200 | Cap per run, newest first |

---

## Pricing

**$0.003 per new company delivered**, directors included.

| Option | 1,000 new UK companies |
|---|---|
| **UK New Company Leads** | **$3**, directors and industries included |
| Other Companies House actors on Apify | $1.35 to $10, some charge extra for officers |
| UK company data providers | Monthly subscriptions |
| Searching Companies House by hand | One company at a time |

---

## Common use cases

- **Accountancy outreach**: new limited companies in your town, every morning
- **Fintech onboarding**: new e-commerce and software companies this week
- **Trades insurance**: new construction and electrical companies by SIC code
- **Market research**: incorporations by industry and postcode
- **Formation agents and virtual offices**: see which addresses new companies register at

---

## Tips for best results

- Add one or more SIC codes, since each is searched separately and stays under the 5,000 result cap.
- Use `location` with a town or postcode area for local outreach.
- Turn off `includeOfficers` for fast market counts.
- Dedupe on `companyNumber` across runs.

---

## Pairs well with

- [New Business Registrations](https://apify.com/Turboextract/new-business-registrations): the same feed for five US states
- [Global Sanctions Screening](https://apify.com/Turboextract/global-sanctions-screening): screen directors and companies against UK, EU, UN and US lists
- [B2B Lead Enrichment Pipeline](https://apify.com/Turboextract/b2b-lead-enrichment-pipeline): add website contacts once a company has a domain

---

## FAQ

**Is there a limit?** Companies House shows at most 5,000 results per search. The actor searches one day at a time, which covers a full day, and searches each SIC code separately when you list several.

**Does it include emails or phone numbers?** Companies House does not publish them. You get the registered office and directors' names.

**Why do some officers have no occupation?** It is optional on the incorporation form, so many founders leave it blank.

**Is this legal to use?** Companies House register data is public and free to reuse. Directors' details are personal data under UK GDPR, so have a lawful basis such as legitimate interest and follow PECR when you contact them.

---

## SEO keywords

new UK companies, Companies House new incorporations, newly incorporated companies UK, UK company leads, new limited companies list, Companies House scraper, UK startups list, new businesses UK, UK directors leads, SIC code company search

---

## Support

- Actor page: https://apify.com/Turboextract/uk-new-companies
- Issues and questions: open an issue in this repo
- Community Discord: https://discord.gg/8SrXSCpvgj

Built and maintained by [Turboextract](https://apify.com/Turboextract) on the Apify platform.

---

## License

The documentation and examples in this repository are MIT licensed. The actor itself runs on the Apify platform.
