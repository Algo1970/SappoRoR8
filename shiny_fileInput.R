

library(shiny)

ui <- fluidPage(
  fileInput("File",label = "File")
)
server <- function(input, output) {
  observeEvent(input$File, {
    print(str(input$File))
  }) 
}
shinyApp(ui = ui, server = server)