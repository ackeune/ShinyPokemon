function(input, output) {
  # show a table filtered on the min and max cp
  output$tableCP <- DT::renderDataTable({
    filteredData <- defaultData[defaultData$CP >= input$cpRange[1] & defaultData$CP <= input$cpRange[2], ]
    data <- filteredData[ , c("Nr", "Name", "CP", "DPS", "Fast.move", "Special.move")]
    data
  })
  output$details <- renderTable(details, bordered = FALSE, colnames = FALSE)
}