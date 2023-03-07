
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
  graph1, 
  graph2,
  conclusion
  
  )
)

intro_page<- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  mainPanel(
    h3(id="text", "The Average Cost of Undergrad College by State"),
    tags$style(HTML("#text{color: purple;}")),
    h3(id="text2", "Information on Dataset"),
    p("This dataset explores the average undergraduate tuition and fees and room and board rates charged for full-time students in degree-granting postsecondary institutions, by control and level of institution and state or jurisdiction."),
    p("This data was sourced from Kaggle, from a user called KENMORETOAST."),
    h3(id="text3", "Purpose & Importance"),
    p("This data is important because it gives an overview of the tution costs per state, which can be used to generalize the average cost by state, and we can see the trends of tuition cost throughout the United States."),
    p("Since this data focuses more on in-state tuition, our target audience is families or individuals who are in-state students."),
    p("This data also combines data from 2013 until now, so prices might be averaged to result in a lower price, compared to today's tuition."),
    p("With this data, our goal was to answer these questions:"),
      p("What is the average cost per state?"),
      p("What is the difference between in-state and out-of-state tuition?"),
      p("On average, how much are families are spending on fees/tuition and on room/board?"),
    tags$style(HTML("#text1{color: gray;}")),
    tags$style(HTML("#text2{color: blue;}")),
    imageOutput('tuition.png')
    )
  )


map <- tabPanel(
  "Map",
  titlePanel("Average College Tuition by State"),
  
  mainPanel(
    p("This is an interactive map that shows the average cost of college tuition per state."),
    p("If you hover over the state, the average in-state tuition cost will pop up."),
    ggiraphOutput("map_visual")
  )
)

graph1 <- tabPanel(
  "Graph 1",
  titlePanel("Tuition Difference between 2-year & 4-year Colleges in the US"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("States",
                         "Select State",
                         choices=unique(tuition$State),
                         selected=unique(tuition$State))
    ),
    mainPanel(
      p("This graph shows the average difference between 2-year and 4-year colleges in the United States."),
      p("The x-axis is labelled in alphabetical order of the 50 states"),
      p("We can see that consistent throughout 50 states, 4-year colleges on average cost around $10,000 more thatn 2-year colleges."),
      plotOutput("Plot1")
    )
    
       
   )
  )



graph2 <- tabPanel(
  "Graph 2",
  titlePanel("On average, how much do families spend on boarding and other fees per state? "),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("States",
                         "Select State",
                         choices=unique(tuition$State),
                         selected=unique(tuition$State))
    ),
      
  mainPanel(
    p("This graph shows the average cost of boarding fees and tuition fees."),
    plotOutput("Plot2")
  )
)
)

conclusion <- tabPanel(
    "Conclusion",
    mainPanel(
      h3(id="text", "Conclusion"),
      tags$style(HTML("#text{color: purple;}")),
      h3(id="text2", "Notable patterns"),
      p("One pattern we noticed was that East Coast has notably higher tuition costs compared to West coast. "),
      p("This may be due to more Ivy League Schools and private schools in East coast compared to Midwest and West coast."),
      h3(id="text3", "Data Quality"),
      p(id="text1", "Some critiques on the data:"),
      p("The data set was not detailed enough, especially because the only numeric values we could use were from the 'Value' column."),
      p("The 'value' column doesn't specificy whether the cost is in-state or out-of-state, but from the average tuition of each state, we would make an educated guess that the data focuses on in-state because out-of-state tuition is much higher than $18,000 per year."),
      p("If the data included numeric values on housing and other fees, then that would be helpful in making more insights on the differences between states."),
      p("It would also be helpful if the data frame gave numbers on in-state tuition vs out-of-state"),
      p("The data also didn't include a column for University/college names, so we don't know which school the tuition is in the state."),
      p("Overall, the data seemed to be unbias and reliable"),
      p("As for broader implications, this data can be used for families/individuals that want to know the costs "),
      p("In the future, we could advance the project by making the map more interactive and allowing users to choose which coast they want to focus on. We could also create a graph that shows the difference in tuition with housing and without housing fees."),
      tags$style(HTML("#text1{color: gray;}")),
      tags$style(HTML("#text2{color: blue;}")),
                 sidebarLayout(
                   sidebarPanel(
                     tags$p("This graph shows the average tution costs per State."),
                     tags$p("You can view costs by State by changing the input."),
                     checkboxGroupInput("States",
                                        "Select State",
                                        choices=unique(tuition$State),
                                        selected=unique(tuition$State))
                   ),
                   mainPanel(
                     plotOutput("Plot")
                   )
                 )
    )
)

   


