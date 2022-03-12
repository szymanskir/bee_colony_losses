library(shiny)

ui <- fluidPage(

  wellPanel(
    h2("Sorting example"),
    sliderInput("size", "Data size", min = 5, max = 20, value = 10),
    div("Sorted sequence:"),
    verbatimTextOutput("sequence")
  )
)

server <- function(input, output, session) {

  data <- reactive({
    sort(seq_len(input$size))
  })
  output$sequence <- renderText({
    paste(data(), collapse = " ")
  })
}

shinyApp(ui, server)
