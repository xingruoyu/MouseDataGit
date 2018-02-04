####
# Project Ivabradine Supplemental Data
# Interactively visualizing the parameters of each individual mouse
####
# Copyright Ruoyu Xing 2-2-2018
# Contact Email: xingruoyu@gmail.com
####

# Server Logic

# load packages ----
# library(googlesheets)
library(reshape2)
# library(plotly)
library(ggplot2)
library(gridExtra)
library(dplyr)

shinyServer(function(input, output) {
      
      # load data ----
      # my_sheet<-gs_url("https://docs.google.com/spreadsheets/d/19WGVmXUTgNKNYp0MZFnlRV-PUw1MAfvlb7fO-AazZcw/edit?usp=sharing")
      
      # my_sheet <- gs_title("ProjectIvabradine_DataVisualization")
      my_sheet <- c("./data/HeartRate.csv", "./data/CardiacDurationSys.csv", "./data/CardiacDurationDia.csv")

      # create empty lists to store data/figure of each tab ----
      data_all <- list()
      data <- list()
      data_reshape <- list()
      Plot <- list()
      i<-1
      
      
      # obtain dataset with all mice ----
      for (i in c(1:3)) {
            data_all[[i]] <- read.csv(my_sheet[i])
            # data_all[[i]] <- gs_read(ss=my_sheet, ws = my_sheet_tab[i])
            # rearrange the mouse numbers
            data_all[[i]][,1] <- c(1:3,10,11,4,5,12:16,6:9,17,18)
            data_all[[i]] <- data_all[[i]][order(data_all[[i]]$Mouse_Number),]    

      }
      
      
      # use interactive checkboxes to define mouse numbers for visualization ----
      data<- reactive({
            lapply(data_all, function(x) {
                  mouse = sort(as.numeric(c(input$MouseNumber_Ctrl, input$MouseNumber_Iva)))
                  x <- x[mouse, ]
                  x$Iva_Ctrl <- x$Iva_Ctrl %>% as.factor() %>% factor(levels=c(0,1), labels = c("Control Group", "Ivabradine Group"))
                  x
            })
      })

      data_reshape <- reactive({
            lapply(data(), function(y) {
                  y <- melt(y, id.vars = c("Iva_Ctrl", "Mouse_Number"))
                  colnames(y) <- c("Ivabradine", "MouseNumber","Time", "Value")
                  y$MouseNumber <- as.factor(y$MouseNumber)
                  y
            })
      })
      
      # show Heart Rate Plot ----
      output$PlotHeartRate <- renderPlot({
            plot_HR <- ggplot(data_reshape()[[1]], aes(x = Time, y = Value)) +
            facet_grid(.~Ivabradine) +
            geom_point(aes(color = MouseNumber, group = MouseNumber), size = 4, na.rm = TRUE) +
            geom_line(aes(color = MouseNumber, group = MouseNumber), size =1, na.rm = TRUE) +

            labs(x ="Time Point", y= "Heart Rate (bpm)") +
            theme(plot.title = element_text(size = 20, face="bold")) + # adjust title font size
            theme(axis.text = element_text(size=16, face="bold"), axis.title=element_text(size=16, face="bold"))+  # adjust axis font size
            theme(strip.text.x = element_text(size = 16, face="bold")) + # adjust font size subplot title
            theme(legend.title = element_text(size=16, face="bold") , legend.text=element_text(size=16)) # adjsut legend font size
            print(plot_HR)
      })

      # Cardiac Plot
      # Systolic
      plot_Card_Sys <- reactive({
            ggplot(data_reshape()[[2]], aes(x = Time, y = Value)) +
            facet_grid(.~Ivabradine) +
            geom_point(aes(color = MouseNumber, group = MouseNumber), size = 4, na.rm = TRUE) +
            geom_line(aes(color = MouseNumber, group = MouseNumber), size =1, na.rm = TRUE) +

            labs(x ="Time Point", y= "Cardiac Duration Systole (s)") +
            theme(plot.title = element_text(size = 20, face="bold")) + # adjust title font size
            theme(axis.text = element_text(size=16, face="bold"), axis.title=element_text(size=16, face="bold"))+  # adjust axis font size
            theme(strip.text.x = element_text(size = 16, face="bold")) + # adjust font size subplot title
            theme(legend.title = element_text(size=16, face="bold") , legend.text=element_text(size=16)) # adjsut legend font size\
      })
      # Diastolic
      plot_Card_Dia <- reactive({
            ggplot(data_reshape()[[3]], aes(x = Time, y = Value)) +
            facet_grid(.~Ivabradine) +
            geom_point(aes(color = MouseNumber, group = MouseNumber), size = 4, na.rm = TRUE) +
            geom_line(aes(color = MouseNumber, group = MouseNumber), size =1, na.rm = TRUE) +

            labs(x ="Time Point", y= "Cardiac Duration Diastole (s)") +
            theme(plot.title = element_text(size = 20, face="bold")) + # adjust title font size
            theme(axis.text = element_text(size=16, face="bold"), axis.title=element_text(size=16, face="bold"))+  # adjust axis font size
            theme(strip.text.x = element_text(size = 16, face="bold")) + # adjust font size subplot title
            theme(legend.title = element_text(size=16, face="bold") , legend.text=element_text(size=16)) # adjsut legend font size\
      })
      # Plot figures next to each other
      output$PlotCardiac <- renderPlot({
            grid.arrange(grobs = list(plot_Card_Sys(), plot_Card_Dia()), ncol = 2)
      })
})
