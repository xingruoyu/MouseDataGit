
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  # titlePanel("The effect of the heart rate lowering drug Ivabradine on hemodynamics in a surgically-induced atherosclerotic mouse model"),
  #h4("R. Xing*, A. M. Moerman*, Y. Ridwan+, K. van Gaalen*, E.J. Meester*+, A.F.W. van der Steen*, P. Evans#, F. Gijsen*, K. van der Heiden*"),
 # h5("*Department of Biomedical Engineering, Thorax Center, Erasmus MC, Rotterdam, The Netherlands"),
 # h5("+Department of Radiology, Erasmus MC, Rotterdam, The Netherlands"),
 # h5("#Department of Infection, Immunity and Cardiovascular Disease, University of Sheffield, Sheffield, UK"),
  hr(),
  h3("Supplemental Data - Trial for my next manuscript"),
  h3("2-2-2018 Copyright R.Xing"),
  hr(),
  br(), 
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    position = "left",
    sidebarPanel(
          # add checkbox different data parameters
          # Control Group
          # checkboxGroupInput("checkGroupMice", label = h4("Parameters"), 
          #                    choices = list("Heart Rate" = 100, "Systolic and Diastolic Duration" = 101,
          #                                   "Average Blood Flow" = 200, "Peak Blood Flow" = 201,
          #                                   "TAWSS Healthy Segment" = 300, "TAWSS Plaque Segment" = 301, 
          #                                   "TAWSS Systole Healthy Segment" = 302, "TAWSS Systole Plaque Segment" = 303,
          #                                   "TAWSS Diastole Healthy Segment" = 304, "TAWSS Diastole Plaque Segment" = 305,
          #                                   "Peak WSS Healthy Segment" = 306, "Peak WSS Plaque Segment" = 307),
          #                    selected = c(100:307)),
          h4("This is a web app where you can investigate the cardiac parameters of each individual mouse under the influence of the drug."),
          h4("You can simply check/unchect the Mouse number below here, and the figures on the right side will be updated automatically."),
          hr(),
          # add checkbox representing each mouse
          # Control Group
          checkboxGroupInput("MouseNumber_Ctrl", label = h4("Control Group"), 
                             choiceNames = list("Mouse 1", "Mouse 2", "Mouse 3",
                                            "Mouse 4", "Mouse 5", "Mouse 6",
                                            "Mouse 7", "Mouse 8", "Mouse 9"),
                             choiceValues = c(1:9),
                             selected = c(1:3)),
          hr(),
          # Ivabradine Group
          checkboxGroupInput("MouseNumber_Iva", label = h4("Ivabradine Group"), 
                             choiceNames = list("Mouse 10", "Mouse 11", "Mouse 12",
                                            "Mouse 13", "Mouse 14", "Mouse 15",
                                            "Mouse 16", "Mouse 17", "Mouse 18"),
                             choiceValues = c(10:18),
                             selected = c(10:12))          
    ),

    # Show a plot of the generated distribution
    mainPanel(
          
          # show different parameters
          h4("Heart Rate"),
          plotOutput("PlotHeartRate"),
          hr(),
          h4("Cardiac Duration Systole & Diastole"),
          plotOutput("PlotCardiac"),
          hr()
          # ,
          # h4("Blood Flow"),
          # hr(),
          # h4("TAWSS")
    )
  )
))
