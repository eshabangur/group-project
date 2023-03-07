library(ggplot2)
library(ggiraph)
library(dplyr)
library(maps)
library(leaflet)
library(shiny)
library(ggiraph)
library(rsconnect)

tuition <- read.csv('nces330_20.csv')

server <- function(input, output) {

#intro
  output$tuition.png <- renderImage({
    list(src ='tuition.png', deletefile = FALSE)
  }, deleteFile = FALSE)
  
  
#map
  colnames(tuition) <- c("Year", "State", "Type", "Length", "Expense", "Value")
  tuition <- na.omit(tuition)
  
  states <- map_data("state")
  states <- states %>% rename(State = region)
  
  state_summary <- tuition %>% 
    group_by(State) %>% 
    summarise(avg_value = mean(Value)) %>% 
    arrange(desc(avg_value))
  
  state_polygons <- fortify(states, region = "State")
  state_summary$State <- tolower(state_summary$State)
  state_summary_polygons <- merge(state_polygons, state_summary, by = "State")
  
  map_visual <- ggplot(state_summary_polygons, aes(x = long, y = lat, group = group, fill = avg_value, tooltip = paste0(State, ": $", round(avg_value, 2)))) +
    geom_polygon_interactive() +
    scale_fill_gradient(low = "white", high = "red", na.value = "grey50") +
    coord_map() +
    labs(title = "Average College Tuition by State",
         fill = "Average Tuition")
  
  ggiraph(code = print(map_visual), hover_css = "fill-opacity: 0.8; cursor: pointer;")
  
  output$map_visual <- renderggiraph({
    ggiraph(code = print(map_visual), hover_css = "fill-opacity: 0.8; cursor: pointer;")
  })


#graph1
  output$Plot1 <- renderPlot({
    tuition %>%
      filter(State %in% input$States) %>%
      filter(Length == "4-year" | Length == "2-year") %>%
      group_by(Length,State) %>%
      summarise(ave_data=mean(Value),.groups="keep") %>%
      ggplot(aes(State,ave_data,fill=as.factor(Length)))+
      geom_col(position="dodge")+
      labs(title="Tuition Difference Between 2-Year and 4-Year Colleges in the US",
           x="Length",
           y="Tuition Cost")+
      scale_fill_discrete(name="Length")
  })
  
  
  
  
#graph2
  output$Plot2 <- renderPlot({
    tuition %>%
      filter(State %in% input$States) %>%
      filter(Expense=="Room/Board"|Expense=="Fees/Tuition") %>%
      group_by(Expense,State) %>%
      summarise(ave=mean(Value),.groups="keep") %>%
      ggplot( aes(State,ave,fill=as.factor(Expense))) +
      geom_col(position="dodge")+
      labs(title="How Much on Average are Families spending on Fees/Tuition and on Room/Board per State",x="Expense Type",y="Tuition Cost")+
      scale_fill_discrete(name="Expense Type")
  })
  
  

#conclusion 

rows<-nrow(tuition)
rows
cols<-ncol(tuition)
cols
school_type<-unique(tuition$Type)
schooltype_location<- tuition %>%
  group_by(Type) %>%
  summarise(ave=mean(Value))  

output$Plot <- renderPlot({
  tuition %>%
    filter(State %in% input$States) %>%
    group_by(State) %>%
    summarise(ave_data=mean(Value)) %>%
    ggplot(aes(State,ave_data,fill=as.factor(State)))+
    geom_col(position="dodge")+
    labs(title="Average Tuition Costs by State",
         x="State",
         y="tuition cost")+
    scale_fill_discrete(name="State")
  
})

}


shinyApp(ui, server)

  
  