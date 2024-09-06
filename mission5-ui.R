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


### CEG ----
ui_m5_CEG <- function(df1){
  tabItem(tabName = "CEG",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 5-1-1: Clean Energy Generated" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m5_CEG_lineplot")),
              column(1,downloadButton("m5_CEG_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m5_CEG"))
            )
          ),
          ##### Stack Bar Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 5-1-2: Hydro-electricity accounts for the majority of clean energy generated in B.C." ))
            ),
            fluidRow(
              column(9,plotlyOutput("m5_CEG_stackbar")),
              column(3,
                     selectInput("m5_CEG_stackbar_geo", "Region", choices = unique(df1$GEO), selected = "British Columbia"),
                     selectInput("m5_CEG_stackbar_class", "Class of electricity producer", choices = unique(df1$Class.of.electricity.producer),
                                 selected = "Total all classes of electricity producer"),
                     downloadButton("m5_CEG_stackbar_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
  )}

