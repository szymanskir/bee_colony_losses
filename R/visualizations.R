plot_bee_colony_bar_chart <- function(source_data) {
  source_data %>% 
    echarts4r::e_charts(year) %>% 
    echarts4r::e_bar(colony_lost, name = "Colonies Lost", stack = "net loss") %>% 
    echarts4r::e_bar(colony_added, name = "Colonies Added", stack = "net gain") %>%
    echarts4r::e_color(color = c("#000000", "#FCD34D"))
}

plot_stressor_per_city_chart <- function(source_data) {
  source_data %>% 
    echarts4r::e_charts(stressor) %>% 
    echarts4r::e_bar(stress_pct) %>% 
    echarts4r::e_flip_coords() %>% 
    echarts4r::e_color(color = "#FCD34D") %>% 
    echarts4r::e_legend(show = FALSE) %>% 
    echarts4r::e_format_x_axis(suffix = "%") %>% 
    echarts4r::e_grid(containLabel = TRUE)
}

plot_stressor_map <- function(source_data) {
  json <- jsonlite::read_json("https://raw.githubusercontent.com/shawnbot/topogram/master/data/us-states.geojson")
  
  ## remove alaska and hawaii
  json$features <- Filter(function(x) !x$properties$name %in% c("Alaska", "Hawaii"), json$features)
  
  source_data %>% 
    echarts4r::e_charts(x = state) %>% 
    echarts4r::e_map_register("USA", json) %>% 
    echarts4r::e_map(stress_pct, map = "USA") %>% 
    echarts4r::e_visual_map(
      inRange = list(color = c("#FEF9C3", "#FACC15")),
      min = min(source_data$stress_pct, na.rm = TRUE),
      max = max(source_data$stress_pct, na.rm = TRUE)
    )
}