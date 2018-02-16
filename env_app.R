# shinyの環境について

library(shiny)

print("shiny.env：")
print(environment())
print("shiny.parent.env：")
print(parent.env(environment()))

shiny_x = 10

ui <- fluidPage(
  titlePanel("shinyの環境"),
  verbatimTextOutput("infoEnv") ,
  verbatimTextOutput("next_output") ,
  actionButton("btn1","btn1!!"),
  actionButton("btn2","btn2!!")
)

server <- function(input, output) {
  
  print("server.env : ")
  print(environment())
  print("server.parent.env : ")
  print(parent.env(environment()))
  
  
  server_x = 20
  
  output$infoEnv <- renderText({
    print("renderText.env : ")
    print(environment())
    print("renderTex.parent.env : ")
    print(parent.env(environment()))
    
    input$btn2
    print("btn2を押しました")
    print("btn1の情報 from infoEnv")
    print(input$btn1)
    
    print("ボタンの初期値は0？")
    print(input$btn1==0)
    print(str(input$btn1))
    
    if(input$btn1 >= 1){
      if (input$btn1%%2 == 0) {
        assign("server_x", 50 , env = parent.env(environment()))
        assign("shiny_x", 15 , env = parent.env(parent.env(environment())))
      } else if (input$btn1%%2 == 1) {
        assign("server_x", 60 , env = parent.env(environment()))
        assign("shiny_x", 25 , env = parent.env(parent.env(environment())))
      }
    }
    
    text = "環境のテスト"
    paste("server_x : ",server_x)
    paste("shiny_x : ",shiny_x," , server_x : ",server_x)
  })
  
  output$next_output <- renderText({
    print("next_output.env : ")
    print(environment())
    temp_env = environment()
    assign("temp_env", temp_env , env = parent.env(environment()))
    
    input$btn1
    print("btn1の情報")
    print(input$btn1)
    print(str(input$btn1))
    print(length(input$btn1))
    print(input$btn1[1])
    
    paste("shiny_x : ",shiny_x)
    paste("server_x : ",server_x)
  })
  
  
}

shinyApp(ui = ui, server = server)

