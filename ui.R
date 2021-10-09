library(shiny)

shinyUI(
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        fileInput("file", "csvファイルを選択してください",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        ),
        tags$hr(),
        h3('条件'),
        htmlOutput("derivative_order"),
        htmlOutput("filter_width"),
        htmlOutput("polynomial_order"),
        htmlOutput("n_smoothing"),
        actionButton("submit", "プロット")
      ),
      mainPanel(
        tabsetPanel(type = "tabs",
        　　　　　　 tabPanel("Plot", plotOutput("plot")),
                    tabPanel("Table", tableOutput('table')),
                    
        )
      )
    )
  )
)