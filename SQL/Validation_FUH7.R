library(tidyverse)
library(stringr)

HCA_VBP_FUH7_Roster <- read.csv("./data/data_test_vbpbhh_2023-01-30_allProvidersCombined_validation.csv")
HCA_Claims_Roster_FUH7 <- read.csv("./data/data_test_cat_2022-11-30_IPClaims.csv")

VBP_Unduplicated <- HCA_VBP_FUH7_Roster %>% 
  group_by(Member.ID) %>% 
  rename("MemberID" = Member.ID) %>% 
  count()

Claims_Unduplicated <- HCA_Claims_Roster_FUH7 %>% 
  filter(MemberID != "NULL") %>% 
  group_by(MemberID) %>% 
  count()

Validation_Matrix <- 
  merge(x = VBP_Unduplicated,
        y = Claims_Unduplicated,
        by = "MemberID",
        all.x = TRUE) %>% 
  rename("VBP" = n.x,
         "claims" = n.y) %>% 
  mutate(Match = if_else((is.na(VBP) | is.na(claims)), "NoMatch", "Match"))

write.csv(Validation_Matrix, "./data/output/data_cat_2023-11-30_validationMatrix.csv")

Validation_Summary <- Validation_Matrix %>% 
  group_by(Match) %>% 
  count()

write.csv(Validation_Summary, "./data/output/data_cat_2023-11-30_validationSummary.csv")


Matched_Matrix <- Validation_Matrix %>% 
  filter(Match == "Match")

MatchedWithSvcCode <- 
  merge(x = Matched_Matrix,
        y = HCA_Claims_Roster_FUH7,
        by = "MemberID",
        all.x = TRUE) %>% 
  select(MemberID,
         Match,
         svccode) %>% 
  group_by(svccode) %>% 
  count()

write.csv(MatchedWithSvcCode, "./data/output/data_result_matchedSvcCode.csv")

MatchedWithSvcCode <- MatchedWithSvcCode %>% 
  mutate(svccode = as.character(svccode))

ggplot(MatchedWithSvcCode, aes(x = svccode, y = n)) +
  geom_col(fill = "#7ea5da") +
  geom_text(aes(label = n), hjust = -0.5) +
  coord_flip() +
  ggtitle("Claims Adjudicated for Matched Members") +
  xlab("Number of Claims") +
  theme_bw()


###

# Part 2
  
  




