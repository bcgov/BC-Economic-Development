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
ui_m1_home <- function(df_m1_PI_1, df_m1_CHN_1,df_m1_GC_1, 
                       df_m1_UR_1, df_m1_FE_1, df_m1_TS_1,
                       df_m1_SB_1, df_m1_LE_1, df_m1_MH_1){
  tabItem(tabName = "m1_home",
          fluidPage(
            #CSS Code ----
            tags$head(
              tags$style(HTML("
      .main-title {
        font-weight: bold;
        color: black;
        font-size: 40px;
        text-align: center;
        margin-top: 20px;
        margin-bottom: 20px;
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
              actionButton("m1_to_homepage", label = "Supporting People Families", class = "main-title")),
            div(style = "height: 20px;"),  # Space between title and first row of boxes
            fluidRow(
              wormchart_ui(df = df_m1_PI_1, 
                           button = "m1_homepage_button_PI",
                           title = "Poverty Incidence",
                           worm = "m1_homepage_worm_PI",
                           triangle = "m1_homepage_triangle_PI"),
              
              wormchart_ui(df = df_m1_CHN_1, 
                           button = "m1_homepage_button_CHN",
                           title = "Core Housing Needs",
                           worm = "m1_homepage_worm_CHN",
                           triangle = "m1_homepage_triangle_CHN"),
              
              wormchart_ui(df = df_m1_GC_1, 
                           button = "m1_homepage_button_GC",
                           title = "Gini Coefficient",
                           worm = "m1_homepage_worm_GC",
                           triangle = "m1_homepage_triangle_GC"),
            ),
            div(style = "height: 20px;"),  # Space between first and second rows of boxes
            fluidRow(
              wormchart_ui(df = df_m1_UR_1, 
                           button = "m1_homepage_button_UR",
                           title = "Underemployment Rate",
                           worm = "m1_homepage_worm_UR",
                           triangle = "m1_homepage_triangle_UR"),
              
              wormchart_ui(df = df_m1_FE_1, 
                           button = "m1_homepage_button_FE",
                           title = "Food Expenditure",
                           worm = "m1_homepage_worm_FE",
                           triangle = "m1_homepage_triangle_FE"),
              
              wormchart_ui(df = df_m1_TS_1, 
                           button = "m1_homepage_button_TS",
                           title = "Spending on Transportation",
                           worm = "m1_homepage_worm_TS",
                           triangle = "m1_homepage_triangle_TS"),
            ),
            div(style = "height: 20px;"),  
            fluidRow(
              wormchart_ui(df = df_m1_SB_1, 
                           button = "m1_homepage_button_SB",
                           title = "Sense of Belongings",
                           worm = "m1_homepage_worm_SB",
                           triangle = "m1_homepage_triangle_SB"),
              
              wormchart_ui(df = df_m1_LE_1, 
                           button = "m1_homepage_button_LE",
                           title = "Life Expectancy",
                           worm = "m1_homepage_worm_LE",
                           triangle = "m1_homepage_triangle_LE"),
              
              wormchart_ui(df = df_m1_MH_1, 
                           button = "m1_homepage_button_MH",
                           title = "Mental Health",
                           worm = "m1_homepage_worm_MH",
                           triangle = "m1_homepage_triangle_MH"),
            )
          ))}



### PI: Povery Incidence ----
# ui_m1_PI_feature_GB <- function(chart, df2){
#   column(9,
#          plotlyOutput(chart ,height = "calc(100vh - 420px)" ),
#          # Source
#          fluidRow(style = "background-color: #f2f2f2; padding-left: 80px; padding-right: 40px; margin-right: 0px; margin-left: 0px; margin-buttom: 0px; height: 12px; font-size: 12px;", 
#                   "Source: Statistics Canada, Table 36-10-0480-01"),
#          # inputs
#          fluidRow(style = "background-color: #f2f2f2;margin-right: 0px; margin-left: 0px;margin-top: 0px; margin-left: 0px;",
#                   column(4, div(class = "upward-dropdown", selectInput("m1_PI_GB_geo", "", choices = unique(df2$GEO), selected = "British Columbia"))),
#                   column(3, div(class = "upward-dropdown", selectInput("m1_PI_GB_year", "", choices = unique(df2$Year), selected = 2021))),
#                   column(3),
#                   column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m1_PI_GB_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
#   )
# }
# ui_m1_PI <- function(df1, df2) {
#   tabItem(tabName = "PI",
#           ui_main_chart(title = "Poverty Incidence", 
#                         chart_name = "m1_PI_lineplot", 
#                         button_name = "m1_PI_lineplot_dwnbtt", 
#                         source = "Statistics Canada, Table 36-10-0480-01", 
#                         summary = "Exesum_m1_PI_main"),
#           fluidRow(
#             h3("Poverty Incidence Deep-dive", style = "text-align: center;"),
#             
#             tabsetPanel(
#               tabPanel("Gender Bias",
#                        feature_tab(df1,
#                                    tab_name = "Gender Bias",
#                                    title = "Poverty Incidence Gender Bias",
#                                    tab_feature_chart = ui_m1_PI_feature_GB,
#                                    chart = "m1_PI_GB")
#               )
#             )
#           ),
#           
#           # Scroll buttons for navigation
#           tags$script(HTML("
#             $(document).on('click', '#go_to_main_chart', function() {
#               $('html, body').animate({scrollTop: $('.scroll-section:eq(0)').offset().top}, 800);
#             });
# 
#             $(document).on('click', '#go_to_deep_dive', function() {
#               $('html, body').animate({scrollTop: $(document).height()}, 800);
#             });
#           "))
#   )
# }




ui_m1_PI <- function(df1, df2){
  tabItem(tabName = "PI",
          go_to_button("PI_mission1", "Mission 1", "PI_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Poverty Incidence",
                        chart_name = "m1_PI_lineplot",
                        button_name = "m1_PI_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m1_PI_main"),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m1_PI"))
            )
          ),
          ##### Gender Bias----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-2-2: Poverty Incidence - Gender Bias" ))
            ),
            fluidRow(
              column(9,plotOutput("m1_PI_GB")),
              column(3,
                     selectInput("m1_PI_GB_geo", "Region", choices = unique(df2$GEO), selected = "British Columbia"),
                     selectInput("m1_PI_GB_year", "Year", choices = unique(df2$Year), selected = 2021),
                     downloadButton("m1_PI_GB_dwnbtt", "Download Filtered Data in CSV"))
            )
          )

  )}

### CHN: Core Housing Needs ----

# ui_m1_CHN <- function(df1, df2) {
#   tabItem(tabName = "PI",
#           ui_main_chart(title = "Poverty Incidence", 
#                         chart_name = "m1_PI_lineplot", 
#                         button_name = "m1_PI_lineplot_dwnbtt", 
#                         source = "Statistics Canada, Table 36-10-0480-01", 
#                         summary = "Exesum_m1_PI_main"),
#           fluidRow(
#             h3("Poverty Incidence Deep-dive", style = "text-align: center;"),
#             
#             tabsetPanel(
#               tabPanel("Gender Bias",
#                        feature_tab(df2,
#                                    tab_name = "Gender Bias",
#                                    title = "Poverty Incidence Gender Bias",
#                                    tab_feature_chart = ui_m1_PI_feature_GB,
#                                    chart = "m1_PI_GB")
#               )
#             )
#           ),
#           
#           # Scroll buttons for navigation
#           tags$script(HTML("
#             $(document).on('click', '#go_to_main_chart', function() {
#               $('html, body').animate({scrollTop: $('.scroll-section:eq(0)').offset().top}, 800);
#             });
# 
#             $(document).on('click', '#go_to_deep_dive', function() {
#               $('html, body').animate({scrollTop: $(document).height()}, 800);
#             });
#           "))
#   )
# }


ui_m1_CHN <- function(df1){
  tabItem(tabName = "CHN",
          go_to_button("CHN_mission1", "Mission 1", "CHN_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Core Housing Needs", 
                        chart_name = "m1_CHN_lineplot", 
                        button_name = "m1_CHN_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_CHN_main")
  )}
          
### GC: Gini Coefficient ----
ui_m1_GC <- function(df1){
  tabItem(tabName = "GC",
          go_to_button("GC_mission1", "Mission 1", "GC_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Gini Coefficient", 
                        chart_name = "m1_GC_lineplot", 
                        button_name = "m1_GC_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_GC_main"),
  )}

### UR: Underemploymnet Rate ----
ui_m1_UR <- function(df1, df2, df3, df4, df5){
  tabItem(tabName = "UR",
          go_to_button("UR_mission1", "Mission 1", "UR_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Underemployment Rate", 
                        chart_name = "m1_UR_lineplot", 
                        button_name = "m1_UR_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_UR_main"), 
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m1_UR"))
            )
          ),
          #### Waffle Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-1: Underemployment Rate" ))
            ),
            fluidRow(
              column(9,plotOutput("m1_UR_waffle")),
              column(3,
                     selectInput("m1_UR_waffle_year", "Year", choices = unique(df4$Year), selected = 2010),
                     selectInput("m1_UR_waffle_geo", "GEO", choices = unique(df4$GEO), selected = "British Columbia"),
                     downloadButton("m1_UR_waffle_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
          #### Treemap Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-3: Underemployment Rate" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m1_UR_treemap")),
              column(3,
                     selectInput("m1_UR_treemap_year", "Year", choices = unique(df3$Year), selected = 2010),
                     selectInput("m1_UR_treemap_geo", "GEO", choices = unique(df3$GEO), selected = "British Columbia"),
                     selectInput("m1_UR_treemap_character", "Labour Force Characterisitics", choices = unique(df3$Character), selected = "Employment"),
                     downloadButton("m1_UR_treemap_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
          #### Heatmap Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-4: Underemployment Rate" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m1_UR_heatmap")),
              column(3,
                     selectInput("m1_UR_heatmap_year", "Year", choices = unique(df5$Year), selected = 2010),
                     selectInput("m1_UR_heatmap_geo", "GEO", choices = unique(df5$GEO), selected = "British Columbia"),
                     selectInput("m1_UR_heatmap_character", "Labour Force Characterisitics", choices = unique(df5$Character), selected = "Employment"),
                     downloadButton("m1_UR_heatmap_dwnbtt", "Download Filtered Data in CSV"))
            )
          )
          
  )}


### FE: Food Expenditures ----
ui_m1_FE <- function(df1){
  tabItem(tabName = "FE",
          go_to_button("FE_mission1", "Mission 1", "FE_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Food Expenditures", 
                        chart_name = "m1_FE_lineplot", 
                        button_name = "m1_FE_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_FE_main"),
  )}

### TS: Transportation Spending ----
ui_m1_TS <- function(df1){
  tabItem(tabName = "TS",
          go_to_button("TS_mission1", "Mission 1", "TS_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Transportation Spending", 
                        chart_name = "m1_TS_lineplot", 
                        button_name = "m1_TS_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_TS_main"),
  )}
### SB: Sense of Belongings ----
ui_m1_SB <- function(df1){
  tabItem(tabName = "SB",
          go_to_button("SB_mission1", "Mission 1", "SB_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Sense of Belongings", 
                        chart_name = "m1_SB_lineplot", 
                        button_name = "m1_SB_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_SB_main"),
  )}
### LE: Life Expectancy ----
ui_m1_LE <- function(df1){
  tabItem(tabName = "LE",
          go_to_button("LE_mission1", "Mission 1", "LE_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Life Expectancy", 
                        chart_name = "m1_LE_lineplot", 
                        button_name = "m1_LE_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_LE_main"),
          
  )}
### MI: Median Income ----
ui_m1_MI <- function(df1){
  tabItem(tabName = "MI",
          go_to_button("MI_mission1", "Mission 1", "MI_home", "Home Page"),
          
          ##### Line Plot----
          ui_main_chart(title = "Median Income", 
                        chart_name = "m1_MI_lineplot", 
                        button_name = "m1_MI_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_MI_main"), 
          
  )}
### MH: Mental Health ----
ui_m1_MH <- function(df1){
  tabItem(tabName = "MH",
          go_to_button("MH_mission1", "Mission 1", "MH_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Mental Health", 
                        chart_name = "m1_MH_lineplot", 
                        button_name = "m1_MH_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m1_MH_main"),
          
  )}
