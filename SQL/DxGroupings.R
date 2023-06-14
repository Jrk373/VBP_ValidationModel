# Group by Diagnostic Grouping
# Load ICD10 groupings to the model
ICD10Groupings <- read.csv("./data/dataModel/ICD10andBHGroupingsCombined.csv")

ICD10Groupings <- ICD10Groupings %>% 
  rename("matchDx" = primaryDiagnosis)

# Create column with first found BHDx
VMMwithDxGroupings <- ValMat_Match %>% 
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
  rename("matchDx" = Elig_MHDx) %>% 
  
  test <- VMMwithDxGroupings %>% 
  mutate(matchDx = sub(.x, ".", matchDx))

# Merge with ICD10 Groupings
test <-
  merge(x = VMMwithDxGroupings,
        y = ICD10Groupings,
        by = "matchDx",
        all.x = TRUE)
