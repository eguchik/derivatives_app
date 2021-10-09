library(pracma)

server = function(input, output, session) {
  observeEvent(input$file, {
    
    csv_file <- reactive(read.csv(input$file$datapath))


    output$table <- renderTable(csv_file())
    
    output$derivative_order <- renderUI({ 
      selectInput("derivative_order", "微分次数", choice=c(1, 2, 4, 8))
    })
    output$filter_width <- renderUI({ 
      selectInput("fl", "フィルター幅", choice=seq(1,100, by = 2))
    })
    output$polynomial_order <- renderUI({ 
      selectInput("y", "多項式の次数",choice=c(2, 4))
    })
    output$n_smoothing <- renderUI({ 
      selectInput("y", "スムージングの回数", choice=seq(1, 20))
    })

  })
  
  observeEvent(input$submit, {
    name <- names(input$file)
    csv_file <- reactive(read.csv(input$file$datapath))
    wavelength <- csv_file()[, 1]
    spectra <- csv_file()[, 2:ncol(csv_file())]

    der_spc <- data.frame(spectra)
    for (i in colnames(spectra)) {
        for (j in c(1, 2, 3, 4)) {
            der_spc[, i] = gradient(der_spc[, i])
        }
        for (k in c(1, 2, 3, 4, 5, 6)) {
            der_spc[, i] = savgol(der_spc[, i], fl=23, forder=2, dorder=0)
        }
    }

    
    
    output$plot <- renderPlot({
      for (i in colnames(der_spc)){
        plot(wavelength, der_spc[, i], type='l', xlim=c(320,800), ylim=c(-0.00003, 0.00003), xlab='x', ylab='y')
        par(new=T)
      }
    })
  })
}