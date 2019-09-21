source("dataInput.R")

dashboardPage(skin = "red",
              dashboardHeader(title = div(img(src = ".png", height = 50, width = 50), paste("Calcy IV Shiny Dashboard", version)), titleWidth =  600),
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
                            # calculation details and detected properties and generators
                            box(title = "Details scan", width = 6,
                                tableOutput("details")
                            ),
                            box(title = "CP details", width = 6,
                                DT::dataTableOutput("tableCP"),
                                sliderInput("cpRange", label = h3("Min and Max CP"), 
                                            min = minCP, max = maxCP, value = c(10, 1499))
                            )
                            ))
                )
))