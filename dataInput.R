# lastRevisited <- "2019-09-24"
# versionApp <- "v0.3"
# 
# #### Load packages ####
# library(shiny)
# library(shinyjs)
# library(shinydashboard)
# library(jsonlite)
# library(tidyverse)
# library(plotly)
# library(rstudioapi)
# library(lubridate)
# library(DT)
# 
# 
# gen1 <- 1
# gen2 <- 2
# gen3 <- 3
# gen4 <- 4
# gen5 <- 5
# maxCP <- 3600
# minCP <- 10
# minDPS <- 0
# maxDPS <- 50
# 
# source("ui.R")
# source("server.R")


 
Gen1 <- function(x) {
  bool <- x >= 1 && x <= 151
  return(bool)
}

Gen2 <- function(x) {
  bool <- x >= 152 && x <= 251
  return(bool)
}

Gen3 <- function(x) {
  bool <- x >= 252 && x <= 386
  return(bool)
}

Gen4 <- function(x) {
  bool <- x >= 387 && x <= 493
  return(bool)
}

Gen5 <- function(x) {
  bool <- x >= 494 && x <= 649
  return(bool)
}

Gen6 <- function(x) {
  bool <- x >= 650 && x <= 721
  return(bool)
}

Gen7 <- function(x) {
  bool <- x >= 722 && x <= 809
  return(bool)
}

Generation <- function(x) {
  if (Gen1(x)) {
    return(1)
  } else if (Gen2(x)) {
    return(2)
  } else if (Gen3(x)) {
    return(3)
  } else if (Gen4(x)) {
    return(4)
  } else if (Gen5(x)) {
    return(5)
  } else if (Gen6(x)) {
    return(6)
  } else if (Gen7(x)) {
    return(7)
  } else {
    stop("unknown generation pokemon")
  }
}

AddGeneration <- function(data) {
  withGeneration <- data %>% rowwise() %>% mutate(Generation = Generation(Nr))
  return(withGeneration)
}

CountGeneration <- function(data) {
  gen1 <- sum(data$Generation == 1)
  gen2 <- sum(data$Generation == 2)
  gen3 <- sum(data$Generation == 3)
  gen4 <- sum(data$Generation == 4)
  gen5 <- sum(data$Generation == 5)
  gen6 <- sum(data$Generation == 6)
  gen7 <- sum(data$Generation == 7)
  output = list("gen1" = gen1,
                "gen2" = gen2,
                "gen3" = gen3,
                "gen4" = gen4,
                "gen5" = gen5,
                "gen6" = gen6,
                "gen7" = gen7)
  return(output)
}