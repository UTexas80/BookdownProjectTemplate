# ------------------------------------------------------------------------------
# 07. HOPE/ZELL Scholarship Awards by Academic Year
# ------------------------------------------------------------------------------
################################################################################
## Step 07.01 Janitorr - clean the tables                                    ###
################################################################################
dtTables <- data.table::tables()
sapply(dtTables[NAME %like% "X07" ,],
    function(x) janitor::clean_names(data.table(x)))
################################################################################
## Step 07.02 set the tables                                                 ###
################################################################################
setkey(X07hz.awd, name)
################################################################################
## Step 07.03 clean the tables                                           ###
################################################################################
dt_hz_awd        <- melt.data.table(X07hz.awd,
                        id      = 1,
                        measure =  c('X2008.09',
                                     'X2009.10',
                                     'X2010.11',
                                     'X2011.12',
                                     'X2012.13',
                                     'X2013.14',
                                     'X2014.15',
                                     'X2015.16',
                                     'X2016.17',
                                     'X2017.18',
                                     'X2018.19'))
# ------------------------------------------------------------------------------
names(dt_hz_awd)[2:3]  <- c('ay', 'awd')
dt_hz_awd              <- dt_hz_awd[, c(2, 1, 3)]  # Reorder Columns by index
# ------------------------------------------------------------------------------
# rename ay column row values                       https://tinyurl.com/ybd24xj2
# ------------------------------------------------------------------------------
dt_hz_awd$ay <- apply(dt_hz_awd[,1], 2, 
                        function(x) paste0(mid(x,2,4), "-", right(x,2)))
# dt_hz_awd[, ay := paste0(mid(ay,2,4), "-", right(ay,2))]
# ------------------------------------------------------------------------------
setkey(dt_hz_awd, ay)
setkey(enroll.by.class.l, ay)
# ------------------------------------------------------------------------------
dt_hz_awd <- dt_hz_awd[enroll.by.class.l][
              ,c(1:3,11)][
              ,awd     := lapply(.SD, as.numeric), .SDcols = 'awd'][
              ,awd_pct := (awd/tot_ug)*100]
################################################################################
## Step 07.04 create report tables                                           ###
################################################################################
dt_hz_awd_tbl <- rbind(
    dcast.data.table(dt_hz_awd[name == 'hope'], name ~ ay, value.var = 'tot_ug'),
    dcast.data.table(dt_hz_awd,                 name ~ ay, value.var = 'awd_pct'),
    dcast.data.table(dt_hz_awd,                 name ~ ay, value.var = 'awd')
)
# ------------------------------------------------------------------------------
hz_awd_tbl_desc <-  c("1. Undergrad Enrollment",
                      "3. Hope Pct",
                      "5. Zell Pct",
                      "2. Hope Awards",
                      "4. Zell Awards")
# ------------------------------------------------------------------------------
dt_hz_awd_tbl[,1]       <- hz_awd_tbl_desc
names(dt_hz_awd_tbl)[1] <- "Description"           # rename column name by index
setorder(dt_hz_awd_tbl, Description)
################################################################################
## Step 07.05 create Award by Percentage table                               ###
################################################################################
hope_pct           <- dt_hz_awd[name == 'hope', c(1,5)]
names(hope_pct)[2] <- "hope"                        # rename column name by index
zell_pct           <- dt_hz_awd[name == 'zell', 5]
names(zell_pct)[1] <- "zell"                        # rename column name by index
dt_hz_awd_pct      <- cbind(hope_pct, zell_pct)
################################################################################
## Step 07.06 create Award by Percent Bar viz                                ###
################################################################################
p7a1 <- plot_ly(dt_hz_awd_pct,  x = ~ay, 
                                y = ~hope, 
                           marker = list(
                            color = '#BA0C2F'), 
                             name = 'HOPE', 
                             type = 'bar') %>% 
                      add_trace(y = ~zell, 
                           marker = list(
                            color = '#000000'), 
                             name = 'ZELL')  %>% 
                     layout(title = "% of Undergrads with HOPE/ZELL Awards",
               xaxis = list(title = "Academic Year",
                        tickangle = -45),
               yaxis = list(title = "Awd Pct", 
                       tickformat = "%"))
################################################################################
## Step 07.A: VERSION HISTORY                                                ###
################################################################################
a07.version <- "1.0.0"
a07.ModDate <- as.Date("2020-04-07")
# ------------------------------------------------------------------------------
# 2020.04.02 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
