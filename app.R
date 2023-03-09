library(echarts4r)
library(magrittr)
library(shiny)

source("modules/about_section.R")

colony <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-11/colony.csv')
stressor <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-01-11/stressor.csv')

stressor %<>%
  dplyr::mutate(
    stressor = ifelse(stressor == "Other pests/parasites", "Other pests", stressor),
    year_month = paste0(year, " ", months)
  )

ui <- div(
  class = "font-sans bg-slate-50",
  tags$script(src = "https://cdn.tailwindcss.com"),
  tags$link(
    rel = "stylesheet",
    type = "text/css",
    href = "about_section.min.css"
  ),
  tags$script(
    src = "https://cdn.jsdelivr.net/npm/tw-elements/dist/js/index.min.js"
  ),
  tags$script(src = "main.js"),
  div(
    class = "flex items-center justify-between mr-6 ml-10 mb-2 p-1.5",
    div(
      class = "flex items-center",
      tags$a(
        img(
          src = "appsilon-logo.png",
          class = "w-32 hover:bg-gray-200 rounded-lg"
        ),
        href = "https://appsilon.com/",
        target = "blank"
      ),
      span(
        class = "text-lg ml-2",
        " 🐝",
        span(
          class = "font-bold",
          " Bee Colonies"
        )
      )
    ),
    div(
      class = "right-btns",
      about_ui("about_section"),
      div(
        class = "bg-white hover:bg-yellow-400 text-sm 
        font-semibold hover:text-white py-2 px-4 border 
        border-black hover:border-transparent rounded shadow",
        tags$a(
          href = "https://appsilon.com/#contact", 
          target = "blank", "Let's Talk"
        )
      )
    )
  ),
  div(
    class = "flex justify-center ml-10 mr-10 flex-col",    
    div(
      class = "shadow-md rounded-lg w-full m-2 border-t-4 border-yellow-300 bg-white",
      div(
        class = "p-1.5 rounded-t-lg",
        div(
          class = "flex items-center justify-between",
          div(
            "Stressors Affecting Bee Colonies",
          ),
          tags$select(
            id = "year_month",
            class = "bg-white font-semibold"
          )
        )
      ),
      div(
        class = "flex",
        div(
          class = "w-1/2 p-2 mr-6",
          div(
            class = "mt-3",
            tags$select(
              id = "stressor_type",
              class = "bg-white bg-gray-200 px-2 py-1 rounded-lg"
            )
          ),
          echarts4rOutput("stressor_map", height = "340px"),
        ),
        div(
          class = "w-1/2 p-2 ml-6",
          div(
            class = "mt-3",
            tags$select(
              id = "state",
              class = "bg-white bg-gray-200 px-2 py-1 rounded-lg"
            )
          ),
          echarts4rOutput("stressor_per_city", height = "340px")
        )
      )
    ),
    div(
      class = "shadow-md rounded-lg w-full m-2 border-t-4 border-yellow-300 bg-white",
      div(
        class = "p-1.5 rounded-t-lg",
        "State of Bee Colonies"
      ),
      div(
        class = "pt-2",
        echarts4rOutput("total_colonies", height = "340px")
      )
    )
  )
)

server <- function(input, output, session) {
  about_server("about_section")

  session$sendCustomMessage(
    "updateSelectInputOptions",
    list(
      id = "state",
      values = colony$state %>% unique() %>% sort()
    )
  )
  
  session$sendCustomMessage(
    "updateSelectInputOptions",
    list(
      id = "stressor_type",
      values = stressor$stressor %>% unique() %>% sort()
    )
  )
  
  session$sendCustomMessage(
    "updateSelectInputOptions",
    list(
      id = "year_month",
      values = stressor$year_month %>% unique()
    )
  )
  
  output$total_colonies <- renderEcharts4r({
    colony %>% 
      dplyr::filter(state == "United States") %>% 
      dplyr::group_by(year) %>% 
      dplyr::summarise(
        dplyr::across(.cols = c(colony_n, colony_lost, colony_added, colony_reno), sum)
      ) %>% 
      dplyr::mutate(year = ISOdate(year, 1, 1)) %>% 
      plot_bee_colony_bar_chart()
  })
  
  output$stressor_map <- renderEcharts4r({
    req(input$year_month)
    req(input$stressor_type)
    
    
    filtered_data <- stressor %>% 
      dplyr::filter(
        !state %in%  c("United States", "Other States") & 
          year_month == input$year_month & 
          stressor == input$stressor_type
      )
    
    plot_stressor_map(filtered_data)
  })
  
  output$stressor_per_city <- renderEcharts4r({
    req(input$state)
    req(input$year_month)
    
    stressor %>% 
      dplyr::filter(state == input$state & year_month == input$year_month) %>%
      dplyr::mutate(stressor = factor(stressor)) %>% 
      dplyr::arrange(stress_pct) %>% 
      plot_stressor_per_city_chart()
  })
}

shinyApp(ui, server)
