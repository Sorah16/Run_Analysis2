library(ggplot2)
library(dplyr)
library(reshape)

data <- read.csv(file.choose())




attach(data)
head(data)
summary(data)
colnames(data)
str(data)
data <- data[, -2]

reslt<- table(data$St_name)
View(reslt)


data2 <- read.csv(file.choose())

attach(data)
head(data2)
summary(data)
colnames(data2)
str(data)
data <- data[, -1]
data <- data[, -4] # repeat 5

names(data2) <- c("DateTime",   "St_ID",   "St_name","Usage","Distance","H_Code","Gender", "Age")

###  inner join
join<- merge(data, data2, by = "St_name")



## Creating Density Plot

ggplot(stn_TOD_editted, aes(Distance_km)) + geom_density(fill= "blue", alpha = .3) + 
  labs(x = "Total Rentals Per Day", y = "Density")

fill <- "#4271AE"
lines <- "#1F3552"

ggplot(No_TOD, aes(Distance_km)) + geom_density(colour = lines, fill = fill,size = 1) + 
  scale_x_continuous(name = "Total Distance Per Rental (km)", breaks = seq(0,20,2), limits = c(0,20)) +
  scale_y_continuous(name = "Density")+
  ggtitle("Density plot of Distance (Non_Tod_stn)") +
  theme_bw() +
  theme(axis.line = element_line(size=1, colour = "black"),
        panel.grid.major = element_line(colour = "#d3d3d3"),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(), panel.background = element_blank(),
        plot.title = element_text(size = 14, family = "Tahoma", face = "bold"),
        text=element_text(family="Tahoma"),
        axis.text.x=element_text(colour="black", size = 9),
        axis.text.y=element_text(colour="black", size = 9))

###ggplot2 density plotting different size of data in R

ggplot() + 
  geom_density(data = data, aes(x = Distance), 
               fill = "#E69F00", color = "black", alpha = 0.7) + 
  geom_density(data = data2, aes(x = Distance),
               fill = "#56B4E9", color = "black", alpha = 0.7)


### Example

## If you have two datasets with different amounts of data, you can plot them together like so:

df1 <- data.frame(x = rnorm(1000, 0, 2))
df2 <- data.frame(y = rnorm(500, 1, 1))

ggplot() + 
  geom_density(data = df1, aes(x = x), 
               fill = "#E69F00", color = "black", alpha = 0.7) + 
  geom_density(data = df2, aes(x = y),
               fill = "#56B4E9", color = "black", alpha = 0.7)

#### Areas under the density curves to be scaled relative to the amount of data in each group

df1 <- data.frame(x = rnorm(1000, 0, 2), label=rep('df1', 1000))
df2 <- data.frame(x = rnorm(500, 1, 1), label=rep('df2', 500))
df=rbind(df1, df2)

ggplot(df, aes(x, y=..count.., fill=label)) + 
  geom_density(color = "black", alpha = 0.7) + 
  scale_fill_manual(values = c("#E69F00", "#56B4E9"))
