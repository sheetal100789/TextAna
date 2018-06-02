library(shiny)
ui <- fluidPage(
  #Title
  titlePanel(title = "Text Analytics using udpipe"),
  
  #sidebarLayout for uploading file
  sidebarLayout(
    sidebarPanel(
      
      #input : select a file:
      fileInput("textFile", "Select a text file :",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      # Horizontal line ----
      tags$hr(),
      
      helpText("Co-occurrence refers to occcurrence of two terms alongside each other"),
      
      # select the part-of-speech tags 
      checkboxGroupInput("selectpos", 
                         label = "Select the part of speech for plotting co-occurence",
                         choices = list("Adjective (ADJ)" = "ADJ",
                                        "Noun(NOUN)" = "NOUN" ,
                                        "Proper Noun (PROPN)" = "PROPN",
                                        "Adverb (ADV)" = "ADV",
                                        "Verb (VERB)" = "VERB"),
                         selected = c("ADJ","NOUN","PROPN")
      )
      
    )
    ,
    
    
    #main Panel
    mainPanel(
      
      tabsetPanel(type = "tabs",
                  #4 tabs
                  tabPanel(title = "Description",
                           p("This is my first Shiny app development")
                           
                           
                  ),
                  
                  tabPanel(title = "Annotated Document",
                           p("This tab shows annotated document"),
                           dataTableOutput('Annodata'),
                           downloadButton('downloadAnnotatedfile', label = "Download full annotated file")
                           
                  ),
                  tabPanel(title = "WordClouds",
                           p("This tab shows the word clouds"),
                           fluidRow(
                             plotOutput('WordCloud1'),
                             plotOutput('WordCloud2')
                           )
                           
                  ),
                  
                  tabPanel(title = "Co occurences",
                           p("This tab shows the Co occurences"),
                           fluidRow(
                             plotOutput('Cooc'),
                             textOutput('selected_var')
                           )
                           
                  )
                  
      )
      
    )
  )
)
