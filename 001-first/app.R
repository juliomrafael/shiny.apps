####################################
# Júlio Rafael                    #
# http://github.com/juliomrafal   #
####################################

# Modificado a partir de Winston Chang e Data Professor
# https://shiny.rstudio.com/gallery/shiny-theme-selector.html
# https://github.com/dataprofessor

# Conceitos sobre Programação Reactiva usando Shiny, 
# https://shiny.rstudio.com/articles/reactivity-overview.html

# Carregando pacotes
library(shiny)
library(shinythemes)


# Definindo a UI
ui <- fluidPage(theme = shinytheme("cerulean"),
                navbarPage(
                  # theme = "cerulean",  # <--- To use a theme, uncomment this
                  "Minha primeira app",
                  tabPanel("Menu 1",
                           sidebarPanel(
                             tags$h3("Entrada:"),
                             textInput("txt1", "Nome:", ""),
                             textInput("txt2", "Apelido:", ""),
                             
                           ), # painel da sidebar
                           mainPanel(
                             h1("Cabeçalho 1"),
                             
                             h4("Output 1"),
                             verbatimTextOutput("txtout"),
                             
                           ) # painel Principal
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Menu 2", "Este painel está em branco"),
                  tabPanel("Menu 3", "Este painel está igualmente em branco")
                  
                ) # Página de navegacao
) # fluidPage


# Função de navegação 
server <- function(input, output) {
  
  output$txtout <- renderText({
    paste( input$txt1, input$txt2, sep = " " )
  })
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)