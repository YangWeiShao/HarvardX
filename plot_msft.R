plot()   # plot(x axis, y axis)  -> bar chart (single argument => index as x-axis), boxplot(numerical, categorical => scatter)
hist( , breaks = 10)  ->
    
    barplot()
boxplot()
pairs()
##
boxplot(movies$runtime)
plot(movies[,c("rating","votes","runtime")])
pie(table(movies$genre))

plot(mercury$temperature, mercury$pressure,
     xlab = "Temperature", # x-axis label
     ylab = "Pressure", # y-axis label
     main = "T vs P for Mercury",  # main title
     sub = "2018", # subtitle
     type = "o",  # "o" for circle + line; "l" line only
     col = "orange", #color
     col.main = "darkgray", # color of main title
     cex.axis = 0.6, # ratio of font size of axis tick marks (size)
     lty = 5, # line type
     pch = 4) # plot symbol type

par() # list all the possible graphical parameters
par(col ="blue")  # set the parameter at begining, apply to following charts
par()$col   # if forget the setting, this function tells you the parameter you set before
[1] "blue"