
setwd('/Users/annafang/desktop/info201/group-project')
tuition <- read.csv('nces330_20.csv')

# Load the required packages
library(ggplot2)
library(ggiraph)
library(dplyr)
library(maps)
library(leaflet)
library(shiny)

ui <- shinyUI(
  navbarPage("Average Cost of Undergrade College by State",
  intro_page,
  map,
  conclusion
  
  )
)

intro_page<- tabPanel(
  "HOME",
  titlePanel("Introduction"),

  mainPanel(
    h3(id="text", "The Average Cost of Undergrad College by State"),
    tags$style(HTML("#text{color: purple;}")),
    h3(id="text2", "Information on Dataset"),
    p(id="text1", "This dataset explores the average undergraduate tuition and fees and room and board rates charged for full-time students in degree-granting postsecondary institutions, by control and level of institution and state or jurisdiction."),
    p(id="text1", "This data was sourced from Kaggle, from a user called KENMORETOAST."),
    h3(id="text3", "Purpose & Importance"),
    p(id="text1", "This data is important because it gives an overview of the tution costs per state, which can be used to generalize the average cost by state, and we can see the trends of tuition cost throughout the United States."),
    p(id="text1", "With this data, our goal was to answer these questions:"),
      p("What is the average cost per state?"),
      p("What is the difference between in-state and out-of-state tuition?"),
      p("On average, how much are families are spending on fees/tuition and on room/board?"),
    tags$style(HTML("#text1{color: gray;}")),
    tags$style(HTML("#text2{color: blue;}")),
  )
)

map <- tabPanel(
  "Map",
  titlePanel("Average College Cost by State"),
  mainPanel(
    leafletOutput(outputId = "map_visual"),
    ggiraphOutput("map_visual"),
    p(id="text1", "This is an interactive map that shows the average cost of college tuition per state."),
    p("If you hover over the state, the average tuition cost will pop up.")
  )
)

conclusion <- tabPanel(
    "Conclusion",
    mainPanel(
      h3(id="text", "Conclusion"),
      tags$style(HTML("#text{color: purple;}")),
      h3(id="text2", "Notable patterns"),
      p(id="text1", "..."),
      p(id="text1", "..."),      
      p(id="text1", "[insert data/table/chart that demonstrates pattern"),
      h3(id="text3", "Data Quality"),
      p(id="text1", "Some critiques on the data:"),
      p("The data set was not detailed enough, especially because the only numeric values we could use were from the 'Value' column."),
      p("If it included numeric values on housing and other fees, then that would be helpful in making more insights on the differences between states."),
      p("The data also didn't include a column for University/college names, so we don't know which school the tuition is in the state."),
      p("Overall, the data seemed to be unbias and reliable"),
      p("As for broader implications, this data can be used for families/individuals that want to know the costs "),
      p("In the future, we could advance the project by making the map more interactive and allowing users to choose which coast they want to focus on. We could also create a graph that shows the difference in tuition with housing and without housing fees."),
      tags$style(HTML("#text1{color: gray;}")),
      tags$style(HTML("#text2{color: blue;}")),
    )
)

   


