# ------------------------------------------------------------------------------
# 08. HOPE/ZELL Scholarship Awards Totals by Academic Year                   ---
# ------------------------------------------------------------------------------
################################################################################
## Step 08.01 - get the last column; total the tables; output last row       ###
################################################################################
dt_hope_tot             <- data.table::cube(
    X06hope.wide,
    .(awd = sum(X06hope.wide[,ncol(X06hope.wide)-1, with = FALSE]),
      amt = sum(X06hope.wide[,ncol(X06hope.wide),   with = FALSE])),
    by = c("tier")
)[5,]
# ------------------------------------------------------------------------------  
dt_zell_tot             <- data.table::cube(
    X06zell.wide,
    .(awd = sum(X06zell.wide[,ncol(X06zell.wide)-1, with = FALSE]),
      amt = sum(X06zell.wide[,ncol(X06zell.wide),   with = FALSE])),
    by = c("tier")
)[5,]
# ------------------------------------------------------------------------------  
names(dt_hope_tot)[1]   <-  c('name')
names(dt_zell_tot)[1]   <-  c('name')
################################################################################
## Step 08.02 bind the tables and compute percentages & totals               ###
################################################################################
dt_hz_tot               <- rbind(dt_hope_tot, dt_zell_tot)
dt_hz_tot$awd_pct       <- dt_hz_tot$awd / sum(dt_hz_tot$awd) * 100
dt_hz_tot$amt_pct       <- dt_hz_tot$amt / sum(dt_hz_tot$amt) * 100
dt_hz_tot               <- adorn_totals(dt_hz_tot, where = 'row')
################################################################################
## Step 08.03 prepare total table for export to .RMD                         ###
################################################################################
dt_hz_tot[, 1]          <- c('HOPE Scholarship Totals: ',
                             'Zell Miller Scholarship Totals: ',
                             'Combined HOPE and Zell Miller Scholarship Totals: ')
################################################################################
## Step 08.04 Total Number of Award Comparision viz                          ###
################################################################################
p8a1 <- plot_ly(head(dt_hz_tot,-1),
            labels     = ~name,
            values     = ~awd,
            type       = 'pie',
            marker     = list(colors = c('#BA0C2F', '#000000')),
            hole       = 0.00,
            domain     = list(x = c(0, 0.45)),
            title      = 'Number of Awards',
            showlegend = FALSE)  %>%
    add_trace(head(dt_hz_tot,-1),
            labels    = ~name,
            values    = ~amt,
            type      = 'pie',
            hole      = 0.00,
            title     = 'Award Amount',
            domain    = list(x = c(0.55, 1))) %>%
        layout(title  = str_c(currentAY, ' - Total Hope and Zell Awards'),
            xaxis                      = list(title = "",
                        showgrid       = FALSE,
                        zeroline       = FALSE,
                        showticklabels = FALSE),
            yaxis                      = list(title = "",
                        showgrid       = FALSE,
                        zeroline       = FALSE, 
                        showticklabels = FALSE))
################################################################################
## Step 08.A: VERSION HISTORY                                                ###
################################################################################
a08.version <- "1.0.0"
a08.ModDate <- as.Date("2020-04-10")
# ------------------------------------------------------------------------------
# 2020.04.02 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
