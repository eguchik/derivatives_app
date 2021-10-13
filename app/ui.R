library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Absorption spectra into the high-order derivative spectra"),
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
        htmlOutput("ylim_bottom"),
        htmlOutput("ylim_top"),
        actionButton("submit", "プロット"),
        downloadButton("downloadData", "Download")
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
