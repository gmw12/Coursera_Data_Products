library(shiny)

shinyUI(fluidPage(
  titlePanel("Loan Amortization"),
  
  navlistPanel(widths=c(2,10), "Menu",
  
 tabPanel("Documentation",
          
         h2("Welcome to the Amortization App!"),
         br(),
         br(),
         h3("This is a simple app to calculate a loan payment"),
         br(),
         h4("Step 1 - Click on 'Application' in the side panel"),
         h4("Step 2 - Enter total loan amount in the first input box"),
         h4("Step 3 - Enter down payment in the second input box"),
         h4("Step 4 - Use slider to set the loan length in years"),
         h4("Step 5 - Use slider to set the interest rate"),
         h4("Step 6 - Click on 'Calculate' to find payment and see a graph of interest and principal over the life of the loan")
 ), 
    
 tabPanel("Application",           
 
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
)
)