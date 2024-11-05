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
ui_m6_home <- function(df_m6_RnD_1, df_m6_VAEX_1, df_m6_nRinv_1, df_m6_LP_1, df_m6_EXP_1){
  tabItem(tabName = "m6_home",
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
              actionButton("m6_to_homepage", label = "Fostering Innovation Across the Economy", class = "main-title")
            ),
            div(style = "height: 10px;"),  # Space between title and first row of boxes
            fluidRow(
              wormchart_ui(df = df_m6_RnD_1, 
                           button = "m6_homepage_button_RnD",
                           title = "Private Sector Investment in Innovation",
                           worm = "m6_homepage_worm_RnD",
                           triangle = "m6_homepage_triangle_RnD"),
              
              wormchart_ui(df = df_m6_LP_1, 
                           button = "m6_homepage_button_LP",
                           title = "Labour Productivity",
                           worm = "m6_homepage_worm_LP",
                           triangle = "m6_homepage_triangle_LP"),
              
              wormchart_ui(df = df_m6_VAEX_1, 
                           button = "m6_homepage_button_VAEX",
                           title = "Value-Added Goods and Services Exports",
                           worm = "m6_homepage_worm_VAEX",
                           triangle = "m6_homepage_triangle_VAEX"),
            ),
            div(style = "height: 20px;"),  # Space between first and second rows of boxes
            fluidRow(
              wormchart_ui(df = df_m6_nRinv_1, 
                           button = "m6_homepage_button_nRinv",
                           title = "Non-residential Investments",
                           worm = "m6_homepage_worm_nRinv",
                           triangle = "m6_homepage_triangle_nRinv"),
              
              wormchart_ui(df = df_m6_EXP_1,
                           button = "m6_homepage_button_EXP",
                           title = "Exports Share",
                           worm = "m6_homepage_worm_EXP",
                           triangle = "m6_homepage_triangle_EXP"),
            )
          ))}



### RnD ----
ui_m6_RnD_feature_sankey <- function(chart, df1){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_sankey_geo", "", choices = unique(df1$GEO), selected = "British Columbia"))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_sankey_science_type", "", choices = unique(df1$Science.type)))), 
                  column(2, div(class = "upward-dropdown", selectInput("m6_RnD_sankey_year", "", choices = unique(df1$Year), selected = 2021 ))),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_RnD_sankey_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_RnD_feature_table <- function(chart, df1){
  column(9,
         DT::dataTableOutput(chart ,height = "calc(100vh - 460px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_table_funder", "Funder", choices = unique(df1$Funder) ))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_table_science_type", "", choices = unique(df1$Science.type)))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_table_prices", "",choices = unique(df1$Prices)))),
                  ),
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_table_performer", "Performer", choices = unique(df1$Performer) ))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_table_year", "Year", choices = unique(df1$Year), selected = 2020 ))),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_RnD_table_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_RnD_feature_map <- function(chart, df2){
  column(9,
         leafletOutput(chart ,height = "calc(100vh - 460px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_RnD_map_year", "Year", choices = unique(df2$Year), selected = 2020 ))),
                  column(4), 
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_RnD_map_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}

ui_m6_RnD_feature_barplot <- function(chart, df2){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(3, div(class = "upward-dropdown", selectInput("m6_RnD_barplot_year", "", choices = unique(df2$Year), selected = 2020))),
                  column(7),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_RnD_barplot_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_RnD <- function(df1, df2) {
  tabItem(tabName = "RnD",
          ui_main_chart(title = "Private sector investment in innovation",
                        chart_name = "m6_RnD_lineplot",
                        button_name = "m6_RnD_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_RnD_main"),
          fluidRow(
            h3("R&D Deep-dive", style = "text-align: center;"),
            
            tabsetPanel(
              tabPanel("Funding flows",
                       feature_tab(df1,
                                   tab_name = "Funding flows",
                                   title = "Research and Develoment funding flows",
                                   tab_feature_chart = ui_m6_RnD_feature_sankey,
                                   chart = "m6_RnD_sankey",
                                   summary = "Exesum_m6_RnD_flows")
              ),
              tabPanel("table",
                       feature_tab(df1,
                                   tab_name = "table",
                                   title = "Research and Development Spending Growth",
                                   tab_feature_chart = ui_m6_RnD_feature_table,
                                   chart = "m6_RnD_table",
                                   summary = "Exesum_m6_RnD_table")
              ),
              tabPanel("R&D by jurisdiction",
                       feature_tab(df2,
                                   tab_name = "R&D by jurisdiction",
                                   title = "Research and Development Spending Growth",
                                   tab_feature_chart = ui_m6_RnD_feature_map,
                                   chart = "m6_RnD_map",
                                   summary = "Exesum_m6_RnD_jurisdictions")
              ),
              tabPanel("barplot",
                       feature_tab(df2,
                                   tab_name = "barplot",
                                   title = "R&D intensity",
                                   tab_feature_chart = ui_m6_RnD_feature_barplot,
                                   chart = "m6_RnD_barplot",
                                   summary = "Exesum_m6_RnD_barplot")
              )
            )
          ),
          
          # Scroll buttons for navigation
          tags$script(HTML("
            $(document).on('click', '#go_to_main_chart', function() {
              $('html, body').animate({scrollTop: $('.scroll-section:eq(0)').offset().top}, 800);
            });

            $(document).on('click', '#go_to_deep_dive', function() {
              $('html, body').animate({scrollTop: $(document).height()}, 800);
            });
          "))
  )
}


#### VAEX----
ui_m6_VAEX_feature_pie <- function(chart, df){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_VAEX_pie_geo", "", choices = unique(df$GEO), selected = "British Columbia"))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_VAEX_pie_year", "", choices = unique(df$Year), selected = 2019 ))),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_VAEX_pie_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_VAEX_feature_barplot <- function(chart, df){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_VAEX_barplot_year", "", choices = unique(df$Year), selected = 2019))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_VAEX_barplot_industry", "", choices = unique(df$Industry), selected = "Total industries" ))),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_VAEX_barplot_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_VAEX <- function(df) {
  tabItem(tabName = "VAEX",
          ui_main_chart(title = "Value-added in goods and services exports",
                        chart_name = "m6_VAEX_lineplot",
                        button_name = "m6_VAEX_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_VAEX_main"),
          fluidRow(
            h3("Value-added exports Deep-dive", style = "text-align: center;"),
            
            tabsetPanel(
              tabPanel("Pie",
                       feature_tab(df,
                                   tab_name = "pie",
                                   title = "Value-added exports GDP contribution",
                                   tab_feature_chart = ui_m6_VAEX_feature_pie,
                                   chart = "m6_VAEX_pie",
                                   summary = "Exesum_m6_VAEX_pie")
              ),
              tabPanel("barplot",
                       feature_tab(df,
                                   tab_name = "barplot",
                                   title = "Value-added exports by industry in B.C.",
                                   tab_feature_chart = ui_m6_VAEX_feature_barplot,
                                   chart = "m6_VAEX_barplot",
                                   summary = "Exesum_m6_VAEX_barplot")
              )
            )
          ),
          
          # Scroll buttons for navigation
          tags$script(HTML("
            $(document).on('click', '#go_to_main_chart', function() {
              $('html, body').animate({scrollTop: $('.scroll-section:eq(0)').offset().top}, 800);
            });

            $(document).on('click', '#go_to_deep_dive', function() {
              $('html, body').animate({scrollTop: $(document).height()}, 800);
            });
          "))
  )
}

#### VAEX----
# ui_m6_VAEX <- function(df){
#   tabItem(tabName = "VAEX",
#           go_to_button("VAEX_mission6", "Mission 6","VAEX_home", "Home Page"),
#           
#           ##### Line Plot----
#           ui_main_chart(title = "Value-added in goods and services exports",
#                         chart_name = "m6_VAEX_lineplot",
#                         button_name = "m6_VAEX_lineplot_dwnbtt",
#                         source = "Statistics Canada, Table 36-10-0480-01",
#                         summary = "Exesum_m6_VAEX_main"),
#           ##### EXESUM ----
#           fluidPage(
#             style = "background-color: aliceblue ; margin: 20px;",
#             fluidRow(
#               column(12, h2("Executive Summary"))
#             ),
#             fluidRow(
#               column(12, uiOutput("Exesum_m6_VAEX"))
#             )
#           ),
#           ##### Pie Chart ----
#           fluidPage(
#             style = "background-color: white;margin: 20px;",
#             fluidRow(
#               column(9, h3("Figure 6-2-2: Value-added exports GDP contribution" ))
#             ),
#             fluidRow(
#               column(9,plotlyOutput("m6_VAEX_pie")),
#               column(3,
#                      selectInput("m6_VAEX_pie_geo", "Region", choices = unique(df$GEO), selected = "British Columbia"),
#                      selectInput("m6_VAEX_pie_year", "Year", choices = unique(df$Year), selected = 2019),
#                      downloadButton("m6_VAEX_pie_dwnbtt", "Download Filtered Data in CSV"))
#             )
#           ),
#           ##### Bar Plot ----
#           fluidPage(
#             style = "background-color: white;margin: 20px;",
#             fluidRow(
#               column(9, h3("Figure 6-2-3: Value-added exports by industry in B.C." ))
#             ),
#             fluidRow(
#               column(9,plotlyOutput("m6_VAEX_barplot")),
#               column(3,
#                      selectInput("m6_VAEX_barplot_year", "Year", choices = unique(df$Year), selected = 2019),
#                      selectInput("m6_VAEX_barplot_industry", "Industry", choices = unique(df$Industry), selected = "Total industries")
#               )
#             )
#           )
#   )}

#### Non residential investment ----
ui_m6_nRinv_feature_lines <- function(chart, df){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_nRinv_lines_geo", "", choices = unique(df$GEO), selected = "British Columbia"))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_nRinv_lines_prices", "", choices = unique(df$Prices)))),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_nRinv_lines_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_nRinv_feature_barplot <- function(chart, df){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_nRinv_barplot_year", "", choices = unique(df$Year), selected = 2019))),
                  column(4), 
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_nRinv_barplot_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_nRinv <- function(df) {
  tabItem(tabName = "nRinv",
          ui_main_chart(title = "Non-residential investment as a share of GDP",
                        chart_name = "m6_nRinv_lineplot",
                        button_name = "m6_nRinv_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_nRinv_main"),
          fluidRow(
            h3("Non-residential investment Deep-dive", style = "text-align: center;"),

            tabsetPanel(
              tabPanel("Capital Breakdown",
                       feature_tab(df,
                                   tab_name = "Capital Breakdown",
                                   title = "Gross fixed capital formation breakdown",
                                   tab_feature_chart = ui_m6_nRinv_feature_lines,
                                   chart = "m6_nRinv_lines",
                                   summary = "Exesum_m6_nRinv_lines")
              ),
              tabPanel("Jurisdictions",
                       feature_tab(df,
                                   tab_name = "Jurisdictions",
                                   title = "Non-residential investment breakdown by jurisdictions",
                                   tab_feature_chart = ui_m6_nRinv_feature_barplot,
                                   chart = "m6_nRinv_barplot",
                                   summary = "Exesum_m6_nRinv_barplot")
              )
            )
          ),

          # Scroll buttons for navigation
          tags$script(HTML("
            $(document).on('click', '#go_to_main_chart', function() {
              $('html, body').animate({scrollTop: $('.scroll-section:eq(0)').offset().top}, 800);
            });

            $(document).on('click', '#go_to_deep_dive', function() {
              $('html, body').animate({scrollTop: $(document).height()}, 800);
            });
          "))
  )
}

#### Labour Productivity ----
ui_m6_LP_feature_lines <- function(chart, df){
  column(9,
         plotlyOutput(chart, height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_lines_geo", "", choices = unique(df$GEO), selected = "British Columbia"))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_lines_labourtype", "", choices = unique(df$measure), selected = "Labour productivity"))),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_LP_lines_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_LP_feature_growthsectors <- function(chart, df){
  column(9,
         plotlyOutput(chart , height = "calc(100vh - 420px)"),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(2, div(class = "upward-dropdown", selectInput("m6_LP_table_year", "", choices = unique(df$Year), selected = 2022))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_table_labourtype", "", choices = unique(df$measure), selected = "Labour productivity"))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_table_industry", "", choices = unique(df$Industry)))),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_LP_table_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
                    )
}
ui_m6_LP_feature_treemap <- function(chart, df){
  column(9,
         plotlyOutput(chart , height = "calc(100vh - 420px)"),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_treemap_geo", "", choices = unique(df$GEO), selected = "British Columbia"))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_treemap_year", "", choices = unique(df$Year), selected = 2022))),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_LP_treemap_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))))
  )
}
ui_m6_LP_feature_map <- function(chart, df){
  column(9,
         leafletOutput(chart , height = "calc(100vh - 420px)"),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_map_year", "", choices = unique(df$Year), selected = 2022))),
                  column(4, div(class = "upward-dropdown", selectInput("m6_LP_map_industry", "", choices = unique(df$Industry), selected = "All industries"))),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", 
                         downloadButton("m6_LP_map_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))))
  )
}
ui_m6_LP <- function(df) {
  tabItem(tabName = "LP",
          ui_main_chart(
            title = "Labour productivity",
            chart_name = "m6_LP_lineplot",
            button_name = "m6_LP_lineplot_dwnbtt",
            source = "Statistics Canada, Table 36-10-0480-01",
            summary = "Exesum_m6_LP_main"),

          # Replacing the navbarPage for deep dives with tabsetPanel
          fluidRow(
            h3("Labour Productivity Deep-dive", style = "text-align: center;"),  # Title for the tabsetPanel

            tabsetPanel(
              tabPanel("Growth by sector",
                       feature_tab(df,
                                   tab_name = "Growth by sector",
                                   title = "Labour productivity growth rate",
                                   tab_feature_chart = ui_m6_LP_feature_lines,
                                   chart = "m6_LP_lines",
                                   summary = "Exesum_m6_LP_growth")
              ),
              tabPanel("Growth by jurisdiction",
                       feature_tab(df,
                                   tab_name = "Growth by jurisdiction",
                                   title = "Labour productivity SECTOR growth rate",
                                   tab_feature_chart = ui_m6_LP_feature_growthsectors,
                                   chart = "m6_LP_growthsectors",
                                   summary = "Exesum_m6_LP_sectors")
              ),
              # tabPanel("TREEMAP",
              #          feature_tab(df,
              #                      tab_name = "TREEMAP",
              #                      title = "Labour productivity TREEMAP",
              #                      tab_feature_chart = ui_m6_LP_feature_treemap,
              #                      chart = "m6_LP_treemap",
              #                      summary = "Exesum_m6_LP_map")
              # )
              tabPanel("Productivity by jurisdiction",
                       feature_tab(df,
                                   tab_name = "Productivity by jurisdiction",
                                   title = "Labour productivity MAP",
                                   tab_feature_chart = ui_m6_LP_feature_map,
                                   chart = "m6_LP_map",
                                   summary = "Exesum_m6_LP_map")
              )
            )
          ),

          # Scroll buttons for navigation
          tags$script(HTML("
            $(document).on('click', '#go_to_main_chart', function() {
              $('html, body').animate({scrollTop: $('.scroll-section:eq(0)').offset().top}, 800);
            });

            $(document).on('click', '#go_to_deep_dive', function() {
              $('html, body').animate({scrollTop: $(document).height()}, 800);
            });
          "))
  )
}

#### EXP ----
ui_m6_EXP_feature_heatmap <- function(chart, df){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4),
                  column(4),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_EXP_heatmap_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_EXP_feature_stackbar <- function(chart, df){
  column(9,
         plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4, div(class = "upward-dropdown", selectInput("m6_EXP_stackbar_year", "", choices = unique(df$Year), selected = 2022))),
                  column(4),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_EXP_stackbar_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_EXP_feature_bubble <- function(chart, df){
  column(9,
         plotlyOutput(chart , height = "calc(100vh - 420px)" ),
         # Source
         fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
                  "Source: Statistics Canada, Table 36-10-0480-01"),
         # inputs
         fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
                  column(4),
                  column(4),
                  column(2),
                  column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_EXP_bubble_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
  )
}
ui_m6_EXP <- function(df1, df3) {
  tabItem(tabName = "EXP",
          ui_main_chart(title= "Exports as a share of total Canadian exports",
                        chart_name = "m6_EXP_lineplot",
                        button_name= "m6_EXP_lineplot_dwnbtt",
                        source= "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_EXP_main"),
          fluidRow(
            h3("Exports Deep-dive", style = "text-align: center;"),  
            
            tabsetPanel(
              tabPanel("Heatmap",
                       feature_tab(df3,
                                   tab_name = "Heatmap",
                                   title = "Exports as a share of total Canadian exports by commodity types",
                                   tab_feature_chart = ui_m6_EXP_feature_heatmap,
                                   chart = "m6_EXP_heatmap",
                                   summary = "Exesum_m6_EXP_heatmap")
              ),
              tabPanel("stackbar",
                       feature_tab(df3,
                                   tab_name = "stackbar",
                                   title = "Environmental and clean technology products exports",
                                   tab_feature_chart = ui_m6_EXP_feature_stackbar,
                                   chart = "m6_EXP_stackbar",
                                   summary = "Exesum_m6_EXP_stackbar")
              ),
              tabPanel("TREEMAP",
                       feature_tab(df3,
                                   tab_name = "bubble",
                                   title = "Exports by destinations",
                                   tab_feature_chart = ui_m6_EXP_feature_bubble,
                                   chart = "m6_EXP_bubble",
                                   summary = "Exesum_m6_EXP_bubble")
              )
            )
          ),
          
          # Scroll buttons for navigation
          tags$script(HTML("
            $(document).on('click', '#go_to_main_chart', function() {
              $('html, body').animate({scrollTop: $('.scroll-section:eq(0)').offset().top}, 800);
            });

            $(document).on('click', '#go_to_deep_dive', function() {
              $('html, body').animate({scrollTop: $(document).height()}, 800);
            });
          "))
  )
}



