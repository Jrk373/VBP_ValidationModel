library(tidyverse)
library(readxl)
library(scales)


# Import the unaltered VBP report, "Detail" sheet, as received from HCA
vbp_cbi   <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_94-2880847_Community_Bridges_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_cpih  <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_86-0215065_Change_Point_Integrated_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_lcbhc <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_86-0250938_Little_Colorado_Behavioral_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_mmhc  <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_86-0214457_Mohave_Mental_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_ph    <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_86-0206928_Polara_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_sbhs  <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_86-0290033_Southwest_Behavioral_Health_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_shg   <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_86-0207499_Spectrum_Health_Group_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")
vbp_tgc   <-  read_xlsx("./data/VBPReports/Quality/vbpbhh_report_2023-01-30_86-0223720_The_Guidance_Center_HCA_BHH_VBP_Quality.xlsx", sheet = "Detail")

# Bind the Details sheet from all providers into one table
Master_VBP_Rep_Comb <- rbind(
  vbp_cbi,
  vbp_cpih,
  vbp_lcbhc,
  vbp_mmhc,
  vbp_ph,
  vbp_sbhs,
  vbp_shg,
  vbp_tgc
)

# write.csv(Master_VBP_Rep_Comb, "./data/output/VBPMeasurementValidation/2023-03-01_Master_VBP_Rep_Comb.csv")


# The Table, ***Master_VBP_Rep_Comb,*** is then transformed in order to remove superfluous white space and other text and table titles that were imported by default. The key transformations are:
#   
# -   Remove superfluous rows that contain tables names and descriptions.
# 
# -   Promote data from the row with the column names [Row 6] into the column headers.
# 
# -   Complete the removal of superfluous rows by filtering the *LOB* variable to include only the value *HCA*.
# 
# -   Change the data types of the variables *Data Period, Numerator, Denominator*
#   
# -   Change the variable name of *Denominator* to *TotalEligible*
#   
# -   Store the transformed data as ***VBP_Rep_Comb_validation***
#   
# The resulting table is a complete, cleaned list of all of the individual member events, for all of the VBP Measures, for all of the Alliance Providers.
# 
# ***This table is used to construct the VBP Quality Report Dashboard as well as the Alliance Progress Report***
  
  

# create a safe copy of the original data
VBP_Rep_Comb_validation <- Master_VBP_Rep_Comb
# Set column names to headers, which get imported on row 6
colnames(VBP_Rep_Comb_validation) <- VBP_Rep_Comb_validation [6,] 
# Filter out superfluous rows of nonsense data
VBP_Rep_Comb_validation <- VBP_Rep_Comb_validation %>%  
  filter(LOB == "HCA")
# set date format for report date
VBP_Rep_Comb_validation$`Data Period` <- as.numeric(VBP_Rep_Comb_validation$`Data Period`)
VBP_Rep_Comb_validation$`Data Period` <- as.Date(VBP_Rep_Comb_validation$`Data Period`, origin = "1899-12-30")
# update data types
VBP_Rep_Comb_validation$Numerator <- as.numeric(VBP_Rep_Comb_validation$Numerator)
VBP_Rep_Comb_validation$TotalEligible <- as.numeric(VBP_Rep_Comb_validation$Denominator)


# The data in the variable *Health Home Name* was used to create a new list of names called *Provider_Shortname*, and then filtered to only include Alliance Providers (CBI, CPIH, EHS, LCBHC, MMHC, Polara, SBHS, SHG, TGC).
# 
# Note: Encompass Health Services (EHS) is included in the data set for the time period that their results are reported separately from Community Bridges.
# 
# Finally, the *SubMeasureID* variable was filtered to only include the *FUH7* measure, and a list of the Member IDs was selected. A copy of the file ***VBP_Rep_Comb_validation,*** was stored as ***VBP_Rep_Comb_eval*** for use later.


# Create a Provider Shortname
VBP_Rep_Comb_validation <- VBP_Rep_Comb_validation %>% 
  mutate(Provider_Shortname = ifelse(`Health Home Name` == "COMMUNITY BRIDGES", "CBI",
                                     ifelse(`Health Home Name` == "CHANGE POINT INTEGRATED HEALTH", "CPIH", 
                                            ifelse(`Health Home Name` == "LITTLE COLORADO BEHAVIORAL HEALTH", "LCBHC", 
                                                   ifelse(`Health Home Name` == "MOHAVE MENTAL HEALTH", "MMHC", 
                                                          ifelse(`Health Home Name` == "POLARA HEALTH", "PH", 
                                                                 ifelse(`Health Home Name` == "SOUTHWEST BEHAVIORAL HEALTH", "SBHS", 
                                                                        ifelse(`Health Home Name` == "SPECTRUM HEALTH GROUP", "SHG",
                                                                               ifelse(`Health Home Name` == "THE GUIDANCE CENTER", "TGC", NA
                                                                               ))))))))) %>% 
  drop_na(Provider_Shortname)

## write.csv(VBP_Rep_Comb_validation, "./data/output/VBPMeasurementValidation/VBP_Rep_Comb_validation_complete.csv")

# create a duplicate at this phase to be used in later evaluation
VBP_Rep_Comb_eval <- VBP_Rep_Comb_validation %>% 
  filter(`SubMeasure ID` == "FUH7")

# write.csv(VBP_Rep_Comb_eval, "./data/output/VBPMeasurementValidation/VBP_Rep_Comb_Eval.csv")

# Isolate member ID for the validation
VBP_Rep_Comb_validation <- VBP_Rep_Comb_validation %>% 
  filter(`SubMeasure ID` == "FUH7") %>% 
  select(`Member ID`)

# write.csv(VBP_Rep_Comb_validation, "./data/output/VBPMeasurementValidation/VBP_Validation.csv")