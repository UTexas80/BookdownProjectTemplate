# ------------------------------------------------------------------------------
# 09. Hope/Zell Scholarship Awards by Academic Year
################################################################################
## Step 09.01 Janitorr - clean the tables                                    ###
################################################################################
dtTables  <- data.table::tables()
sapply(dtTables[NAME %like% "X09" ,],
    function(x) janitor::clean_names(data.table(x)))
################################################################################
## Step 09.02 set the tables                                                 ###
################################################################################
setkey(X09hz.awd,   ay)
setkey(X09hz.pct,   ay)
setkey(tbl.tuition, ay)
# ------------------------------------------------------------------------------
dt_hz_awd     <- rbind(X09hz.awd, tbl.tuition)
#X09hz.pct[,3  := lapply(.SD, function(x) x*100), .SDcols = 3]
X09hz.pct$pct <- X09hz.pct$pct
# ------------------------------------------------------------------------------
dt_hz_tbl <- rbind(
  dcast.data.table(dt_hz_awd, name ~ ay, value.var = "amt"),
  dcast.data.table(X09hz.pct, name ~ ay, value.var = "pct")
)
# ------------------------------------------------------------------------------
dt_hz_amt <- dcast.data.table(dt_hz_awd, ay ~ name, value.var = 'amt')
dt_hz_pct <- dcast.data.table(X09hz.pct, ay ~ name, value.var = 'pct')
################################################################################
## Step 09.03 vizualize the tables                                           ###
################################################################################
#  Award as Pct of Tuition Bar chart--------------------------------------------
p9a1 <- plot_ly(dt_hz_pct, x = ~ay, y = ~hope, marker = list(color = '#BA0C2F'), name = 'HOPE', type = 'bar') %>% 
          add_trace(                y = ~zell, marker = list(color = '#000000'), name = 'ZELL')  %>% 
          layout( title               = "Max HOPE & ZELL Awards Compared to Tuition",
                  xaxis               = list(title = "Academic Year",    tickangle = -45),
                  yaxis               = list(title = "Max Award Amount", tickformat = "%"))
# Award Compared to Tuition Line chart------------------------------------------
p9a2 <- plot_ly(dt_hz_amt, x  = ~ay,      type = 'scatter', mode = 'lines+markers', yaxis = 'y2',
                           y  = ~hope,    name = 'HOPE',    line = list(color = '#BA0C2F'))
p9a2 <- p9a2 %>% add_trace(y  = ~zell,    name = 'ZELL',    line = list(color = '#000000'))
p9a2 <- p9a2 %>% add_trace(y  = ~tuition, name = 'Tuition', line = list(color = '#7f827c'))
p9a2 <- p9a2 %>% layout(title = "Max HOPE & ZELL Awards Compared to Tuition", 
                        xaxis = list(title = "Academic Year", tickangle = -45),
                        yaxis = list(title = "Max Award Amount"))
################################################################################
## Step 99.A: VERSION HISTORY                                                ###
################################################################################
a09.version <- "1.0.0"
a09.ModDate <- as.Date("2020-04-14")
# ------------------------------------------------------------------------------
# 2020.04.14 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
