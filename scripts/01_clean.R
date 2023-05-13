############
### Info ###
############
#
# Project: University Lecture Listening Task - Speech Synthesis
#
# Conference: 12th ISCA Speech Synthesis Workshop (SSW '23)
#
# Contributors: Mikey Elmers
#
# Part 01: Load and clean data
#
# Date: April 14, 2023
#
#-------------------------------------------------------
# load packages
library(dplyr)
library(stringr)
library(tidyr)
################################################################################
# Load German speaker data
# Remove extraneous rows and columns
df_listen <- read.csv(file = "data/raw/nns/trials.csv")
df_listen <- df_listen %>% 
  filter(!Task_Name %in% c("congratulations", "instructions", 
                           "instructions_computergen", "questionnaire"))
df_listen <- df_listen %>% 
  select(starts_with(c("Rec_Session_Id", "Block_Name", "audiofile", "q1", "q2")))
################################################################################
# Add score column
df_listen <- df_listen %>% 
  mutate(score = 0)
################################################################################
# Loop through to check score : engl310_01
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_01_")){
    if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] == 1){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] != 1){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 1 & df_listen$q2[[i]] == 1){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_07
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_07_")){
    if (df_listen$q1[[i]] == 4 & df_listen$q2[[i]] == 2){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 4 & df_listen$q2[[i]] != 2){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 4 & df_listen$q2[[i]] == 2){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_13
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_13_")){
    if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] != 4){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 1 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_24
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_24_")){
    if (df_listen$q1[[i]] == 3 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 3 & df_listen$q2[[i]] != 4){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 3 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# total score for each participant
df_listen <- df_listen %>% 
  group_by(Rec_Session_Id) %>% 
  mutate(total_score = sum(score))
################################################################################
# Questionnaire Only
df_questionnaire <- read.csv(file = "data/raw/nns/trials.csv")
df_questionnaire <- df_questionnaire %>% filter(Task_Name == "questionnaire")
df_questionnaire <- df_questionnaire %>% 
  select(starts_with(c("Rec_Session_Id", "Task_Name", "age", "ease", "edu", 
                       "imphear", "interest", "L1", "notes", "prep", "self", 
                       "test")))
# one participant accidentally selected "eng" as L1, therefore corrected
df_questionnaire <- df_questionnaire %>% 
  mutate(L1 = ifelse(L1 == "eng", "ger", L1))
################################################################################
# Rename columns
df_listen <- df_listen %>% 
  rename(id = Rec_Session_Id, condition = Block_Name)
df_questionnaire <- df_questionnaire %>% 
  rename(id = Rec_Session_Id, task = Task_Name)
################################################################################
# Join Questionnaire and Listening Task
df_nns <- left_join(df_listen, df_questionnaire, by = "id")

# write binomial data to working before collapsing to single rows per id
write.csv(df_nns, "data/working/data_nns_binom.csv", row.names = FALSE)

df_nns <- df_nns %>% 
  select(starts_with(c("id", "condition", "total_score", "age", "ease",
                       "edu", "imphear", "interest", "L1", "notes", "prep",
                       "self", "test"))) %>% 
  unique()
################################################################################
# write to working directory
write.csv(df_nns, "data/working/data_nns.csv", row.names = FALSE)
################################################################################
################################################################################
################################################################################
# Load English speaker data 
df_listen <- read.csv(file = "data/raw/ns/trials.csv")
df_listen <- df_listen %>% 
  filter(!Task_Name %in% c("congratulations", "instructions", 
                           "instructions_computergen", "questionnaire"))
df_listen <- df_listen %>% 
  select(starts_with(c("Rec_Session_Id", "Block_Name", "audiofile", "q1", "q2")))
################################################################################
# Add score column
df_listen <- df_listen %>% 
  mutate(score = 0)
################################################################################
# Loop through to check score : engl310_01
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_01_")){
    if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] == 1){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] != 1){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 1 & df_listen$q2[[i]] == 1){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_07
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_07_")){
    if (df_listen$q1[[i]] == 4 & df_listen$q2[[i]] == 2){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 4 & df_listen$q2[[i]] != 2){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 4 & df_listen$q2[[i]] == 2){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_13
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_13_")){
    if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 1 & df_listen$q2[[i]] != 4){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 1 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_24
for (i in 1:nrow(df_listen)){
  if (startsWith(df_listen$audiofile[[i]], "engl310_24_")){
    if (df_listen$q1[[i]] == 3 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 2
    } else if (df_listen$q1[[i]] == 3 & df_listen$q2[[i]] != 4){
      df_listen$score[[i]] <- 1
    } else if (df_listen$q1[[i]] != 3 & df_listen$q2[[i]] == 4){
      df_listen$score[[i]] <- 1
    }
  } 
}
################################################################################
# total score for each participant
df_listen <- df_listen %>% 
  group_by(Rec_Session_Id) %>% 
  mutate(total_score = sum(score))
################################################################################
# Questionnaire Only
df_questionnaire <- read.csv(file = "data/raw/ns/trials.csv")
df_questionnaire <- df_questionnaire %>% filter(Task_Name == "questionnaire")
df_questionnaire <- df_questionnaire %>% 
  select(starts_with(c("Rec_Session_Id", "Task_Name", "age", "ease", "edu", 
                       "imphear", "interest", "L1", "notes", "prep", "self", 
                       "test")))
################################################################################
# Rename columns
df_listen <- df_listen %>% 
  rename(id = Rec_Session_Id, condition = Block_Name)
df_questionnaire <- df_questionnaire %>% 
  rename(id = Rec_Session_Id, task = Task_Name)
################################################################################
# Join Questionnaire and Listening Task
df_ns <- left_join(df_listen, df_questionnaire, by = "id")

# write binomial data to working before collapsing to single rows per id
write.csv(df_ns, "data/working/data_ns_binom.csv", row.names = FALSE)

df_ns <- df_ns %>% 
  select(starts_with(c("id", "condition", "total_score", "age", "ease",
                       "edu", "imphear", "interest", "L1", "notes", "prep",
                       "self", "test"))) %>% 
  unique()
################################################################################
# write to working directory
write.csv(df_ns, "data/working/data_ns.csv", row.names = FALSE)
################################################################################
################################################################################
################################################################################
# vertically join both the English and German dataframes
df_en <- read.csv(file = "data/working/data_ns.csv")
df_de <- read.csv(file = "data/working/data_nns.csv")
df_full <- rbind(df_de, df_en)
################################################################################
# write dataframe to "final" subdirectory within the "data" directory
write.csv(df_full, "data/final/data_full.csv", row.names = FALSE)
write.csv(df_de, "data/final/data_de.csv", row.names = FALSE)
write.csv(df_en, "data/final/data_en.csv", row.names = FALSE)
################################################################################
################################################################################
################################################################################
# Binomial data
df_en_binom <- read.csv("data/working/data_ns_binom.csv")
df_de_binom <- read.csv("data/working/data_nns_binom.csv")
df_full_binom <- rbind(df_en_binom, df_de_binom)
df_full_binom <- df_full_binom %>% 
  select(-score, -total_score, -task)

df_full_binom <- df_full_binom %>% 
  gather(key = "question",
         value = "answer",
         c(q1, q2))
################################################################################
# write and read dataframe for binomial
write.csv(df_full_binom, "data/working/data_full_binomial.csv", row.names = FALSE)
df_binomial<- read.csv(file = "data/working/data_full_binomial.csv")
################################################################################
# Add score column
df_binomial <- df_binomial %>% 
  mutate(score = 0)
################################################################################
# Loop through to check score : engl310_01
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_01_") & df_binomial$question[[i]] == "q1"){
    if (df_binomial$answer[[i]] == 1){
      df_binomial$score[[i]] <- 1
    }
  } 
}

for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_01_") & df_binomial$question[[i]] == "q2"){
    if (df_binomial$answer[[i]] == 1){
      df_binomial$score[[i]] <- 1
    }
  } 
}

################################################################################
# Loop through to check score : engl310_07
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_07_") & df_binomial$question[[i]] == "q1"){
    if (df_binomial$answer[[i]] == 4){
      df_binomial$score[[i]] <- 1
    }
  } 
}

for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_07_") & df_binomial$question[[i]] == "q2"){
    if (df_binomial$answer[[i]] == 2){
      df_binomial$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_13
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_13_") & df_binomial$question[[i]] == "q1"){
    if (df_binomial$answer[[i]] == 1){
      df_binomial$score[[i]] <- 1
    }
  } 
}

for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_13_") & df_binomial$question[[i]] == "q2"){
    if (df_binomial$answer[[i]] == 4){
      df_binomial$score[[i]] <- 1
    }
  } 
}
################################################################################
# Loop through to check score : engl310_24
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_24_") & df_binomial$question[[i]] == "q1"){
    if (df_binomial$answer[[i]] == 3){
      df_binomial$score[[i]] <- 1
    }
  } 
}

for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_24_") & df_binomial$question[[i]] == "q2"){
    if (df_binomial$answer[[i]] == 4){
      df_binomial$score[[i]] <- 1
    }
  } 
}
################################################################################
# add column for whether the question is preceded by PINTs
df_binomial <- df_binomial %>% 
  mutate(precede = "no")

# excluding rows from noPINTs condition
df_binomial <- df_binomial %>% 
  filter(!(condition %in% c("nopints", "nopints_cg")))
################################################################################ 
# Loop through to check preceding
# Loop through to check score : engl310_01
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_01_") & df_binomial$question[[i]] == "q2"){
    df_binomial$precede[[i]] <- "yes"
  } 
}
################################################################################
# Loop through to check score : engl310_07
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_07_") & df_binomial$question[[i]] == "q2"){
    df_binomial$precede[[i]] <- "yes"
  } 
}
################################################################################
# Loop through to check score : engl310_13
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_13_") & df_binomial$question[[i]] == "q1"){
    df_binomial$precede[[i]] <- "yes"
  } 
}
################################################################################
# Loop through to check score : engl310_24
for (i in 1:nrow(df_binomial)){
  if (startsWith(df_binomial$audiofile[[i]], "engl310_24_") & df_binomial$question[[i]] == "q1"){
    df_binomial$precede[[i]] <- "yes"
  } 
}
################################################################################
# Write to final directory
write.csv(df_binomial, "data/final/data_binomial_all.csv", row.names = FALSE)
################################################################################
# Clean data for comparing count/duration for the original and synthetic versions
df_comp <- read.csv(file = "data/raw/synth_original_comparison.csv", row.names = NULL)

# remove row.names column and blank column
colnames(df_comp) <- colnames(df_comp)[2:ncol(df_comp)]
df_comp <- df_comp[1:(ncol(df_comp)-1)]

# check for na or empty string ""
any(is.na(df_comp) | df_comp == "")

# modify segment column to be more uniform
df_comp$segment <- str_replace(df_comp$segment, "^other$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: clear throat$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: cough$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: creaky$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: gl$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: glottal activity$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: glottal pulse$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: laugh$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: lip smack$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: sniffle$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: swallow$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: thorat clear$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^other: throat clear$", "o")
df_comp$segment <- str_replace(df_comp$segment, "^pau\\s*$", "sil")
df_comp$segment <- str_replace(df_comp$segment, "^pauin$", "sil")
df_comp$segment <- str_replace(df_comp$segment, "^pauuh$", "sil")
df_comp$segment <- str_replace(df_comp$segment, "^tk$", "cl")
df_comp$segment <- str_replace(df_comp$segment, "^uhm$", "um")

# add column for condition
df_comp <- df_comp %>% 
  mutate(condition = case_when(
    str_ends(file, "_original") ~ "orig",
    str_ends(file, "_synth_base") ~ "synth"
  ))

# remove all rows where segment == "np" (rows without PINTs)
df_comp <- df_comp %>% 
  filter(segment != "np")

# write to final directory
write.csv(df_comp, "data/final/data_synth_orig_comp.csv", row.names = FALSE)
################################################################################