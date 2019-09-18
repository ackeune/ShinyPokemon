defaultData <- read.csv("history_20190918_091616.csv")

minCP <- min(defaultData$CP)
maxCP <- max(defaultData$CP)

fluidPage(
  sidebarLayout(
    sidebarPanel(
      numericInput("minCP", label = h3("Min CP"), value = 10),
      numericInput("maxCP", label = h3("Max CP"), value = 1499)
    ),
    mainPanel(
      tableOutput("tableCP")
    )
  )
)