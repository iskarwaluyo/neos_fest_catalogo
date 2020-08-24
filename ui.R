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
library(DT)

vid_2016 <- import('http://neosfest.com/neos_stats/catalogo_2016.csv')
vid_2017 <- import('http://neosfest.com/neos_stats/catalogo_2017.csv')
vid_2018 <- import('http://neosfest.com/neos_stats/catalogo_2018.csv')
vid_todos <- import('http://neosfest.com/neos_stats/catalogo_completo.csv')

library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  headerPanel("Estadísticas NEOSFest"),
  
  fluidRow(
    column(2, "",
      selectInput("sumisiones", "Elige un año:", choices = c("2016", "2017", "2018", "todos")),
      submitButton("Actualizar Vista")
  ),
  
  column(10, "",
    tabsetPanel(
      tabPanel("Seleccionados por ubicación",
          fluidRow(
            column(6, "Videos por escuela",
                   tableOutput("frecuencia_escuelas")
            ),
            
            column(3, "Videos por país",
                   tableOutput("frecuencia_paises")
            ),
            column(3, "Videos por región",
                  tableOutput("frecuencia_region"),
                  tableOutput("stat_video")
                  )
          )   
          ),
      tabPanel("Videos seleccionados", 
               DT::dataTableOutput("mytable"))
    )
  )
  )
))