library(shiny)

source("EstimateLiverSteatosis_RefClass.R")
xario = Xario200$new()

ui <- fluidPage(
  textInput("tempId", label = "ID : "),
  actionButton("modify_id_btn", "modify ID")
)
server <- function(input, output) {
  observeEvent(input$modify_id_btn, {
    xario$id = input$tempId
  }) 
}
shinyApp(ui = ui, server = server)