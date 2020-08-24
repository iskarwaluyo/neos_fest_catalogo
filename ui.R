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

library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  headerPanel("Estadísticas NEOSFest"),
  
  fluidRow(
    column(2, "",
      selectInput("sumisiones", "Elige un año:", choices = c("2016", "2017", "2018", "2019", "todos")),
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