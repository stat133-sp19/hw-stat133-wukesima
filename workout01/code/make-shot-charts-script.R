########################################
## Title: make-shot-charts-script.R
## Description: Using the data to create scatterplots of player data.
## Inputs: data tables fro each player
## Outputs: Charts(scatterplots)
#######################################

library(ggplot2)
library(grid)
library(jpeg)

#court image
court_file <- "../images/nba-court.jpg"

#creat raste object
court_image <- rasterGrob(readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

 #iguodala pdf
iguodala <- players[players$name == "Andre Iguodala",]

pdf("../images/andre-iguodala-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = iguodala)+
  annotation_custom(court_image, -250, 250, -50, 420)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50,420)+
  ggtitle("Shot Chart: Andre Iguodala (2016 season)")+
  theme_minimal()
dev.off()

#green pdf
green <- players[players$name == "Draymond Green",]

pdf("../images/draymond-green-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = green)+
  annotation_custom(court_image, -250, 250, -50, 420)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50,420)+
  ggtitle("Shot Chart: Draymond Green (2016 season)")+
  theme_minimal()
dev.off() 

#durant pdf
durant <- players[players$name == "Kevin Durant",]

pdf("../images/kevin-durant-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = durant)+
  annotation_custom(court_image, -250, 250, -50, 420)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50,420)+
  ggtitle("Shot Chart: Kevin Durant (2016 season)")+
  theme_minimal()
dev.off()  

#thompson pdf
thompson <- players[players$name == "Klay Thompson",]

pdf("../images/klay-thompson-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = thompson)+
  annotation_custom(court_image, -250, 250, -50, 420)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50,420)+
  ggtitle("Shot Chart: Klay Thompson (2016 season)")+
  theme_minimal()
dev.off()

#curry pdf
curry <- players[players$name == "Stephen Curry",]

pdf("../images/stephen-curry-shot-chart.pdf", width = 6.5, height = 5)
ggplot(data = curry)+
  annotation_custom(court_image, -250, 250, -50, 420)+
  geom_point(aes(x = x, y = y, color = shot_made_flag))+
  ylim(-50,420)+
  ggtitle("Shot Chart: Stephen Curry (2016 season)")+
  theme_minimal()
dev.off()  

##Facetted Shot Chart
facetted_shot_chart <- ggplot(data = players) +
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Charts: GSW (2016 season)') +
  theme_minimal()+
  facet_grid(~ name)


pdf('../images/gsw-shot-charts.pdf', width=8,height=7)
facetted_shot_chart
dev.off()

png('../images/gsw-shot-charts.png', width=8,height=7)
facetted_shot_chart
dev.off()

