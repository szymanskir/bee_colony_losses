create_image_path <- function(path) {
  base_path <- "static/img/"
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
  id = "overlay",
  "aria-hidden" = "true",
  "data-te-modal-init",
  class = "bg-black bg-opacity-50
  absolute inset-0 hidden justify-center
  items-center w-max
  z-50",
  tabindex = "-1",
  "aria-labelledby" = "exampleModalLabel",
  div(
    class = "modal-dialog bg-gray-200
    rounded shadow-xl z-30",
    div(
      class = "modal-title",
      div(
        "Destination Overview",
        div(
          HTML(
            '
            <svg class="h-6 w-6 cursor-pointer p-1 
            hover:bg-gray-300 rounded-full" id="close-modal" 
            fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 
                0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 
                11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 
                1 0 010-1.414z"
                clip-rule="evenodd"></path>
              </svg>
            '
          )
        )
      )
    ),
    div(
      class = "about-section",
      topic_section(
        header = "About the project",
        description = "This dashboard serves as a
            showcase of R Shiny in the shipping and
            logistics industry. Destination Overview
            visualizes interstate shipment data, including
            how many shipments are dispatched or received
            by each state in a given month."
      ),
      topic_section(
        header = "Dataset Info",
        description = "This is a cross-sectional data of shipments
              transportation in US."
      ),
      hr(),
      div(
        h4(
          class = "about-header",
          "Powered by"
        ),
        div(
          class = "card-section",
          card(
            href_link = "https://appsilon.github.io/shiny.semantic/",
            img_link = create_image_path("shiny-semantic.png"),
            card_header = "shiny.semantic",
            card_text = "Shiny Semantic is a package developed by
                  appsilon for the R community. With this library it is
                  easy to wrap Shiny with Fomantic UI (previously
                  Semantic). Add a few simple lines of code to give
                  your UI a fresh, modern and highly interactive look."
          ),
          card(
            href_link = "https://appsilon.github.io/rhino/",
            img_link = create_image_path("rhino.png"),
            card_header = "rhino",
            card_text = "Rhino allows you to create Shiny apps The Appsilon
                  Way - like a fullstack software engineer. Apply best
                  software engineering practices, modularize your code,
                  test it well, make UI beautiful, and think about
                  user adoption from the very beginning. Rhino is an opinionated
                  framework with a focus on software engineering practices
                  and development tools."
          ),
          empty_card()
        )
      ),
      appsilon()
    )
  )
)


#' @export
about_ui <- function(id) {
  ns <- NS(id)

  tagList(
    div(
      id = "info",
      class = "info",
      shiny::icon("info-circle")
    ),
    tags$script(
      sprintf(
        fmt = "
        $('#info').click( () => {
          $('#overlay').toggleClass('hidden')
        })
        "
      )
    )
  )
}

about_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    observeEvent(input$open_modal, {
    })
  })
}
