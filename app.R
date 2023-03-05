
setwd('/Users/annafang/desktop/info201/group-project')
tuition <- read.csv('nces330_20.csv')

# Load the required packages
library(ggplot2)
library(ggiraph)
library(dplyr)
library(maps)
library(leaflet)
library(shiny)


# Load ui and server functions
source("ui.R")
source("server.R")

shinyApp(ui, server)

