
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

#activetabs----
active_tabs <- list(
  mission1 = FALSE,
              m1_PI =  FALSE,
              m1_CHN = FALSE,
              m1_GC =  FALSE,
              m1_UR =  FALSE,
              m1_FE =  FALSE,
              m1_TS =  FALSE,
              m1_MI =  FALSE,
              m1_SB =  FALSE,
              m1_LE =  FALSE,
              m1_MH =  FALSE,
  mission2 = FALSE,
              m2_NBO = FALSE,
              m2_HA  = FALSE,
              m2_LMPR= FALSE,
              m2_OVC = FALSE,
              m2_GII = FALSE,
              m2_PRHC= FALSE,
  mission3 = FALSE,
  mission4 = FALSE,
  mission5 = TRUE,
              m5_CEG = TRUE,
              m5_GDPE = TRUE,
  mission6 = FALSE,
              m6_RnD = FALSE,
              m6_VAEX= FALSE,
              m6_nRinv= FALSE,
              m6_LP = FALSE,
              m6_EXP = FALSE
)

## load libraries ----
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyBS)

library(plotly)
library(leaflet)
library(sf)
library(gridExtra)
library(waffle)
library(ggplot2)
library(htmlwidgets)
library(ggrepel)


options(scipen = 999999999)  

source_exports <- "BC Stats"

source("Standard-Charts.R")


source("home-ui1.R")

source("mission1-charts.R")
source("mission1-ui.R")
source("mission1-server.R")
source("mission2-charts.R")
source("mission2-ui.R")
source("mission2-server.R")
source("mission5-charts.R")
source("mission5-ui.R")
source("mission5-server.R")

source("mission6-charts.R")
source("mission6-ui.R")
source("ui_m6_RnD.R")
source("mission6-server.R")
source("Executive_summaries.R")


# Loading data ----
canada_map <- load_canada_map()

# Mission 1 ----
if (active_tabs$mission1) {  
  df_m1_UR_1 <- load_m1_UR1()
  df_m1_UR_2 <- load_m1_UR2()
  df_m1_UR_3 <- load_m1_UR3()
  df_m1_UR_4 <- load_m1_UR4()
  df_m1_UR_5 <- load_m1_UR5()
  df_m1_PI_1 <- load_m1_PI1()
  df_m1_PI_2 <- load_m1_PI2()
  df_m1_CHN_1 <- load_m1_CHN1()
  df_m1_GC_1 <- load_m1_GC1()
  df_m1_FE_1 <- load_m1_FE1()
  df_m1_TS_1 <- load_m1_TS1()
  df_m1_MI_1 <- load_m1_MI1()
  df_m1_SB_1 <- load_m1_SB1()
  df_m1_LE_1 <- load_m1_LE1()
  df_m1_MH_1 <- load_m1_MH1()}

# Mission 2 ----
if (active_tabs$mission2) {  
  df_m2_NBO_1 <- load_m2_NBO1()
  df_m2_HA_1 <- load_m2_HA1()
  df_m2_LMPR_1 <- load_m2_LMPR1()
  df_m2_OVC_1 <- load_m2_OVC1()
  df_m2_PRHC_1 <- load_m2_PRHC1()
  df_m2_GII_1 <- load_m2_GII1()}

# Mission 5 ----
if (active_tabs$mission5) {  
  df_m5_CEG_1 <- load_m5_CEG1()
  df_m5_CEG_2 <- load_m5_CEG2()
  df_m5_CEG_3 <- load_m5_CEG3()
  df_m5_GDPE_1 <- load_m5_GDPE1()
}

  
if (active_tabs$mission6) {  
  df_m6_RnD_1 <- load_m6_RnD1()
  df_m6_RnD_2 <- load_m6_RnD2()
  df_m6_VAEX_1 <- load_m6_VAEX1()
  df_m6_nRinv_1 <- load_m6_nRinv1()
  df_m6_LP_1 <- load_m6_LP1()
  df_m6_EXP_1 <- load_m6_EXP1()
  df_m6_EXP_2 <- load_m6_EXP2()
  df_m6_EXP_3 <- load_m6_EXP3()
  df_m6_EXP_4 <- load_m6_EXP4()}

# # UI ----
ui <- function() {
  # Include CSS----
  header_content <- tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    tags$style(HTML("
    .navbar.navbar-default.navbar-static-top {
      position: fixed;
      top: 60px; /* Adjust the position to be 100px lower */
      width: 100%;
      z-index: 999; /* Ensure it stays on top */
    }
    
    body {
      padding-top: 160px; /* Adjust the body padding to avoid content being hidden under the navbar */
    }
  "))
  )
  
  
  
 
  
  # Custom header----
  custom_header <- tags$header(
    class = "header",
    style = "background-color:#003366; border-bottom:2px solid #fcba19;
             padding:0 0px 0 0px; display:flex; height:60px; width:100%; 
             justify-content:space-between; align-items:center;
             position:fixed; top:0; left:0; z-index:1000;",
    tags$div(
      class = "banner",
      style = "display:flex; justify-content:flex-start; align-items:center; margin: 0 10px 0 10px;",
      a(
        href = "https://www2.gov.bc.ca/gov/content/data/about-data-management/bc-stats",
        img(
          src = 'https://raw.githubusercontent.com/bcgov/BC-Economic-Development/main/bc_logo.svg',
          title = "StrongerBC",
          height = "30px",
          alt = "British Columbia - StrongerBC"
        )
      ),
      h1(
        "BC Economic Development Indicators",
        style = "font-weight:400; color:white; margin: 5px 5px 0 18px;"
      ),
      h2(
        "Work in progress, subject to change!",
        style = "font-size: 16px; color: white; margin: 0 5px 5px 18px;"
      )
    ),
    tags$div(
      style = "margin-right:10px;",
      a(
        href = "https://mehdinaji.shinyapps.io/BC-Economy-Snapshot/",
        class = "btn btn-primary",
        style = "color:white; background-color:#fcba19; border:none;",
        "BC Economy Snapshot"
      )
    )
  )
  
  # Custom footer----
  custom_footer <- column(
    width = 12,
    style = "background-color:#003366; border-top:2px solid #fcba19;",
    tags$footer(
      class = "footer",
      tags$div(
        class = "container",
        style = "display:flex; justify-content:center; flex-direction:column; text-align:center; height:46px;",
        tags$ul(
          style = "display:flex; flex-direction:row; flex-wrap:wrap; margin:0; list-style:none; align-items:center; height:100%;",
          tags$li(
            a(
              href = "https://www2.gov.bc.ca/gov/content/home",
              "Home",
              style = "font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;"
            )
          ),
          tags$li(
            a(
              href = "https://www2.gov.bc.ca/gov/content/home/disclaimer",
              "Disclaimer",
              style = "font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;"
            )
          )
        )
      )
    )
  )
  
  # scroll_buttons_script----
  scroll_buttons_script <- tags$head(
    tags$style(HTML("
    #go_to_main_chart, #go_to_deep_dive {
      outline: none;
      border: none;
    }
    #go_to_main_chart:focus, #go_to_deep_dive:focus {
      outline: none;
      border: none;
    }
  ")),
    tags$script(HTML("
    $(document).on('click', '#go_to_main_chart', function() {
      $('html, body').animate({scrollTop: 0}, 800); // Scroll to top
    });

    $(document).on('click', '#go_to_deep_dive', function() {
      $('html, body').animate({scrollTop: $(document).height()}, 800); // Scroll to bottom
    });
  "))
  )
  
  
  # Build the navbarPage----
  ui <- tagList(
    tags$style(HTML("
    .navbar-default {
      background-color: #3C8DBC; /* Background color */
      border-color: #3C8DBC; /* Border color */
    }
    .navbar-default .navbar-nav > li > a {
      color: #fff; /* Link color */
    }
    .navbar-default .navbar-brand {
      color: #fff; /* Brand text color */
    }
    .navbar-default .navbar-nav > li > a:hover {
      background-color: #fcba19; /* Hover color */
    }
  ")),
    header_content,
    custom_header,
    scroll_buttons_script,
    navbarPage(
      title = NULL,
      id = "tabs",
      # Home tab
      tabPanel("Home", ui_home()),
      # Mission 1
      if (active_tabs$mission1) {
        navbarMenu(
          "Mission 1",
          tabPanel(
            "Mission 1 Overview",
            ui_m1_home(
              m1_PI_lineplot_data(df_m1_PI_1),
              m1_CHN_lineplot_data(df_m1_CHN_1),
              m1_GC_lineplot_data(df_m1_GC_1),
              m1_UR_lineplot_data(df_m1_UR_1),
              m1_FE_lineplot_data(df_m1_FE_1),
              m1_TS_lineplot_data(df_m1_TS_1),
              m1_SB_lineplot_data(df_m1_SB_1),
              m1_LE_lineplot_data(df_m1_LE_1),
              m1_MH_lineplot_data(df_m1_MH_1)
            )
          ),
          if (active_tabs$m1_PI) {
            tabPanel("Poverty Incidence", ui_m1_PI(df1 = df_m1_PI_1, df2 = df_m1_PI_2))
          },
          if (active_tabs$m1_CHN) {
            tabPanel("Core Housing Need", ui_m1_CHN(df1 = df_m1_CHN_1))
          },
          if (active_tabs$m1_GC) {
            tabPanel("Gini Coefficient", ui_m1_GC(df1 = df_m1_GC_1))
          },
          if (active_tabs$m1_FE) {
            tabPanel("Food Expenditure", ui_m1_FE(df1 = df_m1_FE_1))
          },
          if (active_tabs$m1_TS) {
            tabPanel("Spending on Transportation", ui_m1_TS(df1 = df_m1_TS_1))
          },
          if (active_tabs$m1_SB) {
            tabPanel("Sense of Belongings", ui_m1_SB(df1 = df_m1_SB_1))
          },
          if (active_tabs$m1_LE) {
            tabPanel("Life Expectancy", ui_m1_LE(df1 = df_m1_LE_1))
          },
          if (active_tabs$m1_MH) {
            tabPanel("Mental Health", ui_m1_MH(df1 = df_m1_MH_1))
          }
        )
      },
      # Mission 2
      if (active_tabs$mission2) {
        navbarMenu(
          "Mission 2",
          tabPanel(
            "Mission 2 Overview",
            ui_m2_home(
              m2_NBO_lineplot_data(df_m2_NBO_1),
              m2_HA_lineplot_data(df_m2_HA_1),
              m2_LMPR_lineplot_data(df_m2_LMPR_1),
              m2_OVC_lineplot_data(df_m2_OVC_1),
              m2_GII_lineplot_data(df_m2_GII_1),
              m2_PRHC_lineplot_data(df_m2_PRHC_1)
            )
          ),
          if (active_tabs$m2_NBO) {
            tabPanel("New Business Openings", ui_m2_NBO(df_m2_NBO_1))
          },
          if (active_tabs$m2_HA) {
            tabPanel("Housing Availability", ui_m2_HA(df_m2_HA_1))
          },
          if (active_tabs$m2_LMPR) {
            tabPanel("Labour Market Participation Rate", ui_m2_LMPR(df_m2_LMPR_1))
          },
          if (active_tabs$m2_OVC) {
            tabPanel("Occurrences of Violent Crime", ui_m2_OVC(df_m2_OVC_1))
          },
          if (active_tabs$m2_GII) {
            tabPanel("Government Investment in Infrastructure", ui_m2_GII(df_m2_GII_1))
          },
          if (active_tabs$m2_PRHC) {
            tabPanel("Police-reported Hate Crime", ui_m2_PRHC(df_m2_PRHC_1))
          }
        )
      },
      # Mission 3
      if (active_tabs$mission3) {
        tabPanel("Mission 3", "Content for Mission 3")
      },
      # Mission 4
      if (active_tabs$mission4) {
        tabPanel("Mission 4", "Content for Mission 4")
      },
      # Mission 5
      if (active_tabs$mission5) {
        navbarMenu(
          "Mission 5",
          tabPanel(
            "Mission 5 Overview",
            ui_m5_home(
              m5_CEG_lineplot_data(df_m5_CEG_1),
              m5_GDPE_lineplot_data(df_m5_GDPE_1))
          ),
          if (active_tabs$m5_CEG) {
            tabPanel("\xE2\x96\xB6 Clean Energy Generated", ui_m5_CEG(df_m5_CEG_1,df_m5_CEG_2,df_m5_CEG_3 ))
          },
          if (active_tabs$m5_GDPE) {
            tabPanel("\xE2\x96\xB6 Real GDP per employed person", ui_m5_GDPE(df_m5_GDPE_1))
          }
        )
      },
      # Mission 6
      if (active_tabs$mission6) {
        navbarMenu(
          "Mission 6",
          tabPanel(
            "Mission 6 Overview",
            ui_m6_home(
              m6_RnD_lineplot_data(df_m6_RnD_1),
              m6_VAEX_lineplot_data(df_m6_VAEX_1),
              m6_nRinv_lineplot_data(df_m6_nRinv_1),
              m6_LP_lineplot_data(df_m6_LP_1),
              m6_EXP_lineplot_data(df_m6_EXP_1)
            )
          ),
          if (active_tabs$m6_RnD) {
            tabPanel("\xE2\x96\xB6 Private sector investment in innovation", ui_m6_RnD(df_m6_RnD_1, df_m6_RnD_2))
          },
          if (active_tabs$m6_VAEX) {
            tabPanel("\xE2\x96\xB6 Value-added in goods and services exports", ui_m6_VAEX(df_m6_VAEX_1))
          },
          if (active_tabs$m6_nRinv) {
            tabPanel("\xE2\x96\xB6 Investment in non-residential structures, machinery & equipment, and intellectual property products", ui_m6_nRinv(df_m6_nRinv_1))
          },
          if (active_tabs$m6_LP) {
            tabPanel("\xE2\x96\xB6 Labour Productivity", ui_m6_LP(df_m6_LP_1))
          },
          if (active_tabs$m6_EXP) {
            tabPanel("\xE2\x96\xB6 Exports share", ui_m6_EXP(df_m6_EXP_1, df_m6_EXP_3))
          }
        )
      },
      ),
    custom_footer
  )
  
  return(ui)
  
}



# Server----
server <- function(input, output, session) {
  
  ##HOMEPAGE----
  # observeEvent(input$RnD_mission6, {updateTabItems(session, "tabs", "m6_home")})
  # observeEvent(input$VAEX_mission6, {updateTabItems(session, "tabs", "m6_home")})
  # observeEvent(input$nRinv_mission6, {updateTabItems(session, "tabs", "m6_home")})
  # observeEvent(input$LP_mission6, {updateTabItems(session, "tabs", "m6_home")})
  # observeEvent(input$EXP_mission6, {updateTabItems(session, "tabs", "m6_home")})
  # 
  # observeEvent(input$PI_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$CHN_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$GC_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$UR_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$FE_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$TS_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$SB_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$LE_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$MI_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # observeEvent(input$MH_mission1, {updateTabItems(session, "tabs", "m1_home")})
  # 
  # observeEvent(input$NBO_mission2, {updateTabItems(session, "tabs", "m2_home")})
  # observeEvent(input$HA_mission2, {updateTabItems(session, "tabs", "m2_home")})
  # observeEvent(input$LMPR_mission2, {updateTabItems(session, "tabs", "m2_home")})
  # observeEvent(input$OVC_mission2, {updateTabItems(session, "tabs", "m2_home")})
  # observeEvent(input$GII_mission2, {updateTabItems(session, "tabs", "m2_home")})
  # observeEvent(input$PRHC_mission2, {updateTabItems(session, "tabs", "m2_home")})
  # 
  # observeEvent(input$RnD_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$VAEX_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$nRinv_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$LP_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$EXP_home, {updateTabItems(session, "tabs", "home")})
  # 
  # observeEvent(input$PI_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$CHN_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$GC_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$UR_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$FE_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$TS_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$SB_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$LE_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$MI_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$MH_home, {updateTabItems(session, "tabs", "home")})
  # 
  # observeEvent(input$NBO_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$HA_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$LMPR_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$OVC_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$GII_home, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$PRHC_home, {updateTabItems(session, "tabs", "home")})
  
  # observeEvent(input$m1_to_homepage, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$m2_to_homepage, {updateTabItems(session, "tabs", "home")})
  # observeEvent(input$m6_to_homepage, {updateTabItems(session, "tabs", "home")})
  
  
  observeEvent(input$button1, {
    updateTabItems(session, "tabs", selected = "m1_home")})
  observeEvent(input$button2, {
    updateTabItems(session, "tabs", selected = "m2_home")})
  observeEvent(input$button3, {
    updateTabItems(session, "tabs", selected = "mission3")})
  observeEvent(input$button4, {
    updateTabItems(session, "tabs", selected = "mission4")})
  observeEvent(input$button5, {
    updateTabItems(session, "tabs", selected = "mission5")})
  observeEvent(input$button6, {
    updateTabItems(session, "tabs", selected = "m6_home")})
  
  ##Mission1----

  if (active_tabs$mission1){
  
  observeEvent(input$m1_PI_Button, {
    updateTabItems(session, "tabs", selected = "PI")})
  observeEvent(input$m1_CHN_Button, {
    updateTabItems(session, "tabs", selected = "CHN")})
  observeEvent(input$m1_GC_Button, {
    updateTabItems(session, "tabs", selected = "GC")})
  observeEvent(input$m1_UR_Button, {
    updateTabItems(session, "tabs", selected = "UR")})
  observeEvent(input$m1_FE_Button, {
    updateTabItems(session, "tabs", selected = "FE")})
  observeEvent(input$m1_TS_Button, {
    updateTabItems(session, "tabs", selected = "TS")})
  observeEvent(input$m1_SB_Button, {
    updateTabItems(session, "tabs", selected = "SB")})
  observeEvent(input$m1_LE_Button, {
    updateTabItems(session, "tabs", selected = "LE")})
  observeEvent(input$m1_MH_Button, {
    updateTabItems(session, "tabs", selected = "MH")})
  server_m1_home(df_m1_PI_1, df_m1_CHN_1,df_m1_GC_1, 
                 df_m1_UR_1, df_m1_FE_1, df_m1_TS_1,
                 df_m1_SB_1, df_m1_LE_1, df_m1_MH_1,
                 output, input, session)
  mission1_PI_server(Exesum_m1_PI_main, Exesum_m1_PI, df1 = df_m1_PI_1, df2 = df_m1_PI_2, output, input)
  mission1_UR_server(Exesum_m1_UR_main, Exesum_m1_UR, df1 = df_m1_UR_1, df2 = df_m1_UR_2, df3 = df_m1_UR_3, df4 = df_m1_UR_4, df5 = df_m1_UR_5, output, input)
  mission1_CHN_server(Exesum_m1_CHN_main, Exesum_m1_CHN, df1 = df_m1_CHN_1, output, input)
  mission1_GC_server(Exesum_m1_GC_main, Exesum_m1_GC, df1 = df_m1_GC_1, output, input)
  mission1_FE_server(Exesum_m1_FE_main, Exesum_m1_FE, df1 = df_m1_FE_1, output, input)
  mission1_TS_server(Exesum_m1_TS_main, Exesum_m1_TS, df1 = df_m1_TS_1, output, input)
  mission1_MI_server(Exesum_m1_MI_main, Exesum_m1_MI, df1 = df_m1_MI_1, output, input)
  mission1_SB_server(Exesum_m1_SB_main, Exesum_m1_SB, df1 = df_m1_SB_1, output, input)
  mission1_LE_server(Exesum_m1_LE_main, Exesum_m1_LE, df1 = df_m1_LE_1, output, input)
  mission1_MH_server(Exesum_m1_MH_main, Exesum_m1_MH, df1 = df_m1_MH_1, output, input)
}
  
  if (active_tabs$mission2){
    
  observeEvent(input$m2_NBO_Button, {
    updateTabItems(session, "tabs", selected = "NBO")})
  observeEvent(input$m2_HA_Button, {
    updateTabItems(session, "tabs", selected = "HA")})
  observeEvent(input$m2_LMPR_Button, {
    updateTabItems(session, "tabs", selected = "LMPR")})
  observeEvent(input$m2_OVC_Button, {
    updateTabItems(session, "tabs", selected = "OVC")})
  observeEvent(input$m2_PRHC_Button, {
    updateTabItems(session, "tabs", selected = "PRHC")})
  observeEvent(input$m2_GII_Button, {
    updateTabItems(session, "tabs", selected = "GII")})
  
  server_m2_home(df_m2_NBO_1, df_m2_HA_1, df_m2_LMPR_1, 
                 df_m2_OVC_1, df_m2_GII_1, df_m2_PRHC_1, 
                 output, input, session)
  mission2_NBO_server(Exesum_m2_NBO_main, Exesum_m2_NBO, df_m2_NBO_1, output, input)
  mission2_HA_server(Exesum_m2_HA_main, Exesum_m2_HA, df_m2_HA_1, output, input)
  mission2_LMPR_server(Exesum_m2_LMPR_main, Exesum_m2_LMPR, df_m2_LMPR_1, output, input)
  mission2_OVC_server(Exesum_m2_OVC_main, Exesum_m2_OVC, df_m2_OVC_1, output, input)
  mission2_PRHC_server(Exesum_m2_PRHC_main, Exesum_m2_PRHC, df_m2_PRHC_1, output, input)
  mission2_GII_server(Exesum_m2_GII_main, Exesum_m2_GII, df_m2_GII_1, output, input)}

  if (active_tabs$mission5){
  server_m5_home(df_m5_CEG_1, df_m5_GDPE_1, output, input, session)
  mission5_CEG_server(df_m5_CEG_1, df_m5_CEG_2, df_m5_CEG_3, output, input)
  mission5_GDPE_server(df_m5_GDPE_1, output, input)}

  if (active_tabs$mission6){
  observeEvent(input$m6_RnD_Button, {
    updateTabItems(session, "tabs", selected = "RnD")})
  observeEvent(input$m6_VAEX_Button, {
    updateTabItems(session, "tabs", selected = "VAEX")})
  observeEvent(input$m6_nRinv_Button, {
    updateTabItems(session, "tabs", selected = "nRinv")})
  observeEvent(input$m6_LP_Button, {
    updateTabItems(session, "tabs", selected = "LP")})
  observeEvent(input$m6_EXP_Button, {
    updateTabItems(session, "tabs", selected = "EXP")})
  
  server_m6_home(df_m6_RnD_1, df_m6_LP_1, df_m6_VAEX_1, df_m6_nRinv_1, df_m6_EXP_1, output, input, session)
  mission6_RnD_server( df_m6_RnD_1, df_m6_RnD_2, output, input)
  mission6_VAEX_server(df_m6_VAEX_1, output, input)
  mission6_nRinv_server(df_m6_nRinv_1, output, input)
  mission6_LP_server(df_m6_LP_1, output, input)
  mission6_EXP_server(df_m6_EXP_1, df_m6_EXP_2, df_m6_EXP_3, df_m6_EXP_4, output, input)

  
  
  
  
    }}



shinyApp(ui, server)
