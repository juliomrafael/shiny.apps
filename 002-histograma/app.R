####################################
# Júlio Rafael                    #
# http://github.com/juliomrafael   #
####################################

# Modificado a partir de Winston Chang e Data Professor
# https://shiny.rstudio.com/gallery/shiny-theme-selector.html
# https://github.com/dataprofessor

library(shiny)
data(airquality)

# Definindo a UI da app que desenhará o histograma ----
ui <- fluidPage(
  
  # Título da app ----
  titlePanel("Nível de ozono!"),
  
  # Disposição da barra lateral com definições de entrada e saída ----
  sidebarLayout(
    
    # Painel da barra lateral para entradas ----
    sidebarPanel(
      
      # Entrada: deslizador para o número de caixas ----
      sliderInput(inputId = "barras",
                  label = "Número de barras:",
                  min = 1,
                  max = 50,
                  step=5,
                  value = 30)
      
    ),
    
    # Painel principal para exibição de saídas ----
    mainPanel(
      
      # Saída: Histograma ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)

# Define a lógica do servidor necessária para desenhar um histograma ----
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    
    x    <- airquality$Ozone
    x    <- na.omit(x)
    barras <- seq(min(x), max(x), length.out = input$barras + 1)
    
    hist(x, breaks = barras, col = "#75AADB", border = "black",
         xlab = "Nível de ozono", ylab = "Frequência",
         main = "Histograma do Nível de ozono")
    
  })
  
}

# Criando a app shiny ----
shinyApp(ui = ui, server = server)