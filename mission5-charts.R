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
      url <- "https://raw.githubusercontent.com/bcgov/BC-Economic-Development/refs/heads/main/Data/Clean_Energy_Generated_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }
    
    load_m5_CEG2 <- function() {
      url <- "https://raw.githubusercontent.com/bcgov/BC-Economic-Development/refs/heads/main/Data/Clean_Energy_Generated_2.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }
    
    load_m5_CEG3 <- function() {
      
      df2 <- load_m5_CEG2()
      recentmonth <- df2[which.max(as.Date(df2$DATE)), ]$Month
      recentyear <- df2[which.max(as.Date(df2$DATE)), ]$Year
      df2_1 <- df2 |>
        filter (Electric.power..components == "Total electricity available for use within specific geographic border") |>
        group_by(Year, GEO) |>
        summarise(TEA = sum(VALUE)) |>
        filter(if (recentmonth < 12) Year != recentyear) |>
        group_by(GEO) |>
        arrange(Year, .by_group = TRUE) |>
        mutate(TEA_growth = round((TEA - lag(TEA))/lag(TEA) * 100, 1) ) |>
        ungroup()
      
      
      
      df1 <- load_m5_CEG1()
      df1_1 <- df1 |>
        filter(
          Class.of.electricity.producer == "Total all classes of electricity producer",
          Type.of.electricity.generation %in% c("Hydraulic turbine", "Tidal power turbine", "Wind power turbine", "Solar")
        ) |> 
        
        group_by(Year, GEO) |>
        summarise( CEG = sum(VALUE) ) |>
        group_by(GEO) |>
        arrange(Year, .by_group = TRUE) |>
        mutate(CEG_growth = round((CEG - lag(CEG))/lag(CEG) * 100,1) ) |>
        ungroup()
      
      
      df1_2 <- df1 |>
        filter(
          Class.of.electricity.producer == "Total all classes of electricity producer",
          Type.of.electricity.generation == "Hydraulic turbine"
        ) |>
        mutate (Hydro = VALUE)|>
        select(Year, GEO, Hydro) |>
        group_by(GEO) |>
        arrange(Year, .by_group = TRUE) |>
        mutate(Hydro_growth = round((Hydro - lag(Hydro))/lag(Hydro) * 100, 1) ) |>
        ungroup()
        
      
      
      merged_df <- merge(df1_1, df1_2, by = c("Year", "GEO"))
      merged_df <- merge(merged_df, df2_1, by = c("Year", "GEO"))
      return(merged_df)
    }

    ## GDPE----
    load_m5_GDPE1 <- function(){
      url <- "https://raw.githubusercontent.com/bcgov/BC-Economic-Development/refs/heads/main/Data/Real_GDP_per_Employment_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }
    

    
# CEG Dash----
    ## Line plot----
    m5_CEG_lineplot_data <- function(df) {
      df |>
        filter(Year >= 2015,
               Year < 2024,
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

      latest_year <- max(dfsources$Year)
      latest_month <- unique(dfsources$lastmonth)

      dfsources <- dfsources |>
        mutate(Year = ifelse(Year == latest_year, paste(Year, "\n(up until", month.name[latest_month], ")"), as.character(Year)))
      
      # Plot using the updated Year labels
      psources <- dfsources |>
        plot_ly(
          x = ~Year,
          y = ~VALUE,
          color = ~Type,
          type = 'bar'
        ) |>
        layout(
          barmode = 'stack',
          plot_bgcolor = '#F2F2F2',
          paper_bgcolor = '#F2F2F2',
          yaxis = list(title = "MWh"),
          xaxis = list(title = ""),
          legend = list(y = -0.3, x = 0)
        )
      
      

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

    ## EGC plot data----
    m5_CEG_EGC_data <- function(df, geo){
     df |>
        filter(
          Year >= 2015,
          GEO == geo,
          Electric.power..components %in% c("Total generation", "Total electricity available for use within specific geographic border")
        ) |>
        mutate(Component = Electric.power..components) |>
        select(DATE, GEO, Component, VALUE) |>
        arrange(DATE) 
    }
    
    m5_CEG_render_EGC <- function(df2, input){
      df <- m5_CEG_EGC_data(df2, input$m5_CEG_EGC_geo)

      df_wide <- df %>%
        tidyr::pivot_wider(names_from = Component, values_from = VALUE)
      
      # Create the plotly area chart
      plot <- plot_ly(df_wide, x = ~DATE) %>%
        add_trace(y = ~`Total generation`, name = "Total generation",  type = 'scatter', mode = 'lines', fill = 'tozeroy') %>%
        add_trace(y = ~`Total electricity available for use within specific geographic border`, 
                  name = "Total electricity available",type = 'scatter', mode = 'lines', fill = 'tozeroy') %>%
        layout(
          plot_bgcolor = '#F2F2F2',
          paper_bgcolor = '#F2F2F2',
          xaxis = list(title = ""),
          yaxis = list(title = "Value"),
          legend = list(
            x = 0.5,
            y = -0.2,
            xanchor = "center",
            orientation = "h"
          ),
          showlegend = TRUE
        )
      plot
    }
    

    
    ## growth plot data----
    m5_CEG_growth_data <- function(df, geo){
      df |>
        filter(
          Year >= 2015,
          GEO == geo
        ) |>
        select(Year, GEO, CEG_growth, Hydro_growth, TEA_growth) |>
        arrange(Year) 
    }
    
    m5_CEG_render_growth <- function(df3, input){
      df <- m5_CEG_growth_data(df3, input$m5_CEG_growth_geo)
      
      
      # Create the plotly area chart
      plot <- plot_ly(df, x = ~Year) %>%
        add_trace(y = ~CEG_growth, name = "Clean Energy Generated",  type = 'scatter', mode = 'lines') %>%
        add_trace(y = ~TEA_growth, name = "Total Electricity Available ",  type = 'scatter', mode = 'lines') %>%
        add_trace(y = ~Hydro_growth, name = "Electricity Generated from Hydro ",  type = 'scatter', mode = 'lines') %>%
        layout(
          plot_bgcolor = '#F2F2F2',
          paper_bgcolor = '#F2F2F2',
          xaxis = list(title = ""),
          yaxis = list(title = "Value"),
          legend = list(
            x = 0.5,
            y = -0.2,
            xanchor = "center",
            orientation = "h"
          ),
          showlegend = TRUE
        )
      plot
    }
    
    

# GDPE Dash----
    ## Line plot----
    m5_GDPE_lineplot_data <- function(df) {
      df |>
        filter(GEO == "British Columbia") |>
        mutate(VALUE = GDPE)
    }
    
    m5_GDPE_render_lineplot <- function(df, input){
      dash_lineplot(m5_GDPE_lineplot_data, df, input)}

    ## Bar Plot ----
    m5_GDPE_bar_data <- function(df, year){
      df |> 
        filter (Year == year)    }
    
    m5_GDPE_render_bar <- function(df, input){
      df2 <- m5_GDPE_bar_data(df, input$m5_GDPE_bar_year)
      df2$GEO <- reorder(df2$GEO, df2$GDPE)
      df2$formatted_VALUE <- sprintf("%.2f%%", df2$GDPE)
      p2 <- df2 |>
        plot_ly(x = ~GDPE, y=~GEO, color=~GEO, type = 'bar',
                showlegend = FALSE)  |>
        add_text(x = ~formatted_VALUE,text = ~formatted_VALUE, textposition = 'outside') |>
        layout(
          plot_bgcolor = '#F2F2F2',
          paper_bgcolor = '#F2F2F2'
        )
      
      validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
      return(p2)
    }
    
    
