tuition <- read.csv('nces330_20.csv')
setwd('/Users/annafang/desktop/info201/group-project')

library(ggplot2)
library(ggiraph)
library(maps)
library(dplyr)

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

p <- ggplot(state_summary_polygons, aes(x = long, y = lat, group = group, fill = avg_value, tooltip = paste0(State, ": $", round(avg_value, 2)))) +
  geom_polygon_interactive() +
  scale_fill_gradient(low = "white", high = "red", na.value = "grey50") +
  coord_map() +
  labs(title = "Average College Cost by State",
       fill = "Average Cost")

ggiraph(code = print(p), hover_css = "fill-opacity: 0.8; cursor: pointer;")

