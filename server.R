server <- function(input, output) {
  dataCalcy <- reactive({
    if (input$source == "default") {
      data <- read.csv("history_20190929_084646.csv")
    } else if (input$source == "file") {
      data <- inputFile()
    }
    return(data)
  })
  
  inputFile <- reactive({
    inFile <- input$calcyIV
    if (is.null(inFile))
      return(NULL)
    df <- read.csv(inFile$datapath)
    return(df)
  })
  
  mergedData <- reactive({
    pokemonStats <- read_excel("PokemonStats.xlsx", sheet = 3)
    dataPokemon <- dataCalcy()
    dataPokemon$Nat <- dataPokemon$Nr
    allDetails <- merge(dataPokemon, pokemonStats, by = "Nat")
    return(allDetails)
  })
  output$tableCP <- DT::renderDataTable({
    df <- mergedData()
    filteredData <- df[df$CP >= input$cpRange[1] & df$CP <= input$cpRange[2], ]
    displayData <- filteredData[ , c("Nr", "Name", "CP", "DPS", "Fast.move", "Special.move", "max.IV.", "Type I", "Type II")]
    DT::datatable(displayData)
  })
  
  output$plot <- renderPlotly({
    df <- dataCalcy()
    plot_ly(df, x = ~CP, y = ~max.IV.)
  })
}

shinyApp(ui = ui, server = server)