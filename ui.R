library(shiny)

shinyUI(fluidPage(
  titlePanel("Loan Amortization"),
  
  sidebarLayout(
    
    sidebarPanel(
      numericInput("loan", label = h3("Total Loan Amount"), value = 21000),
      numericInput("down", label = h3("Down Payment"), value = 1000), 
      sliderInput("years", label=h3("Length of Loan (years)"), min=1, max=30, value = 5), 
      sliderInput("interest", label=h3("Interest Rate %"), min=1, max=20, value = 7.5, step = 0.125),
      br(),
      actionButton("calculate", label =  "Calculate!")
    ),
    
    mainPanel(
      h4("Monthly Payment:"),
      textOutput("payment"),
      tags$head(tags$style("#payment{color: red;
                                 font-size: 20px;
                                 font-style: italic;
                                 }")),
      br(),
      br(),
      br(),
      
      plotOutput("plot1")
      
    )
  
  )
))