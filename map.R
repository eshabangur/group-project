
tuition <- read.csv('nces330_20.csv')

# Load the required packages
library(ggplot2)
library(ggiraph)
library(maps)
library(dplyr)

colnames(tuition) <- c("Year", "State", "Type", "Length", "Expense", "Value")
tuition <- na.omit(tuition)

states <- map_data("state")
states <- states %>% rename(State = region)

state_avg_value <- merge(states, avg_value, by = "State", all.x = TRUE)

tuition_lower <- tuition %>% mutate(State = tolower(State)) %>% select(State, Value)
state_avg_value <- merge(state_avg_value, tuition_lower, by = "State", all.x = TRUE)

p <- ggplot(state_avg_value, aes(x = long, y = lat, group = group, fill = Value.y, tooltip = paste0(State, ": $", round(Value.y, 2)))) +
  geom_polygon_interactive() +
  scale_fill_gradient(low = "white", high = "red", na.value = "grey50") +
  coord_map() +
  labs(title = "Average College Cost by State",
       fill = "Average Cost")

ggiraph(code = print(p), hover_css = "fill-opacity: 0.8; cursor: pointer;")

