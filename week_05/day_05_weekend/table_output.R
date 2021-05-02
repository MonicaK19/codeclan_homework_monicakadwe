#LOADING LIBRARY

library(CodeClanData)
library(tidyverse)
library(ggplot2)
library(shiny)

#DATASET
game_sales

#DEFINING UI 

ui <- fluidPage(
  titlePanel("Video Game Sales"),
  radioButtons("rating",
               "Choose ratings:",
               choices = unique(game_sales$rating), inline = TRUE),
  tableOutput("table_output")
)


#DEFINING SERVER

server <- function(input,output){
 
  #DISPLAYING THE TABLE OUTPUT FOR EACH RATING SELECTED BY THE USER 
   
  output$table_output <- renderTable({
    game_sales %>% 
      filter(rating == input$rating) %>% 
      slice(1:10)
  })
}

shinyApp(ui = ui, server = server)
