# ------------------------------------------------------------------------------
# 04. Types and Sources of Aid                                               ---
# ------------------------------------------------------------------------------
################################################################################
## Step 04.01 Janitor - clean the tables                                     ###
################################################################################
dtTables  <- data.table::tables()
# sapply(dtTables[NAME %like% "X04" ,],
#     function(x) janitor::clean_names(data.table(x)))
x <- as.data.table( as.table(sapply(dtTables[NAME %like% "X04*" ,][,1], function(x) x)))[,3]
for(i in 1:nrow(x)) {
  x[i,] %>% clean_names()
}
################################################################################
## Step 04.02 set the tables                                                 ###
################################################################################
# ------------------------------------------------------------------------------
vars <- names(X04aid.sources.long) %>% .[grepl("pct_", .)]
X04aid.sources.long[, (vars) := .SD * 100, .SDcols = vars]
# ------------------------------------------------------------------------------
vars <- names(X04aid.types.long) %>% .[grepl("pct_", .)]
X04aid.types.long[, (vars) := .SD * 100, .SDcols = vars]
# ------------------------------------------------------------------------------
# X04aid.types.long[]
# X04aid.sources.long <- sapply(X04aid.sources.long[, c(4:5)], function(x) x*100)
################################################################################
## Step 04.03 vizualize the tables                                           ###
################################################################################
p04a1_pie <- plot_ly(head(X04aid.sources.long,-1),
            labels = ~source,
            values = ~undergraduate,
            type = 'pie',
            hole = 0.00,
            domain = list(x = c(0, 0.45)),
            title = 'UNDERGRADUATE',
            showlegend = TRUE)  %>%
# ------------------------------------------------------------------------------
    add_trace(head(X04aid.sources.long,-1),
            labels = ~source,
            values = ~all_students,
            type = 'pie',
            hole = 0.00,
            title = 'ALL STUDENTS',
            domain = list(x = c(0.55, 1))) %>%
        layout(title = str_c(ay[currentAY_row,2], ' - Sources of Financial Aid'),
            xaxis = list(title = "",
                        showgrid = FALSE,
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(title = "",
                        showgrid = FALSE,
                        zeroline = FALSE, 
                        showticklabels = FALSE))
# ------------------------------------------------------------------------------
p04a2_pie <- plot_ly(head(X04aid.types.long, -1),
  labels = ~Type,
  values = ~undergraduate,
  type = "pie",
  hole = 0.00,
  domain = list(x = c(0, 0.45)),
  title = "UNDERGRADUATE",
  showlegend = TRUE
) %>%
  add_trace(head(X04aid.types.long, -1),
    labels = ~Type,
    values = ~all_students,
    type = "pie",
    hole = 0.00,
    title = "ALL STUDENTS",
    domain = list(x = c(0.55, 1))
  ) %>%
  layout(
    title = str_c(ay[currentAY_row,2], " - Types of Financial Aid"),
    legend = list(
      orientation = "h",  # show entries horizontally
      xanchor = "center", # use center of legend as anchor
      x = 0.5
    ),                    # put legend in center of x-axis
    xaxis = list(
      title = "",
      showgrid = FALSE,
      zeroline = FALSE,
      showticklabels = FALSE
    ),
    yaxis = list(
      title = "",
      showgrid = FALSE,
      zeroline = FALSE,
      showticklabels = FALSE
    )
  )
################################################################################
## Step 04.03 Create Plot_ly Vizualization Pie Charts                        ###
################################################################################
p04b1_pie <-  plot_ly(head(X04aid.sources.long,-1), 
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
        layout(title = str_c(ay[currentAY_row,2], ' - Undergraduate Aid'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
# ------------------------------------------------------------------------------
p04b2_pie <-  plot_ly(head(X04aid.sources.long,-1), 
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
        layout(title = str_c(ay[currentAY_row,2], ' - All Student Aid'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
# ------------------------------------------------------------------------------
subplot(p04b1_pie, p04b2_pie)
# ------------------------------------------------------------------------------
p04c1_pie <-  plot_ly(head(X04aid.types.long,-1), 
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
        layout(title = str_c(ay[currentAY_row,2], ' - Undergraduate'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
p04c2_pie <-  plot_ly(head(X04aid.types.long,-1), 
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
        layout(title = str_c(ay[currentAY_row,2], ' - All Students'),
            xaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE),
            yaxis = list(showgrid = FALSE, 
                        zeroline = FALSE, 
                        showticklabels = FALSE))
# ------------------------------------------------------------------------------
subplot(p04c1_pie, p04c2_pie)
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
