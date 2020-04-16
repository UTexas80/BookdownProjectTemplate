# ------------------------------------------------------------------------------
# 10. History of Average Federal Pell Grant Awards                           ###
################################################################################
## Step 10.01 Janitorr - clean the tables                                    ###
################################################################################
dtTables  <- data.table::tables()
sapply(dtTables[NAME %like% "X10" ,],
    function(x) janitor::clean_names(data.table(x)))
################################################################################
## Step 10.02 set the tables                                                 ###
################################################################################
dt_pell_awd <- X10pell.awd
################################################################################
## Step 10.03 vizualize the tables                                           ###
################################################################################
p10a1 <- plot_ly(tail(dt_pell_awd,10),
                              x = ~ay, 
                              y = ~awd_uga, 
                         marker = list(
                          color = '#BA0C2F'), 
                           name = 'UGA', 
                           type = 'bar') %>% 
                    add_trace(y = ~awd_usa, 
                         marker = list(
                          color = 'dodgerblue'), 
                           name = 'USA')  %>% 
                   layout(title = "AVERAGE FEDERAL PELL GRANT AWARD",
                          xaxis = list(title = "Academic Year",
                      tickangle = -45),
                          yaxis = list(title = "Pell Award Amount", 
                     tickformat = "$"))
################################################################################
## Step 99.A: VERSION HISTORY                                                ###
################################################################################
a10.version <- "1.0.0"
a10.ModDate <- as.Date("2020-04-15")
# ------------------------------------------------------------------------------
# 2020.04.14 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------