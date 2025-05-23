library(shiny)
library(detourr)
library(crosstalk)


shared_iris <- SharedData$new(iris)

ui <- fluidPage(
  titlePanel("Iris Data: Grand Tour vs Little Tour"),
  fluidRow(
    column(
      6, 
      h3("Grand Tour"),
      displayScatter2dOutput("tour1")
    ),
    column(
      6, 
      h3("Little Tour"),
      displayScatter2dOutput("tour2")
    )
  )
)

server <- function(input, output) {
  output$tour1 <- shinyRenderDisplayScatter2d({
    detour(shared_iris, tour_aes(projection = -Species, colour = Species)) |>
      tour_path(grand_tour(2), fps = 60) |>  
      show_scatter(alpha = 0.8, axes = FALSE)
  })
  
  output$tour2 <- shinyRenderDisplayScatter2d({
    detour(shared_iris, tour_aes(projection = -Species, colour = Species)) |>
      tour_path(little_tour(2), fps = 60) |>  
      show_scatter(alpha = 0.8, axes = FALSE)
  })
}

shinyApp(ui = ui, server = server)
