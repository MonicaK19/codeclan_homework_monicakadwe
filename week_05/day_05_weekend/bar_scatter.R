#THE CODE BELOW IS TO DISPLAY AN EXAMPLE OF BAR PLOT AND SCATTER PLOT

#LOADING LIBRARY

library(shiny)
library(tidyverse)
library(CodeClanData)
library(ggplot2)

#DATASET

game_sales

#DEFINING UI

ui <- fluidPage(
  titlePanel("Video Game Sales"),
fluidRow(
  
  column(6, 
         radioButtons("rating",
                      "Choose rating:",
                      choices = unique(game_sales$rating)),
  ),
  column(6,
         selectInput("developer",
                     "Choose developer:",
                     choices = unique(game_sales$developer))
         )
),
fluidRow(
  column(6, 
         plotOutput("bargraph")
         ),
  column(6, 
         plotOutput("scatter")
         )
)
)

#DEFINING SERVER

server <- function(input,output){
  
#DISPLAYING BAR PLOT
  #FOR A CHOSEN RATING AND DEVELOPER BY THE USER, WHAT IS THE USER SCORE IN DIFFERENT
  #RELEASED YEARS BASED ON GENRE
  
    output$bargraph <- renderPlot({
    
    game_sales %>% 
      filter(rating == input$rating) %>% 
      filter(developer == input$developer) %>% 
      ggplot()+
      aes(x = year_of_release, y = user_score, fill = genre)+
      geom_bar(stat = "identity")
  })
  
  output$scatter <- renderPlot({
    
    game_sales %>% 
      filter(rating == input$rating) %>% 
      filter(developer == input$developer) %>% 
      ggplot()+
      aes(x = year_of_release, y = user_score, colour = genre)+
      geom_point()
  })
  
  
}

shinyApp(ui = ui, server = server)
