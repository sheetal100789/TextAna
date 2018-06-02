library(shiny)
library(shinythemes)
ui <- fluidPage(theme = shinytheme("sandstone"),
                
                
                #Title
                titlePanel(title = "Natural Language Processing"),
                
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
                                         p("This app is developed to demonstrate the Natural Language Processing functionality of UDpipe package for text Analytics."),
                                         p("UdpipeR package provides simple but easy to use features like tokenization, Parts-of-speech taggig, lemmatization and other necessary parts of NLP."),
                                         h3("Installation", style = "color:orange"),
                                         p("udpipe is available on CRAN hence can be installed like this:"),
                                         code("install.packages('udpipe')"),
                                         h3("Input Dataset", style = "color:orange"),
                                         p("You can select an entire corpus of your choice i.e. the articles you want to do text an on."),
                                         p("Please input your text file in the text-box located to the top left of the screen."),
                                         p("Alternatively, you can download a sample text file from the link below"),
                                         p("Please refer to the link below for sample text file."),
                                         a(href="https://github.com/sheetal100789/TextAna/blob/master/ice-cream%20data.txt"
                                           ,"Sample data input file"),   
                                         br(),
                                         h3("Annotate Input Data", style = "color:orange"),
                                         p("udpipe_annotate() is the first function we'd use to get started with Udpipe."),
                                         p("Please check the annotated output in second tab."),
                                         
                                         h3("Wordclouds", style = "color:orange"),
                                         p("Here we present the most used Nouns and Verbs in the form of word-clouds."),
                                         
                                         h3("Co-occurences", style = "color:orange"),
                                         p("A cooccurence data.frame indicates how many times each term co-occurs with another term."),
                                         p("The output of the function gives a cooccurrence data.frame which contains the fields term1, term2 and cooc where cooc indicates how many times term1 and term2 co-occurred."),
                                         p("A network plot of the most co-occured words is displayed in the fourth tab.")
                                         
                                ),
                                
                                tabPanel(title = "Annotated Document",
                                         
                                         dataTableOutput('Annodata'),
                                         downloadButton('downloadAnnotatedfile', label = "Download full annotated file")
                                         
                                ),
                                tabPanel(title = "WordClouds",
                                         
                                         fluidRow(
                                           plotOutput('WordCloud1'),
                                           plotOutput('WordCloud2')
                                         )
                                         
                                ),
                                
                                tabPanel(title = "Co occurences",
                                         
                                         fluidRow(
                                           plotOutput('Cooc'),
                                           textOutput('selected_var')
                                         )
                                         
                                )
                                
                    )
                    
                  )
                )
)
