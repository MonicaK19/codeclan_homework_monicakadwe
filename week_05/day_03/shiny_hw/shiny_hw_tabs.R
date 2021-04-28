library(shiny)
library(tidyverse)
library(CodeClanData)
library(stringi)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel (tags$b((tags$u("Five Country Medal Comparison(Mini Lab)")))),
  tabsetPanel(
    
    tabPanel("SEASON",
             radioButtons(
               "season",
               (tags$i("\nChoose season")),             #Using HTML to change some of the font
               choices = c("Summer", "Winter")
             )
    ),
    
    tabPanel("MEDAL",
             radioButtons(
               "medal",
               (tags$i("\nChoose medal")),             #Using HTML to change some of the fontx
               choices = c("Gold", "Silver", "Bronze")
             )
    ),
    
    tabPanel("PLOT",
             plotOutput("medal_plot"),
             (tags$b(textOutput("text1"))),
             (tags$b(textOutput("text2")))
    )
    )
  ) 
  
  
    
    
server <- function(input,output){
  
  output$text1 <- renderText({
    str_c("Medal: ",input$medal, sep=" ")  
      
  })
  
  output$text2 <- renderText({
  str_c("Season:",input$season, sep=" ")
 })
  
  output$medal_plot <- renderPlot({
    olympics_overall_medals %>%
      filter(team %in% c("United States",
                         "Soviet Union",
                         "Germany",
                         "Italy",
                         "Great Britain")) %>%
      filter(medal == input$medal) %>%
      filter(season == input$season) %>%
      ggplot() +
      aes(x = team, y = count, fill = medal) +
      geom_col(width = 0.5)+
      scale_fill_manual(values = c("Gold" = "#F5B041", 
                                   "Silver" = "#808B96", 
                                   "Bronze" = "#DC7633"))+
      labs(
        x = "Country",
        y = "Count", 
        fill = "Medal"
      )
  })
}
shinyApp(ui = ui, server = server)