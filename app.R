
tuition <- read.csv('nces330_20.csv')

# Load the required packages
library(ggplot2)
library(ggiraph)
library(dplyr)
library(maps)
library(leaflet)
library(shiny)

source("ui.R")
source("server.R")

shinyApp(ui, server)

