library(DT)
library(shiny)
library(readxl)
library(shinydashboard)
library(plotly)

source("dataInput.R")

gen1 <- 1
gen2 <- 1
gen3 <- 1
gen4 <- 1
gen5 <- 1
maxCP <- 3600
minCP <- 10
minDPS <- 10
maxDPS <- 50

lastRevisited <- "2019-09-24"
versionApp <- "v0.3"


ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = div(img(src = ".png", height = 50, width = 50), 
                              paste("Shiny Pokémon Go Dashboard", versionApp)), titleWidth =  600),
  dashboardSidebar( width = 200,
                    sidebarMenu(
                      menuItem("Dashboard", tabName = "Dashboard", icon = icon("chart-bar")),
                      menuItem("Info", tabName = "Info", icon = icon("info"))
                    )
  ),
  dashboardBody(
  fluidRow(
    tabItems(
      #### DASHBOARD ####
      tabItem(tabName = "Dashboard",
        h1("Pokemon Go"),
        column( width = 3,
          box(title = "Input Dashboard",
              width = NULL,
              radioButtons(
                inputId = "source",
                label = "Calcy IV data source",
                choices = c(
                  "Use the default" = "default",
                  "Upload your own CalcyIV file" = "file"
                )
              ),
              # Wrap the file input in a conditional panel
              conditionalPanel(
                # The condition should be that the user selects
                # "file" from the radio buttons
                condition = "input.source == 'file'",
                fileInput("calcyIV", "Upload your own CalcyIV csv")
              ) # end conditional panel
            ) # end box input
        ), #end column input
          column(width = 9,
            box(title = "Overall Details",
                width = 9,
                valueBoxOutput("maxCP"),
                valueBoxOutput("minCP"),
                valueBoxOutput("gen1"),
                valueBoxOutput("gen2"),
                valueBoxOutput("gen3"),
                valueBoxOutput("gen4"),
                valueBoxOutput("gen5")
            ) # end value boxes
          ), # end column value boxes
        fluidRow(
            box(title = "Graph IV vs CP", width = 5,
                plotlyOutput("plot"))),
        fluidRow(
            box(title = "CP details", width = 10,
                DT::dataTableOutput("tableCP"),
                sliderInput("cpRange", label = h3("Min and Max CP"),
                            min = 10, max = 3600, value = c(10, 1499)),
                sliderInput("dpsRange", label = h3("Min and Max DPS"),
                            min = minDPS, max = maxDPS, value = c(minDPS, maxDPS))
                ) # end box table CP details
          ) # end fluidRow
        ), # end tab dashboard
      #### INFO ####
      tabItem(tabName = "Info",
              #### Explanation ####
              box(h1("Explanation"),
                  "blablabla"),
              #### Credits ####
              box(h1("Credits"),
                  "Anna Keune"),
              box(h1("Changelog"),
                  "v0.1: using default data and filtering table\n
                   v0.2: uploading own dataset and tab layout\n
                   v0.3: improve layout, add plot"
                  )
        ) # end tab info
      ) # end tab items
    )
  )
)

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
    allDetails <- AddGeneration(allDetails)
    return(allDetails)
  })
  output$tableCP <- DT::renderDataTable({
    df <- mergedData()
    filteredData <- df[df$CP >= input$cpRange[1] & df$CP <= input$cpRange[2], ]
    displayData <- filteredData[ , c("Nr", "Name", "CP", "DPS", "Fast.move", "Special.move", "max.IV.", "Type I", "Type II")]
    DT::datatable(displayData)
  })
  
  output$plot <- renderPlotly({
    df <- mergedData()
    plot_ly(df, x = ~CP, y = ~max.IV.)
  })
  
  generationCount <- reactive({CountGeneration(mergedData())})
  
  output$gen1 <- renderValueBox(
    valueBox(value = generationCount()$gen1,
             subtitle = "Gen 1",
             icon = icon("dot-circle"),
             color = "blue")
    
  )
  output$gen2 <- renderValueBox(
    valueBox(value = generationCount()$gen2,
             subtitle = "Gen 2",
             icon = icon("dot-circle"),
             color = "blue")
    
  )
  output$gen3 <- renderValueBox(
    valueBox(value = generationCount()$gen3,
             subtitle = "Gen 3",
             icon = icon("dot-circle"),
             color = "blue")
    
  )
  output$gen4 <- renderValueBox(
    valueBox(value = generationCount()$gen4,
             subtitle = "Gen 4",
             icon = icon("dot-circle"),
             color = "blue")
    
  )
  output$gen5 <- renderValueBox(
    valueBox(value = generationCount()$gen5,
             subtitle = "Gen 5",
             icon = icon("dot-circle"),
             color = "blue")
    
  )
  output$maxCP <- renderValueBox(
    valueBox(value = max(mergedData()$CP),
             subtitle = "Max CP",
             icon = icon("grin-stars"),
             color = "red")
    
  )
  output$minCP <- renderValueBox(
    valueBox(value = min(mergedData()$CP),
             subtitle = "Min CP",
             icon = icon("meh"),
             color = "red")
    
  )
}

shinyApp(ui = ui, server = server)