####################################
# Júlio Rafael                    #
# http://github.com/juliomrafael   #
####################################

# Modificado a partir de Data Professor
# https://github.com/dataprofessor

library(shiny)
library(shinythemes)


####################################
# User Interface                   #
####################################
ui <- fluidPage(theme = shinytheme("united"),
                navbarPage("Calculadora IMC:",
                           
                           tabPanel("Inicio",
                                    # Input values
                                    sidebarPanel(
                                      HTML("<h3>Parâmetros</h3>"),
                                      sliderInput("height", 
                                                  label = "Altura", 
                                                  value = 175, 
                                                  min = 40, 
                                                  max = 250),
                                      sliderInput("weight", 
                                                  label = "Peso", 
                                                  value = 70, 
                                                  min = 20, 
                                                  max = 100),
                                      
                                      actionButton("submitbutton", 
                                                   "Submeter", 
                                                   class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Resultado')),
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata') # Tabela de resultados
                                    ) # mainPanel()
                                    
                           ), #tabPanel(), Home
                           
                           tabPanel("Sobre", 
                                    titlePanel("Sobre"), 
                                    div(includeMarkdown("sobre.md"), 
                                        align="justify")
                           ) #tabPanel(), About
                           
                ) # navbarPage()
) # fluidPage()


####################################
# Server                           #
####################################
server <- function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    bmi <- input$weight/( (input$height/100) * (input$height/100) )
    bmi <- data.frame(bmi)
    names(bmi) <- "IMC"
    print(bmi)
    
  })
  
  # Resultado
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Cálculo completo.") 
    } else {
      return("Modelo está pronto para cálculo.")
    }
  })
  
  # Tabela com resultados da predição
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}


####################################
# Criando app em shiny                 #
####################################
shinyApp(ui = ui, server = server)