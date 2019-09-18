function(input, output) {
  # show a table filtered on the min and max cp
  output$tableCP <- renderTable({
    filteredData <- defaultData[defaultData$CP >= input$minCP & defaultData$CP <= input$maxCP, ]
    data <- filteredData[1:10, c("Nr", "Name", "CP", "DPS", "Fast.move", "Special.move")]
    data
  })
}