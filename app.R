# 15092021
# code from: https://shiny.rstudio.com/reference/shiny/1.4.0/varSelectInput.html

library(shiny)
library(dplyr)

k43 <- tibble(read.csv('data/k43.csv', encoding = 'UTF-8'))
k42 <- tibble(read.csv('data/k42.csv', encoding = 'UTF-8'))

dt <- rbind(k42, k43) %>% 
    rename(time = colnames(k43[,1])) %>% 
    arrange((time)) %>% 
    slice(-(1:1)) %>% 
    select(-time) %>% 
    mutate(id = row_number(), .before=1) %>% 
    select(-last_col()) %>% 
    mutate(email = 'Liên hệ để biết thêm')


shinyApp(
    ui = fluidPage(
        varSelectInput("variables", "Lọc theo:", dt, multiple = TRUE),
        tableOutput("data")
    ),
    server = function(input, output) {
        output$data <- renderTable({
            if (length(input$variables) == 0) return(dt)
            dt %>% dplyr::select(!!!input$variables)
        }, rownames = TRUE)
    }
)


