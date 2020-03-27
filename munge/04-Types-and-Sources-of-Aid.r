# ------------------------------------------------------------------------------
# 04. Types and Sources of Aid
# ------------------------------------------------------------------------------
################################################################################
## Step 04.01 Admin: munge Aid files                                         ###
################################################################################
dtTables        <- data.table::tables()
sapply(dtTables[NAME %like% "X04" ,], 
    function(x) janitor::clean_names(data.table(x)))
# X04aid.sources.long <- sapply(X04aid.sources.long[, c(4:5)], function(x) x*100)
################################################################################
## Step 04.02 Financial Aid Awarded: Sources of Financial Aid viz            ###
################################################################################
p4a0 <- plot_ly(head(X04aid.sources.long,-1), 
            labels = ~source, 
            values = ~undergraduate, 
            type = 'pie',
            hole = 0.00,
            domain = list(x = c(0, 0.45)),
            title = 'UNDERGRADUATE',
            showlegend = TRUE)  %>%

  add_trace(head(X04aid.sources.long,-1), 
            labels = ~source, 
            values = ~all_students, 
            type = 'pie', 
            hole = 0.00,
            title = 'ALL STUDENTS',
            domain = list(x = c(0.55, 1))) %>%
        layout(title = str_c(currentAY, ' - Sources of Financial Aid'),
            xaxis = list(title = "TEST",
                        showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(title = "TEST", 
                        showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))    
################################################################################
## Step 04.03 Create Plot_ly Vizualization Pie Charts                        ###
################################################################################
p4a1 <-  plot_ly(head(X04aid.sources.long,-1), 
            labels = ~source, 
            values = ~undergraduate, 
            type = 'pie',
            textposition = 'outside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste('%', undergraduate, ' aid'),
            marker = list(colors = colors,
                          line = list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE) %>%
        layout(title = str_c(currentAY, ' - Undergraduate Aid'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
# ------------------------------------------------------------------------------
p4a2 <-  plot_ly(head(X04aid.sources.long,-1), 
            labels = ~source, 
            values = ~all_students, 
            type = 'pie',
            textposition = 'outside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste('%', all_students, ' aid'),
            marker = list(colors = colors,
                          line = list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE) %>%
        layout(title = str_c(currentAY, ' - All Student Aid'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
# ------------------------------------------------------------------------------        
subplot(p4a1, p4a2)   
# ------------------------------------------------------------------------------
p4b1 <-  plot_ly(head(X04aid.types.long,-1), 
            labels = ~source, 
            values = ~undergraduate, 
            type = 'pie',
            textposition = 'outside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste('%', undergraduate, ' aid'),
            marker = list(colors = colors,
                      line = list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE) %>%
        layout(title = str_c(currentAY, ' - Undergraduate'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
p4b2 <-  plot_ly(head(X04aid.types.long,-1), 
            labels = ~source, 
            values = ~all_students, 
            type = 'pie',
            textposition = 'outside',
            textinfo = 'label+percent',
            insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text',
            text = ~paste('%', all_students, ' aid'),
            marker = list(colors = colors,
                          line = list(color = '#FFFFFF', width = 1)),
            showlegend = FALSE) %>%
        layout(title = str_c(currentAY, ' - All Students'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
# ------------------------------------------------------------------------------
subplot(p4b1, p4b2)
################################################################################
## Step 04.03 Create Plot_ly Vizualization Pie Charts                       ###
################################################################################
bp<- ggplot(head(X04aid.types.long,-1), 
        aes(x="", y=all_students, fill=Description))+
        geom_bar(width = 1, stat = "identity")
pie <- bp + coord_polar("y", start=0)
pie

# ------------------------------------------------------------------------------
dt = data.table("variables" = c("d_agr","d_def","d_frig","d_hidro","d_roads","d_silos"),
                "coeficient" = c(0.18,0.19,-0.01,-0.25,-0.17,0.09))

png("./png/dt.png", width=480,height=480,bg = "white")
grid.table(dt)
dev.off
################################################################################
## Step 04.A: VERSION HISTORY                                                ###
################################################################################
a04.version         <- "1.0.0"
a04.ModDate         <- as.Date("2020-03-25")
# ------------------------------------------------------------------------------
# 2020.04.25 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------

