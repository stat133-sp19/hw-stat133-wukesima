#######################################
## Title: make-shots-data-script.R
## Description: Data preparation
## Inputs: Five shot data tables for each player
## Outputs: A new table and Summaries of modified table and combined table.
##########################################

# read in data sets and add column names

curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
curry$name <- c("Stephen Curry")
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)
iguodala$name <- c("Andre Iguodala")
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
green$name <- c("Draymond Green")
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
durant$name <- c("Kevin Durant")
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
thompson$name <- c("Klay Thompson")

# replace "n" with "shot_no", and "y" with "shot_yes"

curry$shot_made_flag[curry$shot_made_flag == 'y'] <- c("shot_yes")
curry$shot_made_flag[curry$shot_made_flag == 'n'] <- c("shot_no")
iguodala$shot_made_flag[iguodala$shot_made_flag == 'y'] <- c("shot_yes")
iguodala$shot_made_flag[iguodala$shot_made_flag == 'n'] <- c("shot_no")
green$shot_made_flag[green$shot_made_flag == 'y'] <- c("shot_yes")
green$shot_made_flag[green$shot_made_flag == 'n'] <- c("shot_no")
durant$shot_made_flag[durant$shot_made_flag == 'y'] <- c("shot_yes")
durant$shot_made_flag[durant$shot_made_flag == 'n'] <- c("shot_no")
thompson$shot_made_flag[thompson$shot_made_flag == 'y'] <- c("shot_yes")
thompson$shot_made_flag[thompson$shot_made_flag == 'n'] <- c("shot_no")

# minute = 12 * period - remaining

iguodala$minute = iguodala$period * 12 - iguodala$minutes_remaining
green$minute = green$period * 12 - green$minutes_remaining
durant$minute = durant$period * 12 - durant$minutes_remaining
thompson$minute = thompson$period * 12 - thompson$minutes_remaining
curry$minute = curry$period * 12 - curry$minutes_remaining

# sink() to send the summary() 

sink("../output/stephen-curry-summary.txt")
summary(curry)
sink()
sink("../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()
sink("../output/draymond-green-summary.txt")
summary(green)
sink()
sink("../output/kevin-durant-summary.txt")
summary(durant)
sink()
sink("../output/klay-thompson-summary.txt")
summary(thompson)
sink()

# stack the tables into one data frame

combined <- rbind(curry, iguodala, green, durant, thompson)

# export the assembled table

write.csv(combined, "../data/shots-data.csv")

# sink() to send the summary()

sink("../output/shots-data-summary.txt")
summary(combined)
sink()

