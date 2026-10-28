# m1_03_check.R
library(tidyverse)
library(here)

d <- read_rds(here("data", "clean", "housing_clean.rds"))

check <- function(label, condition) {
  cat(if (isTRUE(condition)) "PASS" else "FAIL", "-", label, "\n")
}

needed <- c("case_id", "date_received", "date_decided", "household_size",
            "annual_income", "status", "caseworker", "days_to_decision",
            "needs_review")
check("all expected columns exist", all(needed %in% names(d)))
check("16 rows (one per case)", nrow(d) == 16)
check("case_id is unique", !anyDuplicated(d$case_id))
check("dates are Date class",
      inherits(d$date_received, "Date") && inherits(d$date_decided, "Date"))
check("income and household size are numeric",
      is.numeric(d$annual_income) && is.numeric(d$household_size))
check("status values standardized",
      setequal(unique(d$status), c("approved", "denied", "pending")))
check("status counts (10 approved, 4 denied, 2 pending)",
      identical(as.integer(table(factor(d$status,
                                        levels = c("approved", "denied", "pending")))), c(10L, 4L, 2L)))
check("caseworker names standardized",
      setequal(unique(d$caseworker), c("Kim", "Lopez", "Okafor")))
check("needs_review has no NA", !anyNA(d$needs_review))
check("needs_review flags exactly the right cases",
      setequal(d$case_id[d$needs_review %in% TRUE],
               c("A-106", "A-108", "A-110", "A-111", "A-113")))
dtd <- as.numeric(d$days_to_decision)
check("mean days to decision (valid cases) is about 32.42",
      abs(mean(dtd[dtd >= 0], na.rm = TRUE) - 32.42) < 0.01)
check("median income is 29,900",
      abs(median(d$annual_income, na.rm = TRUE) - 29900) < 1)

