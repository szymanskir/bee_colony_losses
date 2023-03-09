create_image_path <- function(path) {
  base_path <- ""
  sprintf(
    fmt = "../%s/%s",
    base_path,
    path
  )
}

topic_section <- function(header,
                          description) {
  div(
    h4(class = "about-header", header),
    div(
      class = "about-descr",
      description
    )
  )
}

tag <- function(tag_string, hyperlink) {
  div(
    class = "tag-item",
    icon("link"),
    a(
      href = hyperlink,
      target = "_blank",
      rel = "noopener noreferrer",
      tag_string
    )
  )
}

card <- function(href_link,
                 img_link,
                 card_header,
                 card_text) {
  div(
    class = "card-package",
    a(
      class = "card-img",
      href = href_link,
      target = "_blank",
      rel = "noopener noreferrer",
      img(
        src = img_link,
        alt = card_header
      )
    ),
    div(
      class = "card-heading",
      card_header
    ),
    div(
      class = "card-content",
      card_text
    ),
    a(
      class = "card-footer",
      href = href_link,
      target = "_blank",
      rel = "noopener noreferrer",
      "Learn more"
    )
  )
}

empty_card <- function() {
  div(
    class = "card-empty",
    a(
      href = "https://shiny.tools/#rhino",
      target = "_blank",
      rel = "noopener noreferrer",
      shiny::icon("arrow-circle-right"),
      div(
        class = "card-empty-caption",
        "More Appsilon Technologies"
      )
    )
  )
}

appsilon <- function() {
  div(
    class = "appsilon-card",
    div(
      class = "appsilon-pic",
      a(
        href = "https://appsilon.com/",
        target = "_blank",
        rel = "noopener noreferrer",
        img(
          src = create_image_path("appsilon-logo.png"),
          alt = "Appsilon"
        )
      )
    ),
    div(
      class = "appsilon-summary",
      "We create, maintain, and develop Shiny applications
      for enterprise customers all over the world. Appsilon
      provides scalability, security, and modern UI/UX with
      custom R packages that native Shiny apps do not provide.
      Our team is among the world's foremost experts in R Shiny
      and has made a variety of Shiny innovations over the
      years. Appsilon is a proud Posit Full Service
      Certified Partner."
    )
  )
}

about_section <- div(
  div(
    class = "modal-dialog",
    div(
      class = "modal-title",
      div(
        "Destination Overview",
      )
    ),
    div(
      class = "about-section",
      topic_section(
        header = "About the project",
        description = HTML("Bee Colonies is a Shiny dashboard
        that uses TailwindCSS and utility classes to design
        a sleek, custom UI with minimal lines of code. The
        inviting UI elements encourage users to explore the
        data and discover the alarming impact of stressors
        on disappearing bee colonies. Explore the <a
        class = 'app_href'
        href = 'https://appsilon.com/how-to-use-tailwindcss-in-shiny/'>
        tutorial to implement TailwindCSS </a>
        in your Shiny dashboard.")
      ),
      topic_section(
        header = "Dataset Info",
        description = "This Dataset comes from United States department of
        agriculture's published report. This report provides information on
        honey bee colonies in terms of number of colonies, maximum, lost,
        percent lost, added, renovated, and percent renovated, as well as
        colonies lost with Colony Collapse Disorder symptoms with both over
        and less than five colonies. Data can be directly downloaded from the
        USDA website or Tidytuesday website."
      ),
      div(
        class = "about-tag",
        tag(
          tag_string = "Tidy Tuesday",
          hyperlink = paste0(
            "https://github.com/rfordatascience/tidytuesday/blob/",
            "master/data/2022/2022-01-11/readme.md"
          )
        ),
        tag(
          tag_string = "USDA website",
          hyperlink = paste0(
            "https://usda.library.cornell.edu/concern/publications/",
            "rn301137d?locale=en"
          )
        )
      ),
      hr(),
      appsilon()
    )
  )
)


#' @export
about_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(
      "data-te-modal-init" = TRUE,
      class = "fixed top-0 left-0 z-[1055]
        hidden h-full w-full overflow-y-auto overflow-x-hidden outline-none",
      id = "exampleModal",
      tabindex = "-1",
      "aria-labelledby" = "exampleModalLabel",
      "aria-hidden" = "true",
      "aria-modal" = "true",
      div(
        "data-te-modal-dialog-ref" = TRUE,
        class = "pointer-events-none relative w-auto translate-y-[-50px]
        opacity-0 transition-all duration-300 ease-in-out
        min-[576px]:mx-auto min-[576px]:mt-7 min-[576px]:max-w-[500px]
        min-[992px]:max-w-[800px]",
        div(
          class = "min-[576px]:shadow-[0_0.5rem_1rem_rgba(#000, 0.15)]
      pointer-events-auto relative
      rounded-md border-none bg-white",
          div(
            class = "flex flex-shrink-0 items-center
            justify-between rounded-t-md border-b-2
            border-neutral-100 border-opacity-100 p-4
            dark:border-opacity-50",
            about_section
          )
        )
      )
    ),
    tags$button(
      type = "button",
      "data-te-toggle" = "modal",
      "data-te-target" = "#exampleModal",
      "data-te-ripple-init" = TRUE,
      "data-te-ripple-color" = "light",
      class = "info-btn",
      shiny::icon("info-circle")
    )
  )
}

about_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    observeEvent(
      input$open_modal,
      {
      }
    )
  })
}
