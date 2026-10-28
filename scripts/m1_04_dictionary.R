# m1_04_dictionary.R
# Purpose: write the data dictionary for the cleaned housing data
# Output:  output/tables/housing_data_dictionary.csv

library(tidyverse)
library(here)

housing <- tribble(
  ~variable,          ~type,      ~description,                                      ~notes,
  "case_id",          "text",     "Unique application ID",                           "Format A-###; one row per case",
  "date_received",    "date",     "Date the application was received",               "NA if the original date was invalid (A-108)",
  "date_decided",     "date",     "Date a decision was made",                        "NA for pending cases (expected)",
  "household_size",   "integer",  "Number of people in the household",               "1 or more; values below 1 are flagged",
  "annual_income",    "numeric",  "Applicant's annual income in dollars",            "NA if not reported; values over 500,000 are flagged",
  "status",           "text",     "Application status",                              "approved, denied, or pending (lowercase)",
  "caseworker",       "text",     "Caseworker handling the case",                    "Kim, Lopez, or Okafor (title case)",
  "days_to_decision", "numeric",  "Days from date_received to date_decided",         "NA if either date is missing; negative values are flagged",
  "needs_review",     "logical",  "TRUE if the row has a data quality issue",        "See cleaning log for the rules"
)

write_csv(
  housing,
  here("output", "tables", "housing_data_dictionary.csv")
)
