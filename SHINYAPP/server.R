library(shiny)
library(utils)
library(stringr)
library(wordcloud)

source(file = "global.R")

shinyServer(function(input, output, clientData, session) {
  
  #test_l <- "KO"
  
  nword <- reactive({
              res <- data.frame()             
              nextw(as.character(input$sent1), res)
                      }) # End of Reactive
  
  test_1 <- reactive({ifelse(nchar(input$sent1)==0,"WAITING",ifelse(is.na(nword()[1,1]), "NOTHING", "OK"))})
  
  top_plot <- reactive({
    #par(las=2) # X names vertical
    barplot(height=nword()$Freq,
            names.arg = nword()$term,
            cex.names=1, main="Top N-grams identified")
  })
  
  output$dynamic <- renderUI(function(){
                      switch({test_1()},           
                      "OK" = radioButtons("nw",
                                          "Next word proposed :", 
                                          choices={as.vector(head(nword()$term, n=3))},
                                          selected=NULL),                                
                      "WAITING" = HTML('So, what are you waiting for ?...'),
                      "NOTHING" = HTML('Hugh ! Looks like I do not know this word...'))
                                        })
  #output$word1 <- renderPrint({as.vector(nword()[,ncol(nword())])})
  output$word1 <- renderPrint({as.vector(head(nword()$term, n=3))})
  output$DT1 <- renderDataTable({nword()})
  output$plot1 <- renderPlot({if ({test_1()}=="OK"){
                              par(las=2)
                              barplot(height=nword()$Freq,
                                      names.arg = nword()$ngram,
                                      cex.names=1, main="Top N-grams identified")}})
                              
  
#   observe({
#     sel_word <- input$dynamic
#     updateTextInput(session, inputId = "sent1", value=paste(input$sent1, sel_word))
#   })

})
