#
# Copyright 2017 Dave Langer
#    
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 


#
# This R source code file corresponds to video 2 of the YouTube series
# "Introduction to Time Series Forecasting with R" located at the 
# following URL:
#     https://youtu.be/7aMJL6odSkQ     
#


#install.packages(c("xts", "lubridate", "ggplot2", "forecast"))
# Load packages
library(xts)
library(lubridate)
library(ggplot2)
library(forecast)


# Load in sea ice data.
seaice <- read.csv("data/seaice.csv", stringsAsFactors = FALSE)


# Visually inspect the data.
View(seaice)




# Filter data to only the northern hemisphere.
seaice <- seaice[seaice$hemisphere == "north",]




# Add an explicit date feature to the data frame.
seaice$Date <- as.Date(paste(seaice$Year, seaice$Month, 
                             seaice$Day, sep = "-"))




# Leverage the xts package to create the initial time series object
# as the observations in the original dataset are measured every 
# two days.
help(package = "xts")

seaice.xts <- xts(x = seaice$Extent, order.by = seaice$Date)
str(seaice.xts)




# Use the xts package and aggreage the data to the month level,
# averaging the Extent values for each month.
seaice.monthly <- apply.monthly(seaice.xts, mean)
str(seaice.monthly)




# In time series analysis it is a common practice to split data 
# using 80/20 for train/test.
seaice.end <- floor(0.8 * length(seaice.monthly))
seaice.train <- seaice.monthly[1:seaice.end]
seaice.test <- seaice.monthly[(seaice.end + 1):length(seaice.monthly)]




# Many of the visualizations/functions work best/only with R 
# ts objects, convert xts train/test data to ts objects.
seaice.start <- c(year(start(seaice.train)), month(start(seaice.train)))
seaice.end <- c(year(end(seaice.train)), month(end(seaice.train)))
seaice.train <- ts(as.numeric(seaice.train), start = seaice.start,
                   end = seaice.end, frequency = 12)
seaice.train

seaice.start <- c(year(start(seaice.test)), month(start(seaice.test)))
seaice.end <- c(year(end(seaice.test)), month(end(seaice.test)))
seaice.test <- ts(as.numeric(seaice.test), start = seaice.start,
                   end = seaice.end, frequency = 12)
seaice.test

# Use variable to track forecast horizon
forecast.horizon <- length(seaice.test)
