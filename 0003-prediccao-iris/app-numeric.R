####################################
# Júlio Rafael                    #
# http://github.com/juliomrafael   #
####################################

# Modificado a partir de Data Professor
# https://github.com/dataprofessor

# Importando pacotes
library(shiny)
library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("model.rds")


####################################
# User interface                   #
####################################

ui <- pageWithSidebar(
  
  # Page header
  headerPanel('Predicção de Íris'),
  
  # Input values
  sidebarPanel(
    #HTML("<h3>Input parameters</h3>"),
    tags$label(h3('Parâmtros de entrada')),
    numericInput("Sepal.Length", 
                 label = "Comprimento da sépala", 
                 value = 5.1),
    numericInput("Sepal.Width", 
                 label = "Largura da sépala", 
                 value = 3.6),
    numericInput("Petal.Length", 
                 label = "Comprimento da pétala", 
                 value = 1.4),
    numericInput("Petal.Width", 
                 label = "Largura da pétala", 
                 value = 0.2),
    
    actionButton("submitbutton", "Submeter", 
                 class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Resultado')),
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Resultado
    
  )
)

####################################
# Server                           #
####################################

server<- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    df <- data.frame(
      Name = c("Sepal Length",
               "Sepal Width",
               "Petal Length",
               "Petal Width"),
      Value = as.character(c(input$Sepal.Length,
                             input$Sepal.Width,
                             input$Petal.Length,
                             input$Petal.Width)),
      stringsAsFactors = FALSE)
    
    Species <- 0
    df <- rbind(df, Species)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)
    
  })
  
  # Resultado
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Cálculo completo.") 
    } else {
      return("O modelo está pronto para o cálculo.")
    }
  })
  
  # Tabela de resultado da predicção
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

####################################
# Criando app em shiny             #
####################################
shinyApp(ui = ui, server = server)