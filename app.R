#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
system("Xvfb :0 -ac -screen 0 1960x2000x24 &")
Sys.setenv("DISPLAY"=":0")
library(shiny)
library(shinydashboard)

valueBoxOutputMain <- function(outputId, width){
    
    valueBoxOutput(outputId = outputId, width = 3)
    }

# Define UI for application that draws a histogram
ui <- dashboardPage(
    
    
    dashboardHeader(title = "Realth",
                    
                    tags$li(class = "dropdown", actionButton(inputId = "asdas", "Nova Medida",icon = icon("plus")))
                    ),
    dashboardSidebar(sidebarMenu(
        menuItem(
            text="Dashboard",
            tabName="menu_1",
            icon=icon("heartbeat")),
        menuItem(
            text="About",
            tabName="menu_2",
            icon=icon("book")),
        
        tags$footer(
            fluidRow(a(icon("github", "fa-2x"), href="http://github.com/adelmofilho"),
                     br(),br(),
                     textOutput("update"),
                     align = "center"), 
                     align = "center", 
                     style = "
                       position:absolute;
                       bottom:0;
                       width:100%;
                       height:100px;
                       color: white;
                       padding: 10px;
                       background-color: black;
                       z-index: 1000;")
            
    )),
    
    dashboardBody(
        
        fluidRow(
            
            valueBoxOutputMain("weight_box"),
            valueBoxOutputMain("pressure_box"),
            valueBoxOutputMain("ac_box"),
            valueBoxOutputMain("sugar_box")
        ),
        
        fluidRow(

        ),
        
        
        fluidRow(
            # box(title = "Massa Corpórea (kg)",
            #     status = "primary",
            #     solidHeader = TRUE,
            #     footer = paste("Atualizado em", Sys.time()),
            #     plotOutput("plot1",height = "50vh")),
            uiOutput("visual_box"),
            box(title = "Configurações",
                width = 6,
                status = "primary",
                solidHeader = TRUE,
                
                selectInput(inputId = "medida",
                            label = "Medida", 
                            choices = c("Weight", "Blood Presure", "Abdominal circumference", "Blood sugar")),
                       selectInput(inputId = "tipo",
                                   label = "Tipo", 
                                   choices = c("Histórico", "Histograma", "Boxplot")),

                       dateRangeInput(inputId = "tempo",
                                      label = "Tempo"),

                       selectInput(inputId = "tipo3",
                                   label = "Tipo", 
                                   choices = c("Recente", "Histórico", "Histograma")))
                    
                    
                
            )
        ),
        
        
        
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "main.css"))
        
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    
    weight <- reactive({
        
        88
    })
    
    output$update <- renderText({
        
        
        
       paste("Atualizado em", Sys.time())
    })
    
    output$visual_box <- renderUI({
        
        box(title = input$medida,
            status = "primary",
            solidHeader = TRUE,
            plotOutput("plot1",height = "50vh"))
        
    })
    
    output$weight_box <- renderValueBox({
        
            valueBox(value = paste(weight(), "kg"),
                     subtitle = "Weight",
                     color = "purple",
                     icon = icon("balance-scale"),
                     width = 3)
                     
    })
    
    output$pressure_box <- renderValueBox({
        
        valueBox(paste0("124", "/", "88", " mmHg"),
                 subtitle = "Blood Presure",
                 color = "red",
                 icon = icon("heartbeat"),
                 width = 3)
        
    })
    
    output$ac_box <- renderValueBox({
        
        valueBox(value = paste("102", "cm"),
                 subtitle = "Abdominal circumference",
                 color = "blue",
                 icon = icon("circle-o-notch"),
                 width = 3)
        
    })
    
    output$sugar_box <- renderValueBox({
        
        valueBox(value = paste("91", "mg/dL"),
                 subtitle = "Blood sugar",
                 color = "green",
                 icon = icon("hand-o-up"),
                 width = 3)
        
    })

    output$plot1 <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = 30 + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'black', border = 'white', main = NULL)
    })
}

# Run the application 
#shinyApp(ui = ui, server = server,options = list(port = "5700"))
options(shiny.host = "0.0.0.0")
options(shiny.port = 5700)
shinyApp(ui = ui, server = server)
