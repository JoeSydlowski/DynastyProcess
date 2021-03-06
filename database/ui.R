library(shiny)
library(curl)
library(DT)
library(shinythemes)
library(markdown)

x <- read.csv(curl("https://raw.githubusercontent.com/tanho63/dynastyprocess/master/files/database.csv"))

shinyUI(fluidPage(
  
  theme = shinytheme("flatly"),
  withTags(
    nav(class="navbar navbar-default navbar-static-top", role="navigation",
        div(class="container-fluid",
            div(class="navbar-header",
                span(class="navbar-brand",
                     a(href="https://dynastyprocess.com",strong("DynastyProcess.com"))
                )
            ),
            ul(class="nav navbar-nav",
               li(class="active",a(href="#",strong("Database"))
               ),
               li(
                 a(href="http://apps.dynastyprocess.com/calculator",strong("Calculator"))
               ),
               li(
                 a(href="http://apps.dynastyprocess.com/rookie-adp",strong("Rookie ADP"))
               ),
               li(class="dropdown",
                  a(class="dropdown-toggle",`data-toggle`="dropdown", `data-value`="More Awesome Apps",`aria-expanded`="false", href="#", strong("More Awesome Apps"),b(class="caret")),
                  ul(class="dropdown-menu",
                     li(a(href="http://apps.dynastyprocess.com/arbitrage",strong("Arbitrage"))),
                     li(a(href="http://apps.dynastyprocess.com/ecr",strong("ECR Explorer"))),
                     li(a(href="http://apps.dynastyprocess.com/cohort",strong("Cohort")))
                  )
               )
            )
        )
    )
  ),
  
  titlePanel("DynastyProcess.com Database"),
  tabsetPanel(
    tabPanel("Database",
             selectizeInput("select",
                            "Select columns:", 
                            choices = list(
                              bio = names(x)[12:18],
                              contract = names(x)[19:20],
                              fantasypros = names(x)[21:27],
                              draft = names(x)[28:33],
                              "season-stats-snaps" = names(x)[47:49],
                              "season-stats-passing" = names(x)[50:56],
                              "season-stats-rushing" = names(x)[57:62],
                              "season-stats-receiving" = names(x)[63:75],
                              "season-stats-firstdowns" = names(x)[76:78],
                              "season-stats-fantasy" = names(x)[79:80],
                              athletic = names(x)[34:46],
                              ID = names(x)[1:11]),
                            selected = c("mergename", "pos", "team", "age", "draft_year", "draft_round",
                                         "offSnaps.", "offSnaps", "dynoECR", "dynpECR", "redpECR"),
                            multiple = TRUE,
                            width = "50%"),
             hr(),
             actionButton("clear1", "Reset All Filters"),
             downloadButton("downloadData", "Download"),
             hr(),
             DTOutput("results"),
             hr(),
             p(HTML(paste0("DynastyProcess.com Apps are created by ",
                           a(href = "https://twitter.com/JoeSydlowskiFF", "Joe Sydlowski"),
                           " and ",
                           a(href = "https://twitter.com/_TanHo", "Tan Ho"),
                           ". You can find the code on ",
                           a(href = "https://github.com/JoeSydlowski/DynastyProcess/tree/master/database", "Joe's github"),
                           "."
             )))
    ),
    tabPanel("About", includeMarkdown("aboutdatabase.md"))
  )))
