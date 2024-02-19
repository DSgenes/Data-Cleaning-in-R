
###Outliers Detection using IQR(Interquartile Range Method)###
#   An outlier is a data point that differs significantly from other observations.

#Creating sample dataset
data <- data.frame(Age = c(12,14,16,54,34,44,30,29,90,150,250))

#Check data dimensions
#we've 11 observations and one variable
dim(data)

#Removing outliers using the IQR
#Calculate Q1
Q1 <- quantile(data$Age, 0.25)
Q1

#Calculate Q3
Q3 <- quantile(data$Age, 0.75)
Q3

#Calculate IQR
IQR <- IQR(data$Age)
IQR

#Subset data
cleaned_data <- subset(data,data$Age > (Q1-1.5*IQR) & data$Age < (Q3+1.5*IQR))
cleaned_data

#Check whether the outliers are removed
#we can see that in original data we had 150 and 250 as outliers.In cleaned data we've no
#outliers.
dim(cleaned_data)
--------------------------------------------------------------------------------------------

