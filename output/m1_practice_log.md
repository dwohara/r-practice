# Housing applications: cleaning log

| # | Problem | Where | What I did | Why |
|---|---------|-------|-----------|-----|
| 1 | Two junk lines above the header | Rows 1-2 of file |Removed |Not relevant data for analysis |
| 2 | Exact duplicate row | A-102 |Removed |Exact duplicate data confounds analysis |
| 3 | Same case ID, conflicting values | A-103 |Removed row with no decision date |row with decision date indicates previous row is outdated.  |
| 4 | Status written inconsistently (case, spaces) | status |made sentence case agree |ensured information was categorized correctly e.g. Accept=accept |
| 5 | Caseworker written inconsistently (case) | caseworker |made name case agree |case workers aren't double counted due to letter-case |
| 6 | Impossible date (Feb 30) | A-108, date_received |flagged for review |appears to be an error |
| 7 | Decision date before received date | A-106 |flagged for review |appears to be an error |
| 8 | Household size of 0 | A-110 |flagged for review| appears to be an error|
| 9 | Income of $1,950,000 (likely typo) | A-113 |flagged for review |appears to be an error |
| 10 | Income recorded as "Unknown" | A-111 |flagged for review | appears to be an input error|
| 11 | Income stored as text with $ and commas | annual_income | parsed to a plain number|aids in ease of analysis |

