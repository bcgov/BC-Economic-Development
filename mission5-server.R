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


# m5 Homepage----

server_m5_home <- function(df_m5_CEG_1, 
                           df_m5_GDPE_1,
                           output, input, session) {
  plot_and_triangle(df_m5_CEG_1, m5_CEG_lineplot_data, "m5_homepage_worm_CEG", "m5_homepage_button_CEG", "CEG", "m5_homepage_triangle_CEG", output, input, session)
  plot_and_triangle(df_m5_GDPE_1, m5_GDPE_lineplot_data, "m5_homepage_worm_GDPE", "m5_homepage_button_GDPE", "GDPE", "m5_homepage_triangle_GDPE", output, input, session)
  
}
## CEG----
mission5_CEG_server <- function(df_m5_CEG_1, df_m5_CEG_2,df_m5_CEG_3, output, input){
  ### Executive Summary----
  output$Exesum_m5_CEG_main <- renderUI(Exesum_m5_CEG_main)
  output$Exesum_m5_CEG_sources <- renderUI(Exesum_m5_CEG_sources)
  output$Exesum_m5_CEG_map <- renderUI(Exesum_m5_CEG_map)
  output$Exesum_m5_CEG_EGC <- renderUI(Exesum_m5_CEG_EGC)
  output$Exesum_m5_CEG_growth <- renderUI(Exesum_m5_CEG_growth)
  ### Line Plot----
  output$m5_CEG_lineplot <- renderPlotly({
    p1 <- m5_CEG_render_lineplot(df_m5_CEG_1, input)
    p1
  })
  
  output$m5_CEG_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m5_CEG_lineplot_data(df_m5_CEG_1)
      write.csv(df, file)
    }
  )
  
  ### Stacked Bar Plot----
  output$m5_CEG_sources <- renderPlotly({
    p1 <- m5_CEG_render_sources(df_m5_CEG_1, input)
    p1
  })
  
  output$m5_CEG_sources_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission5_CEGsources_filteredData.csv",
    content = function(file) {
      df <- m5_CEG_sources_data(df_m5_CEG_1, input$m5_CEG_sources_geo)
      write.csv(df, file)
    }
  )
  ### Map Plot----
  
  output$m5_CEG_map <- renderLeaflet({
    p1 <- m5_CEG_render_map(df_m5_CEG_1, input)
    p1
  })
  
  output$m5_CEG_map_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission5_CEGmap_filteredData.csv",
    content = function(file) {
      df <- m5_CEG_map_data(df_m5_CEG_1, input$m5_CEG_map_year)
      write.csv(df, file)
    }
  )
  
  ### EGC Plot----
  
  output$m5_CEG_EGC <- renderPlotly({
    p1 <- m5_CEG_render_EGC(df_m5_CEG_2, input)
    p1
  })
  
  output$m5_CEG_EGC_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission5_CEG_EGC_filteredData.csv",
    content = function(file) {
      df <- m5_CEG_EGC_data(df_m5_CEG_2, input$m5_CEG_EGC_geo)
      write.csv(df, file)
    }
  )
  
  ### growth Plot----
  
  output$m5_CEG_growth <- renderPlotly({
    p1 <- m5_CEG_render_growth(df_m5_CEG_3, input)
    p1
  })
  
  output$m5_CEG_growth_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission5_CEG_growth_filteredData.csv",
    content = function(file) {
      df <- m5_CEG_growth_data(df_m5_CEG_2, input$m5_CEG_growth_geo)
      write.csv(df, file)
    }
  )
}
  
  
## GDPE----
  mission5_GDPE_server <- function(df_m5_GDPE_1, output, input){
    ### Executive Summary----
    output$Exesum_m5_GDPE_main <- renderUI(Exesum_m5_GDPE_main)
    output$Exesum_m5_GDPE_bar <- renderUI(Exesum_m5_GDPE_bar)
    ### Line Plot----
    output$m5_GDPE_lineplot <- renderPlotly({
      p1 <- m5_GDPE_render_lineplot(df_m5_GDPE_1, input)
      p1
    })
    
    output$m5_GDPE_lineplot_dwnbtt <- downloadHandler(
      filename = "StrongerBC_Mission6_Real_GDP_per_Employment_filteredData.csv",
      content = function(file) {
        df <- m5_GDPE_lineplot_data(df_m5_GDPE_1)
        write.csv(df, file)
      }
    )
    
  
    ### Bar Plot----
    output$m5_GDPE_bar <- renderPlotly({
      p1 <- m5_GDPE_render_bar(df_m5_GDPE_1, input)
      p1
    })
    
    output$m5_GDPE_bar_dwnbtt <- downloadHandler(
      filename = "StrongerBC_Mission5_GDPE_filteredData.csv",
      content = function(file) {
        df <- m5_GDPE_bar_data(df_m5_GDPE_1, input$m5_GDPE_bar_year)
        write.csv(df, file)
      }
    )
  
  

}




