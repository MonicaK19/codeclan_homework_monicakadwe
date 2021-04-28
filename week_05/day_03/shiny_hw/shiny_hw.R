library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel (tags$b((tags$u("Five Country Medal Comparison(Mini Lab)")))),
  fluidRow(
    
    column(6, 
           radioButtons(
             "season",
             (tags$i("\nChoose season")),             #Using HTML to change some of the font
             choices = c("Summer", "Winter")
           )
           ),
    column(6,
            radioButtons(
              "medal",
              (tags$i("\nChoose medal")),             #Using HTML to change some of the fontx
              choices = c("Gold", "Silver", "Bronze")
            )
            ),
   
            plotOutput("medal_plot")
   
    )
  )
  

server <- function(input,output){
  
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