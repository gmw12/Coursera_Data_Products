library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  payment <<- ""

                       
  calculations <- function(input, output){
    
    interest_rate <<- input$interest / 100
    n_years <<- input$years
    n_payments <<-  n_years * 12
    compounding_periods <- 12
    payments_year <- 12
    rate_period <<- (1 + (interest_rate /compounding_periods))^(compounding_periods/payments_year) - 1
    loan <<- input$loan - input$down
    
    payment <<- round(loan * (rate_period*(1+rate_period)^n_payments) / 
                                     ((1+rate_period)^n_payments - 1), digits = 2)
                      
    amort <<-data.frame(payment=0, amount=0, interest=0, principal=0, balance=loan) 
    
    for(i in 1:n_payments){
      interest <- round(rate_period*amort$balance[i], digits = 2)
      principal <- round(payment - interest, digits = 2)
      balance <- round(amort$balance[i] - principal, digits = 2)
      newline <- c(i, payment, interest, principal, balance)
      amort <- rbind(amort, newline)
    }
    
    if(amort$balance[i+1] !=0) {
      amort$amount[i+1] <- amort$amount[i+1] + amort$balance[i+1]
      amort$principal[i+1] <- amort$principal[i+1] + amort$balance[i+1]
      amort$balance[i+1] <- 0
    }
    
    amort <<- amort
    
    output$payment <- renderText({ payment })
    
    output$plot1 <- renderPlot({
      
      colors <- c("Principal" = "green", "Interest" = "red")
      
      ggplot(amort[2:nrow(amort),]) +
        geom_line(aes(x=payment, y=principal, color="Principal")) +
        geom_line(aes(x=payment, y=interest, color="Interest")) +
        ylab("Amount") +
        xlab("Payment") +
        ggtitle("Amount of Payment Toward Principal and Interest") +
        theme(legend.title = element_blank()) +
        scale_color_manual(values=colors)
      
    })
    
    
    
    

  }


  
  observeEvent(input$calculate, {
          calculations(input, output)
  })  
  
  

  
  

  
})