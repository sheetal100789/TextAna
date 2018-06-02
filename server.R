library(shiny)
server <- function(input, output, session) {
  
  Dataset <- reactive({
    if (is.null(input$textFile)) { return(NULL) }
    else{
      #  model <- udpipe_download_model(language = "english")
      english_model <- udpipe_load_model("./english-ud-2.0-170801.udpipe")
      Data <- readLines(input$textFile$datapath)
      
      x <- udpipe_annotate(english_model, x = Data) #%>% as.data.frame() %>% head()
      x <- as.data.frame(x)
      x <- x[-4]
      return(x)
    }
  })
  
  output$Annodata = renderDataTable({
    out = data.frame(Dataset())
    out
  })
  
  # Downloadable csv of selected annotated file ----
  output$downloadAnnotatedfile <- downloadHandler(
    filename = function() {
      paste(input$textFile, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(Dataset(), file, row.names = TRUE)
    }
  )
  
  #WordClouds is the out put obj for tab 3
  output$WordCloud1 = renderPlot({
    total_nouns <- Dataset() %>% subset(., upos %in% "NOUN")   # std penn treebank based POStags
    top_nouns = txt_freq(total_nouns$lemma)
    
    wordcloud(top_nouns$key,top_nouns$freq)
    
  })
  
  output$WordCloud2 <- renderPlot({
    total_verbs <- Dataset() %>% subset(., upos %in% "VERB")   # std penn treebank based POStags
    top_verbs = txt_freq(total_verbs$lemma)
    wordcloud(top_verbs$key,top_verbs$freq)
  })
  
  corpus_cooc <- reactive({
    filter_cooc <- cooccurrence(Dataset()$lemma, 
                                relevant = Dataset()$upos %in% input$selectpos)
    
    
    
    
    
    
    
    return(filter_cooc)
  })
  
  #  output$Cooc <- renderDataTable(head(corpus_cooc(),30))
  output$Cooc <- renderPlot({
    wordnetwork <- head(corpus_cooc(), 50)
    wordnetwork <- igraph::graph_from_data_frame(wordnetwork) # needs edgelist in first 2 colms.
    
    ggraph(wordnetwork, layout = "fr") +  
      
      geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "darkorange") +  
      geom_node_text(aes(label = name), col = "darkgreen", size = 6) +
      
      theme_graph(base_family = "Arial Narrow") +  
      theme(legend.position = "none") +
      
      labs(title = "Cooccurrences")
    
  })
  
  output$selected_var <- renderText({
    paste(input$selectpos)
  })
}
