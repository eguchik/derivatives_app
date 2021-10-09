library(pracma)

server = function(input, output, session) {
  
  observeEvent(input$file, {
    csv_file <- reactive(read.csv(input$file$datapath))

    output$table <- renderTable(csv_file())

    output$dorder <- renderUI({ 
      selectInput("dorder", "微分次数", choices=c(1, 2, 4, 8), selected=4)
    })
    output$fl <- renderUI({ 
      selectInput("fl", "フィルター幅", choices=seq(3,100, by = 2), selected=19)
    })
    output$forder <- renderUI({ 
      radioButtons("forder", "多項式の次数", choices=c(2, 4), selected=4)
    })
    output$n_smoothing <- renderUI({ 
      selectInput("n_smoothing", "スムージングの回数", choice=seq(1, 20), selected=6)
    })
  })

  observeEvent(input$submit, {

    csv_file <- reactive(read.csv(input$file$datapath))

    wavelength <- csv_file()[, 1]
    spectra <- csv_file()[, 2:ncol(csv_file())]

    dorder = as.numeric(input$dorder)
    fl = as.numeric(input$fl)
    forder = as.numeric(input$forder)
    n_smoothing = as.numeric(input$n_smoothing)


    der_spc <- data.frame(spectra)
    for (i in colnames(spectra)) {
      for (j in seq(1:dorder)) {
        der_spc[, i] = gradient(der_spc[, i])
      }
      for (k in seq(1:n_smoothing)) {
        der_spc[, i] = savgol(der_spc[, i], fl=fl, forder=forder, dorder=0)
      }
    }

    output$plot <- renderPlot({
      for (i in colnames(spectra)) {
        plot(wavelength, der_spc[, i], type='l', xlim=c(320,800), ylim=c(-0.00003, 0.00003), xlab='x', ylab='y')
        par(new=T)
      }
    })



  })

}