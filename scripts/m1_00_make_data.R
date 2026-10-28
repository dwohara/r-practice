# m1_00_make_data.R
# Purpose: write the two practice datasets to data/raw/ (stands in for a download)
library(here)
dir.create(here("data", "raw"), showWarnings = FALSE, recursive = TRUE)

writeLines(c(
  'Participant ID,Enroll Date,Site Name,Age,Monthly Income,Completed?,Wage After',
  '1001,03/15/2023,Downtown ,34,"$1,200",Yes,18.5',
  '1002,03/17/2023,north side,29,"$850",no,N/A',
  '1003,04/02/2023,DOWNTOWN,41,-99,YES,21',
  '1004,04/05/2023,Eastgate,52,"$2,100",Yes,',
  '1005,04/09/2023,north side,23,"$0",No,-99',
  '1002,03/17/2023,north side,29,"$850",no,N/A',
  '1006,04/12/2023,Eastgate ,38,"$1,500",Yes,19.75',
  '1007,05/01/2023,Downtown,,"$1,050",no,N/A',
  '1008,05/03/2023,North Side,47,"$2,400",Yes,24'
), here("data", "raw", "training_enrollment.csv"))

writeLines(c(
  'Housing Assistance Applications - Export 2023-06-30',
  'Internal use only',
  'Case ID,Date Received,Date Decided,Household Size,Annual Income,Status,Caseworker',
  'A-101,2023-01-09,2023-02-14,3,"$32,500",Approved,Lopez',
  'A-102,2023-01-11,2023-01-30,1,"$18,200",denied,Kim',
  'A-103,2023-01-15,,4,"$41,000",PENDING,lopez',
  'A-104,2023-01-20,2023-03-02,2,"$27,800",Approved ,KIM',
  'A-105,2023-02-02,2023-02-27,5,"$55,300",Denied,Okafor',
  'A-106,2023-02-10,2023-02-01,2,"$22,000",Approved,Okafor',
  'A-107,2023-02-14,2023-03-20,1,"$15,400",approved,Lopez',
  'A-108,2023-02-30,2023-03-30,3,"$29,900",Approved,Kim',
  'A-109,2023-03-03,2023-04-11,6,"$61,250",Denied,Okafor',
  'A-110,2023-03-08,2023-04-05,0,"$20,000",Approved,Lopez',
  'A-111,2023-03-15,,2,Unknown,Pending,Kim',
  'A-112,2023-03-22,2023-04-18,4,"$38,700",approved,Okafor',
  'A-102,2023-01-11,2023-01-30,1,"$18,200",denied,Kim',
  'A-113,2023-04-01,2023-05-02,3,"$1,950,000",Approved,Lopez',
  'A-114,2023-04-12,2023-05-10,2,"$24,100",Denied,Kim',
  'A-115,2023-04-20,,3,"$30,500",Pending,Okafor',
  'A-116,2023-05-05,2023-06-01,1,"$16,800",Approved,lopez',
  'A-103,2023-01-15,2023-03-10,4,"$41,000",Approved,Lopez'
), here("data", "raw", "housing_applications.csv"))
