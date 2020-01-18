library(shiny)
library(networkD3)
library(dplyr)

## parse argument(s)
args <- commandArgs(trailingOnly=TRUE)
networkFile <- args[1]

## load provided file
x <- read.table(networkFile, header=TRUE,sep="\t")

## shiny UI
ui <- shinyUI(pageWithSidebar(
  titlePanel("MASCARA Output"),
  sidebarPanel(
    uiOutput("Celltype"),
    uiOutput("TF")#,
    #numericInput("TG","Number of Targets to View", 27 )
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Table",tableOutput("Table")),
      tabPanel("Network",simpleNetworkOutput("net"))
    )
  )
)
)

## shiny server
server <- function(input, output, session) {
  tab <- reactive({
    x %>% 
      filter(Celltype == input$Celltype) %>%
      filter(TF == input$TF)
  })
  
  net <- reactive({
    x %>% 
      filter(Celltype == input$Celltype) %>%
      filter(TF == input$TF)
  })
  
  output$Celltype <- renderUI({
    
    selectizeInput("Celltype","Choose A Cell State", choices = c("select" = "", unique(x$Celltype)))
  })
  
  output$TF <- renderUI({
    choice_tf <- reactive({
      x %>% 
        filter(Celltype == input$Celltype) %>%
        pull(TF) %>%
        
        as.character()
    })
    selectizeInput("TF","Choose A Transcription Factor", choices = c("select" = "", choice_tf()))
  })
  
  output$Table <- renderTable({
    tab()
  }) 
  
  output$net <- renderSimpleNetwork({
    networkData <- net()
    networkData = networkData[, c('TF','TG' )]
    simpleNetwork(networkData)
  })
  
}

## Launch app in browser
shinyApp(ui=ui, server=server, options=list(launch.browser=TRUE))
