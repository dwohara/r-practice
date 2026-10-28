# M1_02_practice.R
# Purpose: clean housing_applications.csv
# Input: data/raw/housing_applications.csv
# Output: data/clean/housing_clean.rds

library(tidyverse)
library(here)
library(janitor)

# 1. Peek at the raw data first -----
readLines(here("data", "raw", "housing_applications.csv"))

# NOTE the shape and any obvious discrepancies in the data. In this case the first two rows are a heading and "internal use only" disclaimer.
# the column headings don't begin until row 3

# 2. Read the file in
housing_raw <- read_csv(
  here("data", "raw", "housing_applications.csv"),
  skip = 2,
  col_types = cols(.default = col_character()),
  na = c("","NA", "Unknown"),
  trim_ws = FALSE
)

glimpse(housing_raw)

# 3. Audit the data for discrepancies
# NOTE: there are several issues in this data set
# 1 - there are duplicate case IDs
# 2 - the date received in case A-112 is 2/30 which does not occur, some dates received are after the date decided
# 3 - one income is noted as $1.95 million, unlikely to be applying for housing maybe a flag for follow-up.
# 4 - Inconsistent letter-case use in the caseworker and status columns.

h <- clean_names(housing_raw) # throwaway copy of with tidy names for exploring

# 4.0 Clean the duplicates and incorrect date inputs, arrange to make income more visible
h |> get_dupes(case_id)
count(h, status)
count(h, caseworker)
h |> filter(!is.na(date_received), is.na(ymd(date_received)))
h |> filter(as.integer(household_size) < 1)
h |> filter(ymd(date_decided) < ymd(date_received))
h |> mutate(income = parse_number(annual_income)) |>
  arrange(desc(income)) |> select(case_id, annual_income, income)

# 4.1 Start the cleaning log
file.edit("output/m1_practice_log.md") #documentation

# 4.2 Tidy up the capitalization and caseworker names to consolidate the categories correctly.
housing <- housing_raw |>
  clean_names() |>
  mutate(
    status = str_to_lower(str_squish(status)),
    caseworker = str_to_title(str_squish(caseworker))
  )
names(housing)
count(housing, status)
count(housing, caseworker)

# 4.3 Convert types to standardize
housing <- housing |>
  mutate(
    date_received = ymd(date_received), # Text to date
    date_decided = ymd(date_decided), # Text to date
    household_size = as.integer(household_size), # Text to number
    annual_income = parse_number(annual_income) # $XX,XXX to XXXXX
  )
glimpse(housing)

# 4.4 Remove duplicates
housing |> get_dupes() #view identical duplicates
housing <- housing |> distinct() #remove exact duplicates

# remove the row A-103 with outdated data (no received date)
housing <- housing |>
  group_by(case_id) |>
  slice_max(order_by = date_decided, n=1, with_ties = FALSE) |>
  ungroup()

# 5.0 Add new columns
housing <- housing |>
  mutate(
    days_to_decision = as.numeric(date_decided - date_received),
    needs_review = coalesce(
      is.na(date_received)|
      (date_decided < date_received)|
      (household_size < 1)|
      (annual_income > 500000)|
      is.na(annual_income),
      FALSE
    ))

# 6.0 Add checks and save
stopifnot(
  nrow(housing) == 16, # gives an error if the rows are the incorrect number
  !anyDuplicated(housing$case_id), # gives an error if duplicated case_id persists
  !anyNA(housing$needs_review), # gives an error if review column has NA values
  all(housing$status %in% c("approved", "denied", "pending")) # gives an error if status is not filled.
)

# 6.1 Save the clean file
write_rds(housing, here("data", "clean", "housing_clean.rds"))

