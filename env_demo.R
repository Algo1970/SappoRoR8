# env_demo

library(shiny)

# env_A
env_A = environment()
print("env_A is ")
print(env_A)

# parent
print("parent.env(env_A) is ")
print(parent.env(env_A))


ui <- fluidPage(
  verbatimTextOutput("infoEnv")
)

server <- function(input, output) {
  
  # env_B 
  env_B = environment()
  print("env_B is ")
  print(env_B)
  print("parent.env(env_B) is env_A")
  print(identical(parent.env(env_B), env_A))
  
  output$infoEnv <- renderText({
    
    # env_C 
    env_C = environment()
    print("env_C is ")
    print(env_C)
    print("parent.env(env_C) is env_B")
    print(identical(parent.env(env_C), env_B))
    
    'environment_test'
  })
  
}

shinyApp(ui = ui, server = server)