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


# Loading data----

    ## CEG----
    load_m5_CEG1 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Clean_Energy_Generated_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }
    
    load_m5_xyz1 <- function() {
      url <- "..."
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }

# CEG Dash----
    ## Line plot----
    m5_CEG_lineplot_data <- function(df) {
      df |>
        filter(Year >= 2015,
               GEO == "British Columbia",
               Class.of.electricity.producer == "Total all classes of electricity producer",
               Type.of.electricity.generation %in% c("Hydraulic turbine",
                                                     "Tidal power turbine",
                                                     "Wind power turbine",
                                                     "Solar"))|>
        group_by(Year) |>
        summarise(VALUE = sum(VALUE))
    }
    
    m5_CEG_render_lineplot <- function(df, input){
      dash_lineplot(m5_CEG_lineplot_data, df, input)}
    
    
    ## sources plot data----
    m5_CEG_sources_data <- function(df, geo){
      df |>
        filter(Year >= 2015,
               GEO == geo,
               Class.of.electricity.producer == "Total all classes of electricity producer",
               Type.of.electricity.generation %in% c("Hydraulic turbine",
                                                     "Tidal power turbine",
                                                     "Wind power turbine",
                                                     "Solar"))|>
        arrange(Year) |>
        mutate(
          Type = Type.of.electricity.generation,
          VALUE = VALUE / 1000000)
               
    }
    
    m5_CEG_render_sources <- function(df, input){
      dfsources <- m5_CEG_sources_data(df, input$m5_CEG_sources_geo)
      psources <- dfsources |>
        plot_ly(x = ~Year, y = ~VALUE, color = ~Type, type = 'bar')|>
        layout(
          barmode = 'stack',
          plot_bgcolor = '#F2F2F2',
          paper_bgcolor = '#F2F2F2',
          yaxis = list(title = "MWh"),
          xaxis = list(title = ""),
          legend = list(y = -0.3, x=0))
      
      validate(need(nrow(dfsources) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      psources <- ggplotly(psources)
      return(psources)
    }
    
    
    
    ## map plot data----
    m5_CEG_map_data <- function(df, year){
      df <-   df |>
        filter(
               GEO != "Canada",
               Year == year,
               Class.of.electricity.producer == "Total all classes of electricity producer",
               Type.of.electricity.generation %in% c("Hydraulic turbine",
                                                     "Tidal power turbine",
                                                     "Wind power turbine",
                                                     "Solar"))|>
        arrange(Year) |>
        mutate(
          Type = Type.of.electricity.generation,
          VALUE = VALUE / 1000000) |>
        group_by(Year, GEO) |>
        summarize (VALUE = sum(VALUE, na.rm = TRUE), .groups = 'drop')
      
    }
    
    m5_CEG_render_map <- function(df, input){
      df_map <- m5_CEG_map_data(df, input$m5_CEG_map_year)
      mapchart(df_map, input)
    }
