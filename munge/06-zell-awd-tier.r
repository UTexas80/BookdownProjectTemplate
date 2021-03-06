# ------------------------------------------------------------------------------
# 06. ZELL Scholarship Awards by Tier                                        ---
# ------------------------------------------------------------------------------
################################################################################
## Step 06.01 Janitor - clean the tables                                    ###
################################################################################
dtTables  <- data.table::tables()
x06       <- grep("^X06", ls(), value = TRUE)
sapply(dtTables[NAME %like% "X06" ,],
    function(x) janitor::clean_names(data.table(x)))
# ------------------------------------------------------------------------------
lapply(x06, function(nm) {
  # df  <- get(nm)
  # setDT(df)[, OPEID := as.integer(OPE.ID)][
  #           , c(8,1:5)]
  # setkey(df, "OPEID")
  # setorder(df, OPEID)
})
################################################################################
## Step 06.02 set the tables                                                 ###
################################################################################
setkey(X06zell.amt, ay)
setkey(X06zell.wide, tier)
################################################################################
## Step 06.03 vizualize the tables                                           ###
################################################################################
dt_zell_bar_amt <- melt.data.table(X06zell.amt,
                        id = 1,
                        measure =  c('TIER01','TIER02','TIER03','TIER04'))
names(dt_zell_bar_amt)[2:3]  <- c('tier', 'amt')
# ------------------------------------------------------------------------------ Award by Tier Bar chart
p06z1 <- plot_ly(X06zell.amt,x          = ~ay, y = ~TIER01, type = 'bar', name = 'Tier 1')
p06z1 <- p06z1 %>% add_trace(y             = ~TIER02, name = 'Tier 2')
p06z1 <- p06z1 %>% add_trace(y             = ~TIER03, name = 'Tier 3')
p06z1 <- p06z1 %>% add_trace(y             = ~TIER04, name = 'Tier 4')
p06z1 <- p06z1 %>% layout(title            = "UGA: zell Scholarship Awards By Tier", 
                        xaxis            = list(
                          title          = "Academic Year", 
                          tickangle      = -45),
                        yaxis            = list(
                          title          = "Awd Amt"), 
                          barmode        = 'group', 
                          tickformat     = '$')
# ------------------------------------------------------------------------------Award by Tier Line chart
p06z2 <- plot_ly(tail(X06zell.amt, 6),
                           x           = ~ay,     type = 'scatter', mode = 'lines+markers',  yaxis = 'y2',
                           y           = ~TIER01, name = 'Tier 1',  line = list(color = '#BA0C2F'))
p06z2 <- p06z2 %>% add_trace(y           = ~TIER02, name = 'Tier 2',  line = list(color = '#000000'))
p06z2 <- p06z2 %>% add_trace(y           = ~TIER03, name = 'Tier 3',  line = list(color = '#7f827c'))
p06z2 <- p06z2 %>% add_trace(y           = ~TIER04, name = 'Tier 4',  line = list(color = '#19488a'))
p06z2 <- p06z2 %>% layout(title          = "UGA: Zell Scholarship Awards By Tier",
#                       titlefont      = list(
#                         color        = '#ffffff'),
#                       paper_bgcolor  = '#4666d1',  
#                       plot_bgcolor   = '#4666d1',
                        xaxis          = list(
#                         color        = '#ffffff',
                          title        = "Academic Year", 
                          tickangle    = -45),
                        yaxis          = list(
#                         color        = '#ffffff',
                          title        = "Award Amount"))
# # ------------------------------------------------------------------------------Percent Change Bar chart
last_col            <- as.integer(dtTables[NAME == 'X06zell.wide', 3])
dt_zell_awd         <- cbind(X06zell.wide[,1],X06zell.wide[,..last_col - 12], X06zell.wide[,..last_col])
# percentage-change-between-two-columns-same-row    https://tinyurl.com/vv6wvah
dt_zell_awd$pct_chg <- apply(dt_zell_awd[,c(2:3)], 1, 
                             function(x) { (x[2] - x[1])/x[1]})
# # ------------------------------------------------------------------------------
 p06z3 <- plot_ly(setorder(dt_zell_awd, tier),
                          x             = ~pct_chg,
                          y             = ~tier,
                          type          = 'bar',
                          orientation   = 'h') 
 p06z3 <- p06z3 %>%  layout(title         = "Pct Change in zell Awards by Tier",
                          xaxis         = list(
                            title       = "Academic Year", 
                            tickangle   = -45,
                            tickformat  = '%'),
                          yaxis         = list(title = "Tier",
                          categoryorder = "category descending",
                          categoryarray = ~tier))
################################################################################
## Step 00.A: VERSION HISTORY                                                ###
################################################################################
a06.version <- "1.0.0"
a06.ModDate <- as.Date("2020-04-06")
# ------------------------------------------------------------------------------
# 2020.04.06 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
