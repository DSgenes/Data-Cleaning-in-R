###Data Cleaning in R###
#    Data Cleaning in R is the process to transform raw data into consistent data 
#    that can be easily analyzed. It is aimed at filtering the content of statistical
#  statements based on the data as well as their reliability. Moreover, it influences
#    the statistical statements based on the data and improves your data quality and 
#    overall productivity.

library(tidyverse)
data()
View(starwars)

#To start off with variable types
glimpse(starwars)

#to check what class of variable it is
class(starwars$gender)

#what kind of observations in a variable
unique(starwars$gender)

#changing a variable class from character to factor
starwars$gender <- as.factor(starwars$gender)
class(starwars$gender)

#it's important sometimes to have a variable be a factor and not a character variable
#because we're interested in levels so let's just quickly have a look at that we've got
#levels we can say levels starwars gender
levels(starwars$gender)

#in this case feminine is level one and masculine is level 2 now in the case of gender
#we don't really mind this but let's say for whatever reason we might want this to be
#the other way around so we've changed the levels simply by using this factor function
starwars$gender <- factor((starwars$gender),
                          levels = c("masculine",
                                     "feminine"))
levels(starwars$gender)

#to check names of the variables
names(starwars)

#Select variables and those variables that ends with the word color
starwars %>%
  select(name, height, ends_with("color")) %>%
  names()
 
#if we remove names() then the result would be this way
starwars %>%
  select(name, height, ends_with("color"))

#filter observations
#it's going to tell you these are all of the possible observations that you could
#have in that variable
unique(starwars$hair_color)
starwars %>%
  select(name, height, ends_with("color")) %>%
  filter(hair_color %in% c("blond", "brown") &
           height < 180)

#Missing Data 

#the mean function doesn't work if the variable contains NA's
mean(starwars$height)

mean(starwars$height, na.rm = TRUE)

starwars %>%
  select(name, gender, hair_color, height)

#It'll remove all of the missing values from the entire dataset
starwars %>%
  select(name, gender, hair_color, height) %>%
  na.omit()

#it gives the same results as na.omit() function doesit's emitted any observation that
#has a missing value in any of its variable
starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(complete.cases(.))

#It's going to do the exact opposite of that so that's what the exclamation mark does
#it says look do the opposite of this next function now it's only given us observations
#where somewhere in that observation there's a variable that has a missing value somewhere
#in one of the variables 
starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.))

#now when it's looking for all the cases where there's missing data the ones with the
#height was missing are gone now if we were to remove this filter
starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) %>%
  drop_na(height) %>%
  View()

#replace NA with the word "none" in the hair_color variable
starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) %>%
  mutate(hair_color = replace_na(hair_color, "none"))

#cretaed a new variable with none where there's NA 
starwars %>%
  select(name, gender, hair_color, height) %>%
  filter(!complete.cases(.)) %>%
  mutate(hair_color2 = replace_na(hair_color, "none"))

#Duplicates
Name <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)
friends <- data.frame(Name, Age)

#This is basically a logical vector .In other words the fourth observation is a 
#duplicate.TRUE means there's a duplicate value
duplicated(friends)

#you put  square brackets with a comma will tell R what columns you're interested in
#it's identified row 4 that's the duplicate variable
friends[duplicated(friends),]

#if we put an exclamation mark in front of duplicated again we're telling it what rows
#we want it's going to provide us a little data frame here we've got names and ages of
#the observations where which are not duplicates 
friends[!duplicated(friends),]

#another way of doing this we get the same output
friends %>%
  distinct()

#Recoding Variables
#We want masculine and feminine to be coded as 1and 2
starwars %>%
  select(name, gender) %>%
  mutate(gender = recode(gender,
                         "masculine" = 1,
                         "feminine" = 2))
#Create a new variable called gender coded and added masculine and feminine as 1 and 2
starwars %>%
  select(name, gender) %>%
  mutate(gender_coded = recode(gender,
                               "masculine" = 1,
                               "feminine" = 2))
--------------------------------------------------------------------------------------