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
        htmlOutput("dorder"),
        htmlOutput("fl"),
        htmlOutput("forder"),
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