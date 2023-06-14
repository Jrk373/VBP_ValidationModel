library(tidyverse)
library(readxl)

# This is the same as the code used in the VBPMeasurementValidation report

IPClaims <- read_xlsx("./data/data_original_cat_2022-11-30_IPClaims.xlsx", sheet = "IPClaims")
MHDxCodes <- read.csv("./data/data_reference_MHDxCodes.csv")

Provider_ShortName <- (c("CBI", "CPIH", "EHS", "LCBHC", "MMHC", "SHG", "SBH", "TGC", "Polara"))

MH_Dx <- MHDxCodes$Code

IPClaims_validation <- IPClaims %>% 
  filter(ra %in% Provider_ShortName) %>% 
  mutate(Elig_MHDx = if_else(PrimaryDiagnosis %in% MH_Dx, PrimaryDiagnosis,
                             if_else(Dx1 %in% MH_Dx, Dx1,
                                     if_else(Dx2 %in% MH_Dx, Dx2,
                                             if_else(Dx3 %in% MH_Dx, Dx3,
                                                     if_else(Dx4 %in% MH_Dx, Dx4,
                     if_else(Dx5 %in% MH_Dx, Dx5,
                             if_else(Dx6 %in% MH_Dx, Dx6,
                                     if_else(Dx7 %in% MH_Dx, Dx7,
                                             if_else(Dx8 %in% MH_Dx, Dx8,
                                                     if_else(Dx9 %in% MH_Dx, Dx9,
                     if_else(Dx10 %in% MH_Dx, Dx10,
                             if_else(Dx11 %in% MH_Dx, Dx11,
                                     if_else(Dx12 %in% MH_Dx, Dx12, "NotBH"
                                     )))))))))))))) %>% 
  filter(Elig_MHDx != "NotBH") %>% 
  select(MemberID,
         svccode)

write.csv(IPClaims_validation, "./data/data_test_cat_2022-11-30_IPClaims.csv")
