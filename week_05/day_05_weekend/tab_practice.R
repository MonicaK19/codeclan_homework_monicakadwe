#PRACTICING TABS

#LOADING LIBRARY

library(CodeClanData)
library(shiny)
library(tidyverse)
library(ggplot2)

#DATASET

game_sales

#DEFINING UI

ui <- fluidPage(
  
  titlePanel(tags$b("Video Games")),
  sidebarLayout(
    sidebarPanel(
      selectInput("name",
                 "Choose game genre:",
                 choice = unique(game_sales$genre)
    ),

    #REACTIVE EVENT   
    actionButton("go", "Generate")
    ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Critic Score",
               plotOutput("critic")
              
      ),
      tabPanel("User Score",
               plotOutput("user")
      ),
      tabPanel("Sale",
               plotOutput("saleplot")
               )
      )
    )
)
)
  
  
#DEFINING SERVER

server <- function(input, output){

  #DEFINING REACTIVE EVENT
  
 filter_data <- eventReactive(input$go,{
   game_sales %>% 
    filter(genre == input$name)
   
 })
  
#FOR A CHOSEN GAME GENRE, 3 TABS WILL SHOW DIFFERENT PLOTS.
 #TAB 1 : CRITIC SCORE - BASED ON THE RATING, PLOT WILL SHOW THE CRITIC SCORE FOR THE DEVELOPER
 #TAB 2 : USER SCORE - BASED ON ONLY 2 RATINGS, SCATTER PLOT WILL SHOW POPULAR PLATFORM (AS IT WILL GET MORE NUMBER OF USER SCORE)
 #TAB 3 : SALE - SALE FOR THE RELEASED YEARS FOR DIFFERENT DEVELOPERS.
 
  output$critic <- renderPlot({
    
   ggplot(filter_data())+
     aes(x = developer, y = critic_score, fill = rating)+
     geom_col(position = "dodge")+
     coord_flip()+
     labs(
       x = "Developer",
       y = "Critic Score",
       fill = "Rating"
     )
    
    })
 
 
 output$user <- renderPlot({
   filter_data () %>% 
     filter(rating == "E" | rating  == "M") %>% 
     filter(user_score > 5.0) %>% 
    ggplot()+
     aes(x = platform, y = user_score)+
     geom_point(aes(colour = rating, shape = rating), size = 4)+
     labs(
       x = "Platform",
       y = "User Score",
       fill = "Rating"
     )
     })
 
 output$saleplot <- renderPlot({
   
   ggplot(filter_data())+
     aes(x = year_of_release, y = sales, fill = developer)+
     geom_col()+
     facet_wrap(~developer)+
     labs(
       x = "Release year",
       y = "Sales",
       fill = "Developer"
     )
 })
}

shinyApp(ui = ui, server = server)


  