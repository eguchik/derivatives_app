library(pracma)
library(colorspace)

server = function(input, output, session) {
  observeEvent(input$file, {

    csv_file <- reactive(read.csv(input$file$datapath, fileEncoding="UTF-8-BOM"))

    output$dorder <- renderUI({ 
      selectInput("dorder", "微分次数", choices=c(1, 2, 4, 8), selected=4)
    })
    output$fl <- renderUI({ 
      selectInput("fl", "フィルター幅", choices=seq(3,100, by = 2), selected=23)
    })
    output$forder <- renderUI({ 
      radioButtons("forder", "多項式の次数", choices=c(2, 4), selected=2)
    })
    output$n_smoothing <- renderUI({ 
      selectInput("n_smoothing", "スムージングの回数", choice=1:20, selected=4)
    })
    output$ylim_bottom <- renderUI({ 
      textInput("ylim_bottom", "y-axis limit (bottom)", value=-0.00003)
    })
    output$ylim_top <- renderUI({ 
      textInput("ylim_top", "y-axis limit (top)", value=0.00003)
    })
  })

  observeEvent(input$submit, {
    csv_file <- reactive(read.csv(input$file$datapath, fileEncoding="UTF-8-BOM"))

    wavelength <- csv_file()[, 1]
    spectra <- csv_file()[, 2:ncol(csv_file())]
    der_spc <- data.frame(spectra)
    dorder <- as.numeric(input$dorder)
    fl <- as.numeric(input$fl)
    forder <- as.numeric(input$forder)
    n_smoothing <- as.numeric(input$n_smoothing)
    ylim_bottom <- as.numeric(input$ylim_bottom)
    ylim_top <- as.numeric(input$ylim_top)

    for (i in colnames(spectra)) {
      for (j in 1:dorder) {
        der_spc[, i] <- gradient(der_spc[, i])
      }
      for (k in seq(1:n_smoothing)) {
        der_spc[, i] = savgol(der_spc[, i], fl=fl, forder=forder, dorder=0)
      }
    }
    
    output$table <- renderTable(data.frame(wavelength, der_spc), digits=10)
    output$plot <- renderPlot({
      palette <- rainbow_hcl(ncol(spectra), c=90, l=60)
      for (i in seq(1:ncol(spectra))) {
        plot(wavelength, der_spc[, i], type='l', xlim=c(320,800), ylim=c(ylim_bottom, ylim_top), xlab='x', ylab='y', col=palette[i], lwd=2)
        par(new=T)
      }
    })

    output$downloadData <- downloadHandler(
      filename = function() {
        paste0("derivatives_", dorder, 'd', fl, 'px', n_smoothing, ".csv", sep="")
      },
      content = function(file) {
        write.csv(data.frame(wavelength, der_spc), file, row.names=FALSE)
      }
    )
  })
}
