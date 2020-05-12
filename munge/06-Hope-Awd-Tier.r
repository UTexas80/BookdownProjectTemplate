# ------------------------------------------------------------------------------
# 06. HOPE Scholarship Awards by Tier                                        ---
# ------------------------------------------------------------------------------
################################################################################
## Step 06.01 Janitor - clean the tables                                    ###
################################################################################
dtTables  <- data.table::tables()
sapply(dtTables[NAME %like% "X06" ,],
    function(x) janitor::clean_names(data.table(x)))
################################################################################
## Step 06.02 set the tables                                                 ###
################################################################################
setkey(X06hope.long, ay)
setkey(X06hope.wide, tier)
################################################################################
## Step 06.03 visualize the tables                                           ###
################################################################################
dt06_hope_bar_amt <- melt.data.table(X06hope.long,
                        id = 1,
                        measure =  c('TIER01','TIER02','TIER03','TIER04'))
names(dt06_hope_bar_amt)[2:3]  <- c('tier', 'amt')
# ------------------------------------------------------------------------------
p06a1a <- ggplot(dt06_hope_bar_amt,
        aes(fill = tier, y = amt, x = ay)) +
        geom_bar(position = "dodge", stat = "identity")
print(p06a1a)
# ------------------------------------------------------------------------------ Award by Tier Bar chart
p06a1 <- plot_ly(X06hope.long, x        = ~ay, y = ~TIER01, type = 'bar', name = 'Tier 1')
p06a1 <- p06a1 %>% add_trace(y           = ~TIER02, name = 'Tier 2')
p06a1 <- p06a1 %>% add_trace(y           = ~TIER03, name = 'Tier 3')
p06a1 <- p06a1 %>% add_trace(y           = ~TIER04, name = 'Tier 4')
p06a1 <- p06a1 %>% layout(title          = "UGA: Hope Scholarship Awards By Tier",
                        xaxis          = list(
                          title        = "Academic Year",
                          tickangle    = -45),
                        yaxis          = list(
                          title        = "Awd Amt"),
                          barmode      = 'group',
                          tickformat   = '$')
# ------------------------------------------------------------------------------Award by Tier Line chart
p06a2 <- plot_ly(tail(X06hope.long, 6),
                           x           = ~ay,     type = 'scatter', mode = 'lines+markers',  yaxis = 'y2',
                           y           = ~TIER01, name = 'Tier 1',  line = list(color = '#BA0C2F'))
p06a2 <- p06a2 %>% add_trace(y           = ~TIER02, name = 'Tier 2',  line = list(color = '#000000'))
p06a2 <- p06a2 %>% add_trace(y           = ~TIER03, name = 'Tier 3',  line = list(color = '#7f827c'))
p06a2 <- p06a2 %>% add_trace(y           = ~TIER04, name = 'Tier 4',  line = list(color = '#19488a'))
p06a2 <- p06a2 %>% layout(title          = "UGA: Hope Scholarship Awards By Tier",
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
# ------------------------------------------------------------------------------Percent Change Bar chart
last_col            <- as.integer(dtTables[NAME == 'X06hope.amt.wide', 3])
dt06_hope_awd         <- cbind(X06hope.amt.wide[,1],X06hope.amt.wide[,..last_col - 5], X06hope.amt.wide[,..last_col])
# percentage-change-between-two-columns-same-row    https://tinyurl.com/vv6wvah
dt06_hope_awd$pct_chg <- apply(dt06_hope_awd[,c(2:3)], 1,
                             function(x) { (x[2] - x[1])/x[1]})
# ------------------------------------------------------------------------------
p06a3 <- plot_ly(setorder(dt06_hope_awd, tier),
                         x             = ~pct_chg,
                         y             = ~tier,
                         type          = 'bar',
                         orientation   = 'h')
p06a3 <- p06a3 %>%  layout(title         = "Pct Change in HOPE Awards by Tier",
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
a06.ModDate <- as.Date("2020-04-02")
# ------------------------------------------------------------------------------
# 2020.04.02 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
