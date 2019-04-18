library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving & Investing Modalities"),
   
   # Sidebars
   fluidRow(
     column(4, sliderInput("Initial_Amount", "Initial Amount",
                        min = 0,
                        max = 100000,
                        step = 500,
                        value = 1000,
                        pre = "$")
            ),
     column(4, sliderInput("Rate", "Return Rate (in %)",
                        min = 0,
                        max = 20,
                        step = 0.1,
                        value = 5)
            ),
     column(4, sliderInput("Years", "Years",
                        min = 0,
                        max = 50,
                        step = 1,
                        value = 10)
            )),
    fluidRow(
      column(4, sliderInput("Annual_Contribution", "Annual Contribution",
                        min = 0, 
                        max = 50000,
                        step = 500,
                        value = 2000,
                        pre = "$")
      ),
      column(4, sliderInput("Growth_Rate", "Growth Rate (in %)",
                        min = 0, 
                        max = 20, 
                        step = 0.1,
                        value = 2)
      ),
      column(4, selectInput("Facet", "Facet?", 
                        choices = list("Yes", "No"), 
                        selected = "No")
      )
    ),
   
   #display lineplot and data table 
   mainPanel(
     titlePanel("Timelines"),
     plotOutput("timelines", width = 600, height = '300'),
     titlePanel("Balances"),
     verbatimTextOutput("balances")
   )
)
   

# Define server 
server <- function(input, output) {
   
  # Define functions for different saving options
  
  #' @title funciton of investing
  #' @description calculate the value return
  #' @param amount initial investment
  #' @param rate annual rate of return
  #' @param years number of years
  #' @return value of return
  
  no_contri_1 <- function(amount, rates, years) {
    return_1 <- amount * (1 + rates)^years
    return(return_1)
  }
  
  #' @title funciton of investing
  #' @description calculate the value return when fixed depositing
  #' @param amount initial investment
  #' @param rate annual rate of return
  #' @param years number of years
  #' @return value of return
  
  fix_contri_1 <- function(contrib, rates, years) {
    return_2 <- contrib * (((1 + rates)^years - 1) / rates)
    return(return_2)
  }
  
  #' @title funciton of investing
  #' @description calculate the value return when growing depositing
  #' @param amount initial investment
  #' @param rate annual rate of return
  #' @param years number of years
  #' @return value of return
  
  growing_contri_1 <- function(contrib, rates, growth, years) {
    return_3 <- contrib * (((1 + rates)^years - (1 + growth)^years) / (rates - growth))
    return(return_3)
  }
  
  #table
  table <- reactive( {
    
    #initialize vectors
    no_contrib <- length(11)
    fixed_contrib <- length(11)
    growing_contrib <- length(11)
    
    #fill in initial value
    no_contrib[1] = input$Initial_Amount
    fixed_contrib[1] = input$Initial_Amount
    growing_contrib[1] = input$Initial_Amount
    
    #fill in the table
    for (i in 1 : input$Years) {
      no_contrib[i + 1] <- no_contri_1(amount = input$Initial_Amount, rates = input$Rate/100, years = i)
      fixed_contrib[i + 1] <- no_contri_1(amount = input$Initial_Amount, rates = input$Rate/100, years = i) + 
        fix_contri_1(contrib = input$Annual_Contribution, rates = input$Rate/100, years = i)
      growing_contrib[i + 1] <- no_contri_1(amount = input$Initial_Amount, rates = input$Rate/100, years = i) +
        growing_contri_1(contrib = input$Annual_Contribution, rates = input$Rate/100, growth = input$Growth_Rate/100, years = i)
    }
    
    table <- data.frame("years" = c(seq(0, 10, 1)), 
                             "no_contrib" = no_contrib, 
                             "fixed_contrib" = fixed_contrib, 
                             "growing_contrib" = growing_contrib)
    table
  }
)
  
  # Plot
  output$timelines <- renderPlot({
    df = table()
    years = input$Years
    df = data.frame(year = rep(df$years, 3), 
                    value = c(df$no_contrib, df$fixed_contrib, df$growing_contrib),
                    Mode = factor(c(rep("no_contrib",years+1), rep("fixed_contrib",years+1), rep("growing_contrib",years+1)),
                    ))
    
    if (input$Facet == "No") {
      ggplot(df, aes(x = year, y = value, color = Mode)) +
        labs(title = "Three Modes of Investing", x = "Year", y = "Value", color = "Mode") +
        geom_line()+
        geom_point() 
      
    } else {
      # Facetting
      ggplot(df, aes(x = year, y = value))+
        geom_point(aes(color = Mode)) +
        geom_line(aes(color = Mode)) +
        geom_area(aes(fill= Mode)) +
        lab(title = "Modes of Investing", x = "Year", y = "Value") + 
        facet_wrap(~Mode) 
    }
  })
  
  # Table output
  output$balances <- renderPrint({
    table()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

