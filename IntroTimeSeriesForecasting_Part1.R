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
# This R source code file corresponds to video 1 of the YouTube series
# "Introduction to Time Series Forecasting with R" located at the 
# following URL:
#     https://youtu.be/X0W2_RAm7C8     
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