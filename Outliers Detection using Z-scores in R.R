###Cleaning Outliers with Z-scores###

###Outliers###
#    An outlier is an observation within a variable or a dataset that you think this shouldn't
#   belong its too dissimilar to the rest of the data

###Z-scores### 
#   Formula : z = (x-μ)/σ

install.packages("palmerpenguins")
install.packages("cowplot")
library(palmerpenguins)
library(tidyverse)
library(cowplot)
View(penguins)

#the first step we do is to drop all the missing values because apply these kind of 
#transformations they don't handle missing values 

penguins <- drop_na(penguins)

#we're going to create a value called Z-score and we're taking body mass variable and we'll
#subtract the mean from this and this will give us an absolute measure of how far away it is 
#from the mean and then we'll standardize it by dividing it by standard deviation and all the
#sd is basically a way to tell us the average distance between each datapoint effectively

Z_scores <- (penguins$body_mass_g - mean(penguins$body_mass_g))/sd(penguins$body_mass_g)
Z_scores

#we'll get all of these Z-scores with 333 observations some of which will be negative and
#some of which will be positive obviously because we haven't got the absolute measures for
#these yet.Now we're going to create another value called outliers where we'll take the
#absolute value of all the Z-scores and then we'll set we'll say that anything that is above
#one and a half Z-scores so one and a half sd in this case because Z-scores and sd are analogous
#will be considered an outlier usually two or three standrad deviations away from your mean
#is considered to be an outlier however the Penguins dataset dosen't really have outliers
#so just for the sake of an example i'll use 1.5 so that i can illustrate my point and i can
#show you or we can visualize a dataframe that has been cleaned up outliers and a normal
#dataset
?abs
outliers <- abs(Z_scores) > 1.5
outliers

#now i create a new dataset Penguins clean i'll just take the penguins dataset and then i'll
#remove the outliers values from it.It's a very simple transformation.
penguins_clean <- penguins[!outliers,]
penguins_clean

#we can visualize each of these datasets so that we can compare them side by side to see 
#what they look like cleaned and uncleaned 
hist_penguins <- ggplot(penguins, aes(x=body_mass_g))+
  geom_histogram(fill = "blue", alpha = 0.5)+
  ggtitle("Histogram of Body Mass(g) - Original Data")+
  xlab("Body Mass(g)")+
  ylab("Frequency")+
  xlim(2000,6500)+ylim(0,30)

hist_penguins_clean <- ggplot(penguins_clean,aes(x=body_mass_g))+
  geom_histogram(fill = "red", alpha = 0.5)+
  ggtitle("Histogram of Body Mass (g) - Cleaned Data")+
  xlab("Body Mass(g)")+
  ylab("Frequency")+
  xlim(2000,6500)+ylim(0,30)

plot_grid(hist_penguins,hist_penguins_clean, ncol = 2)
--------------------------------------------------------------------------------------------