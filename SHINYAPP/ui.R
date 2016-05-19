library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Capstone Project"),

  # Sidebar
  sidebarLayout(
    sidebarPanel(
      h2("Next Word Prediction App"),
      p("by Louis-Ferdinand Goffin, aka Papaluigi"),
      br(),
      img(src = "press.jpg", height=100),
      br(),
      br(),
      textInput(inputId="sent1", label="Type your text here"),
      br(),
      #p("Next word proposed is :"),
      uiOutput("dynamic")
      
    ),

    # Output
    mainPanel(
      tabsetPanel(
        tabPanel("Main",
      h2("Instructions"),
      p("Just type any sequence of words in the input field on the left panel. The next words proposed by the algoritm will appear below the input field."),
      p("The list of proposed words in this panel is limited to 3, from the most probable to the less probable. You can switch to the Plots panel if you want to display the most relevant N-grams with their respective frequencies."),
      p("The App aims to predict the next word ", strong("on the fly"), ", ie as long as you type (same feature as on your prefered samartphone)."),
      h2("App Principles"),
      p("Algorithm is based upon a ", strong("Katz's Back-off"), " process which uses Tri-grams, Bi-grams and Uni-grams analysis in order to identify the most probable word to come. Analysis starts with tri-gram match if possible, switches to bi-grams if not, and to uni-grams if not match is found in bi-grams."),
      p("These N-grams have been computed using a 1.4 millions words sample extracted from the blog dataset provided by the course, after various text cleaning operations."),
      h2("Optimizations performed"),
      p("Special attention has been brought to ", strong("App weight"),". N-grams files initially weight 1.5MB, 19MB and 47MB for Uni-grams, Bi-grams and Tri-grams respectively. Inspired by Paul & Klein, I realized an indexation of Bi-grams and Tri-grams files, using Uni-grams as a reference for index. This led to a significant reduction of the size of the files to 10MB and 15MB respectively."),
      p("Focus has also been set on ", strong("User Experience, especially App speed."), " Table lookup instructions have been optimized, and an additional speed gain has been realized by keeping in the Uni-grams table only the words cumulating 90% of the words usage in the training set. This compromise does not significantly impact accuracy."),
      p("Last but not least, UI is ", strong("dynamic"), " : depending on a next word is found or not, then UI is updated on the left panel and in the Plot panel."),
      p("The App currently does not allow to select identified words in order to update the input.")
      #verbatimTextOutput("word1")
      #dataTableOutput("DT1")
        ), #End of Main tabpanel
        tabPanel("Plots",
           plotOutput("plot1")
                 #dataTableOutput("DT1")
        ), # End of Plots tabpanel
        tabPanel("Code",
                 h2("Code can be found on my GitHub")
               #dataTableOutput("DT1")
      )
      ) #End of tabsetPanel
    ) # End of mainPanel
  )
))
