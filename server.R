#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plyr)
library(dplyr)
library(ggplot2)
library(pastecs)
library(data.table)
library(curl)
library(devtools)
library(rio)
library(lattice)

vid_2016 <- import('http://neosfest.com/neos_stats/catalogo_2016.csv')
vid_2017 <- import('http://neosfest.com/neos_stats/catalogo_2017.csv')
vid_2018 <- import('http://neosfest.com/neos_stats/catalogo_2018.csv')
vid_todos <- import('http://neosfest.com/neos_stats/catalogo_completo.csv')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$sumisiones,
           "2016" = vid_2016,
           "2017" = vid_2017,
           "2018" = vid_2018,
           "todos" = vid_todos
    )
  })
  
  output$datos <- renderPrint({
    sumisiones <<- datasetInput()
  })
  
  output$escuelas <- renderPrint({
    sumisiones <<- datasetInput()
    count(unique(sumisiones$universidad))
  })
  
  output$paises <- renderPrint({
    sumisiones <<- datasetInput()
    count(unique(sumisiones$pas_de_origen))
  })
  
  output$frecuencia_region <- renderTable({
    sumisiones <<- datasetInput()
    region <<- as.data.frame(sumisiones$region)
    as.data.frame(table(unlist(region)))
  })
  
  output$frecuencia_paises <- renderTable({
    sumisiones <<- datasetInput()
    paises <<- as.data.frame(sumisiones$pas_de_origen)
    as.data.frame(table(unlist(paises)))
  })
  
  output$frecuencia_escuelas <- renderTable({
    sumisiones <<- datasetInput()
    escuelas <<- as.data.frame(sumisiones$universidad)
    as.data.frame(table(unlist(escuelas)))
  })
  
  output$stat_video <- renderTable({
    sumisiones <<- datasetInput()
    uni <<- nrow(as.data.frame(unique(sumisiones$universidad)))
    pais <<- nrow(as.data.frame(unique(sumisiones$pas_de_origen)))
    stat_video <<- cbind(uni, pais)
  })  
  
  output$mytable = DT::renderDataTable({
    sumisiones <<- datasetInput()
    titulos <<- sumisiones$ttulo_de_inscripcin
    direc <<- sumisiones$director
    uni <<- sumisiones$universidad
    pais <<- sumisiones$pas_de_origen
    seleccion <<- sumisiones$year
    categoria <<- sumisiones$categora
    videos <<- as.data.frame(cbind(titulos, direc, uni, pais, seleccion, categoria))
    colnames(videos) <- c("Título", "Director", "Universidad", "País","Selección","Categoría")
    videos
  })

  
})

