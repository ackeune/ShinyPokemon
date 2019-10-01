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
                           valueBox(value = maxCP,
                                    subtitle = "Maximum CP",
                                    icon = icon("grin-stars"),
                                    color = "blue",
                                    width = 3),
                           valueBox(value = minCP,
                                    subtitle = "Minimum CP",
                                    icon = icon("meh"),
                                    color = "blue",
                                    width = 3),
                           
                           valueBox(value = gen1,
                                    subtitle = "Gen 1",
                                    icon = icon("dot-circle"),
                                    color = "blue",
                                    width = 3),
                           valueBox(value = gen2,
                                    subtitle = "Gen 2",
                                    icon = icon("dot-circle"),
                                    color = "blue",
                                    width = 3),
                           valueBox(value = gen3,
                                    subtitle = "Gen 3",
                                    icon = icon("dot-circle"),
                                    color = "blue",
                                    width = 3),
                           valueBox(value = gen4,
                                    subtitle = "Gen 4",
                                    icon = icon("dot-circle"),
                                    color = "blue",
                                    width = 3),
                           valueBox(value = gen5,
                                    subtitle = "Gen 5",
                                    icon = icon("dot-circle"),
                                    color = "blue",
                                    width = 3)
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
    ) # end fluidRow
  ) # end dashboard body
) # end ui