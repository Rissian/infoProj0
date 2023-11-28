library(dplyr)
library(stringr)
library(ggplot2)
library(testthat)
library(tidyverse)


income_df <- read.csv("ACSST1Y2022.S1901-2023-11-28T011511.csv") 
pollution_df <- read.csv("pollution_2000_2022.csv") 


income_df <- subset(income_df, select = -c(X, Household.income.in.the.past.12.months, Family.income.in.the.past.12.months, Nonfamily.income.in.the.past.12.months))
income_df <- income_df[!grepl('Margin', income_df$Family),]


pollution_df <- pollution_df[grepl('2022', pollution_df$Date),]
pollution_df <- subset(pollution_df, select = -c(X, Address, O3.1st.Max.Hour, CO.1st.Max.Hour, SO2.1st.Max.Hour, NO2.1st.Max.Hour))



income_df$State <- str_extract(income_df$Family, paste(state.name, collapse = '|'))
df <- left_join( pollution_df,income_df, by=("State"="State"))
