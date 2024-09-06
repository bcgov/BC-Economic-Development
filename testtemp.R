# Copyright 2019 Province of British Columbia
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at 
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

library(shiny)
library(shinydashboard)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "Icon on Chart Example"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    # Link to the external CSS file
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    fluidRow(
      box(
        width = 12,
        div(
          class = "plot-container",
          div(
            class = "icon-container",
            icon("chart-bar", "fa-4x")
          ),
          plotlyOutput("plot")
        )
      )
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    plot_ly(
      data = mtcars,
      x = ~mpg,
      y = ~wt,
      type = 'scatter',
      mode = 'markers'
    )
  })
}

shinyApp(ui, server)
