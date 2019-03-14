---
title: "Wokrout1-max-sima""
author: "Max Sima"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(knitr)
```

```{r}
shabidata <- read.csv(file = "../data/shots-data.csv", header = TRUE,sep = ",")

##Two Point Effectiveness
two_points <- filter(name_shottype, shot_type == "2PT Field Goal")
arrange(
summarise(group_by(two_points, name),
          total = length(shot_type),
          made = sum(shot_made_flag == "shot_yes"), 
          perc_made = made/total 
), desc(perc_made))
```
```{r}
#Three Points Effectiveness 
three_points <- filter(name_shottype, shot_type == "3PT Field Goal")
arrange(
summarise(group_by(three_points, name),
          total = length(shot_type),
          made = sum(shot_made_flag == "shot_yes"), 
          perc_made = made/total 
), desc(perc_made))
```

```{r}
##Point Effectiveness
arrange(
summarise(group_by(name_shottype, name),
          total = length(shot_type),
          made = sum(shot_made_flag == "shot_yes"), 
          perc_made = made/total 
), desc(perc_made))
```
#Report
##Introduction
After the Golden State Warriors signed Steve Kerr to a reported five-year to become the team's new head coach on May 14, 2014, The Warriors completed the 2014-2015 regular season with a league-best record of 67-15, setting a new record for most wins in franchise history. The Warriors also finished with a home record of 39–2, second-best in NBA history.The Warriors has won 3 championships since 2014, which is a huge success. This workout is tend to analyze five important players in the Warriors and their point effectiveness, which could weight their contribution to the success in points aspect.

##Motivation
Curious about each players' contribution and effectiveness to scores on the court.

##Background
The Warriors' fortunes changed in the 2010s, ushering in a new era of success led by Stephen Curry. After drafting perennial All-Stars Klay Thompson and Draymond Green, the team returned to championship glory in 2015, before winning another two in 2017 and 2018 with the help of former league MVP Kevin Durant.

##Analysis
As we can see from the 2 Point Effectiveness that Andre Iguodala and Kevin Durant have an higher perc_made than Stephan curry and Klay Thompson since that Iguodala and Durant are much taller and stronger, which helps them easier to make Jump shots and layups under defense. Draymond Green is indeed strong, But he has much more talence in Defense instead of Offense. Durant, Curry ,and Thompson have similiar 2 points shot attempts since these three guys are the best 3 offense players in GSW.

As we all know that Curry and Thompson are the 2 greatest shooting players in the NBA History. In 3 point Effectiveness, Curry and Thompson make most 2 three points in GSW at the meantime having the most 2  perc_made in GSW.

By comparing the table of 2 point shot and the table of 3 point shot, one should observe that for each player, the perc_made is higher in 2 point shot than in 3 point shot. This observation is not surprising that it is more difficult to make a successful shot from a longer distance. 

When considering the total poings effectiveness, Iguodala and Green make less contributions to scores than the other 3 players since that these two guys devote most of their time to defense, which is also an important factor leading GSW to success. Durant, Curry, and Thompson are all All-Star players, and they are all good at scoring. These three guys share most shooting attempts, having relatively high perc_made, which contributes a lot in offense in GSW. I thought these five guys are perfect fits, since if you have five guys good at scoring on the cort, defense might be a really good problem.

