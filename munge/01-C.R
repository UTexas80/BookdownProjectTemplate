# Example preprocessing script.
# change column names
# ------------------------------------------------------------------------------
c_pie_grad_res <- plot_ly(grad_res, labels = ~Description, values = ~ay1920, type = 'pie',
        textposition = 'inside',
        textinfo = 'label+percent',
        insidetextfont = list(color = '#FFFFFF'),
        hoverinfo = 'text',
        text = ~paste('$', ay1920, ' dollars'),
        marker = list(colors = colors,
                      line = list(color = '#FFFFFF', width = 1)),
                      #The 'pull' attribute can also be used to create space between the sectors
        showlegend = FALSE) %>%
  layout(title = str_c(currentAY, '-Resident Graduate COA'),
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# ------------------------------------------------------------------------------
c_pie_grad_non<- plot_ly(grad_non_res, labels = ~Description, values = ~ay1920, type = 'pie',
        textposition = 'inside',
        textinfo = 'label+percent',
        insidetextfont = list(color = '#FFFFFF'),
        hoverinfo = 'text',
        text = ~paste('$', ay1920, ' dollars'),
        marker = list(colors = colors,
                      line = list(color = '#FFFFFF', width = 1)),
                      #The 'pull' attribute can also be used to create space between the sectors
        showlegend = FALSE) %>%
  layout(title = str_c(currentAY, '-Non-Resident Graduate COA'),
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# ------------------------------------------------------------------------------
print(c_pie_grad_res)
print(c_pie_grad_non)

################################################################################
## Step 00.99: VERSION HISTORY                                               ###
################################################################################
c01.version             <- "1.0.0"
c01.ModDate             <- as.Date("2020-03-01")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0                               http://tinyurl.com/y54k8gsw            
# 1st release                                        http://tinyurl.com/yx9w8vje   
