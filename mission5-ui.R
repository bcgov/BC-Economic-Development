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

### Home ----
ui_m5_home <- function(df_m5_CEG_1){
  tabItem(tabName = "m5_home",
          fluidPage(
            #CSS Code ----
            tags$head(
              tags$style(HTML("
      .main-title {
        font-weight: bold;
        color: black;
        font-size: 40px;
        text-align: center;
        padding:0px;
        margin-top: -30px;
        margin-bottom: 0px;
      }
      .custom-box {
        background-color: #f2f2f2;
        border-left: 16px solid #FEB70D;
        padding: 10px;
        margin-bottom: 20px; /* Space between rows of boxes */
        height: 220px; /* Increased height to accommodate labels */
        position: relative; /* Positioning context for absolute positioning */
      }
      .custom-title {
        font-weight: bold;
        text-align: center;
        margin-top:0px;
        margin-bottom: 30px; /* Space below the title */
        cursor: pointer; /* Change cursor to pointer on hover */
        color: black; 
        text-decoration: none; /* Remove default underline */
        line-height: 1.5;
        word-wrap: break-word; /* Ensure title is responsive and wraps */
      }
      .custom-title:hover {
        text-decoration: underline; /* Underline on hover */
      }
      .indicator-content {
        display: flex;
        flex-direction: row; /* Align items in a row */
        align-items: center; /* Align items in the center vertically */
        justify-content: flex-start; /* Align items to the left */
        height: 100%; /* Occupy full height */
        position: relative; /* Positioning context for absolute positioning */
        bottom:50px;
        left:25px;
      }
      .trend-triangle {
        width: 15px; /* Smaller width for the triangle */
        height: 15px; /* Smaller height for the triangle */
        border-left: 10px solid transparent;
        border-right: 10px solid transparent;
        margin-left: 5px; /* Space to the left of the triangle */
        position: absolute; /* Positioning context within .indicator-content */
        top: 35%; /* Adjust vertical position to center */
        transform: translateY(-50%); /* Center vertically */
        right: 35px; /* Adjust right position */
      }
      .green-triangle {
        border-bottom: 15px solid #4EA72E; /* Green color for upward trend */
      }
      .yellow-triangle {
        right:30px;
        border-left: 15px solid #FEB70D; /* Yellow color for neutral trend */
        border-top: 10px solid transparent;
        border-bottom: 10px solid transparent;
      }
      .red-triangle {
        border-top: 15px solid #E97132; /* Red color for downward trend */
      }
      .year-label {
        font-weight: bold;
        font-size: 18px; /* Larger font size for the year */
        position: absolute; /* Positioning context within .indicator-content */
        top: 35%; /* Adjust vertical position to center */
        transform: translateY(-50%); /* Center vertically */
        right: 60px; /* Adjust right position */
      }
      .plot-container {
        width: 90%; /* Adjust width of plot container */
        position: relative; /* Ensure position is relative for child elements */
      }
      .action-button {
        border: none; /* Remove border */
        background: none; /* No background color */
        width: 100%; /* Full width */
        padding: 0; /* Remove padding */
      }
      .action-button:hover {
        background: none; /* No background color on hover */
      }
    "))
            ),
            #----
            div(
              actionButton("m5_to_homepage", label = "Leading on environmental and social responsibility", class = "main-title")
            ),
            div(style = "height: 10px;"),  # Space between title and first row of boxes
            fluidRow(
              wormchart_ui(df = df_m5_CEG_1, 
                           button = "m5_homepage_button_CEG",
                           title = "Clean energy generated",
                           worm = "m5_homepage_worm_CEG",
                           triangle = "m5_homepage_triangle_CEG")
            ),
            div(style = "height: 20px;"),  # Space between first and second rows of boxes
            fluidRow(
             )
          ))}



### CEG ----
ui_m5_CEG_feature_sources <- function(chart, df1){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m5_CEG_sources_geo", "", choices = unique(df1$GEO), selected = "British Columbia"))), 
                  column(6),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", 
                         downloadButton("m5_CEG_sources_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m5_CEG_feature_map <- function(chart, df1){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m5_CEG_map_year", "", choices = unique(df1$Year), selected = 2023))), 
                  column(6),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", 
                         downloadButton("m5_CEG_map_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m5_CEG_feature_EGC <- function(chart, df2){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m5_CEG_EGC_geo", "", choices = unique(df2$GEO), selected = "British Columbia"))), 
                  column(6),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", 
                         downloadButton("m5_CEG_EGC_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}

ui_m5_CEG <- function(df1) {
  tabItem(tabName = "CEG",
          ui_main_chart(title = "Clean energy generated",
                        chart_name = "m5_CEG_lineplot",
                        button_name = "m5_CEG_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m5_CEG_main"),
          fluidRow(
            h3("R&D Deep-dive", style = "text-align: center;"),
            
            tabsetPanel(
              tabPanel("Clean energy sources",
                       feature_tab(df1,
                                   tab_name = "sources",
                                   title = "Clean energy sources",
                                   tab_feature_chart = ui_m5_CEG_feature_sources,
                                   chart = "m5_CEG_sources",
                                   summary = "Exesum_m5_CEG_sources")
              ),
              tabPanel("Electricity generated from clean sources in Canada",
                       feature_tab(df1,
                                   tab_name = "map",
                                   title = "Electricity generated from clean sources in Canada",
                                   tab_feature_chart = ui_m5_CEG_feature_map,
                                   chart = "m5_CEG_map",
                                   summary = "Exesum_m5_CEG_map"
                                   )
              ),
              tabPanel("Electricity generation and consumption ",
                       feature_tab(df1,
                                   tab_name = "EGC",
                                   title = "Electricity generation and consumption",
                                   tab_feature_chart = ui_m5_CEG_feature_EGC,
                                   chart = "m5_CEG_EGC",
                                   summary = "Exesum_m5_CEG_EGC"
                       )
              )
            )
          )
  )
}




### CEG ----
# ui_m5_CEG <- function(df1){
#   tabItem(tabName = "CEG",
#           ##### Line Plot----
#           fluidPage(
#             style = "background-color: white;margin: 20px;",
#             fluidRow(
#               column(9, h3("Figure 5-1-1: Clean Energy Generated" ))
#             ),
#             fluidRow(
#               column(1),
#               column(10,plotlyOutput("m5_CEG_lineplot")),
#               column(1,downloadButton("m5_CEG_lineplot_dwnbtt", ""))
#             )
#           ),
#           ##### EXESUM ----
#           fluidPage(
#             style = "background-color: aliceblue ; margin: 20px;",
#             fluidRow(
#               column(12, h2("Executive Summary"))
#             ),
#             fluidRow(
#               column(12, uiOutput("exesum_m5_CEG"))
#             )
#           ),
#           ##### Stack Bar Plot----
#           fluidPage(
#             style = "background-color: white;margin: 20px;",
#             fluidRow(
#               column(9, h3("Figure 5-1-2: Hydro-electricity accounts for the majority of clean energy generated in B.C." ))
#             ),
#             fluidRow(
#               column(9,plotlyOutput("m5_CEG_stackbar")),
#               column(3,
#                      selectInput("m5_CEG_stackbar_geo", "Region", choices = unique(df1$GEO), selected = "British Columbia"),
#                      selectInput("m5_CEG_stackbar_class", "Class of electricity producer", choices = unique(df1$Class.of.electricity.producer),
#                                  selected = "Total all classes of electricity producer"),
#                      downloadButton("m5_CEG_stackbar_dwnbtt", "Download Filtered Data in CSV"))
#             )
#           ),
#           
#   )}

