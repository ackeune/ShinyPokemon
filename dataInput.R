lastRevisited <- "2019-09-21"
version <- "v0.1"

#### Load packages ####
library(shiny)
library(shinyjs)
library(shinydashboard)
library(jsonlite)
library(tidyverse)
library(plotly)
library(rstudioapi)
library(lubridate)
library(DT)


defaultData <- read.csv("history_20190918_091616.csv")

minCP <- min(defaultData$CP)
maxCP <- max(defaultData$CP)
maxDPS <- max(as.numeric(defaultData$DPS))
details <- data.frame("names" = c("Min CP",
                                  "Max CP",
                                  "Max DPS",
                                  "Scanned Pokemon",
                                  "Unique Pokemon",
                                  "Hatched Pokemon",
                                  "Lucky Pokemon",
                                  "Gen 1",
                                  "Gen 2",
                                  "Gen 3",
                                  "Gen 4",
                                  "Gen 5"
),
"values" = c(minCP,
             maxCP,
             maxDPS,
             length(defaultData$Nr),
             unique(length(defaultData$Nr)),
             unique(length(defaultData$Hatched)),
             0,
             0,
             0,
             0,
             0,
             0
             )
)