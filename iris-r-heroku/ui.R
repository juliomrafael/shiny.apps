library(shiny)

# Training set
TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

pageWithSidebar(

  # Page header
  headerPanel('Predicção de Íris'),

  # Input values
  sidebarPanel(
    HTML("<h3>Parâmtros de entrada</h4>"),
    sliderInput("Sepal.Length", label = "Comprimento da sépala", value = 5.0,
                min = min(TrainSet$Sepal.Length),
                max = max(TrainSet$Sepal.Length)
    ),
    sliderInput("Sepal.Width", label = "Largura da Sépala", value = 3.6,
                min = min(TrainSet$Sepal.Width),
                max = max(TrainSet$Sepal.Width)),
    sliderInput("Petal.Length", label = "Comprimento da pétala", value = 1.4,
                min = min(TrainSet$Petal.Length),
                max = max(TrainSet$Petal.Length)),
    sliderInput("Petal.Width", label = "Largura da pétala", value = 0.2,
                min = min(TrainSet$Petal.Width),
                max = max(TrainSet$Petal.Width)),

    actionButton("submitbutton", "Entrada", class = "btn btn-primary")
  ),

  mainPanel(
    tags$label(h3('Resultado')),
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table

  )
)
