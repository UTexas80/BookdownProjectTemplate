# ------------------------------------------------------------------------------
# 11. Federal Pell Grant Maximum Awards & COA                                ###
################################################################################
## Step 11.01 Janitorr - clean the tables                                    ###
################################################################################
dtTables  <- data.table::tables()
sapply(dtTables[NAME %like% "X11" ,],
    function(x) janitor::clean_names(data.table(x)))
################################################################################
## Step 11.02 set the tables                                                 ###
################################################################################
dt11_pell_in_st  <- X11pell.in.state
dt11_pell_out_st <- X11pell.out.state
dt11_pell_ug     <- X11pell.ug

# setnames(X11pell.in.state, 2:12, paste0(mid(colnames(X11pell.in.state),2,4)[2:12], '-', right(colnames(X11pell.in.state),2))[2:12])
# setnames(X11pell.out.state, 2:12, paste0(mid(colnames(X11pell.out.state),2,4)[2:12], '-', right(colnames(X11pell.out.state),2))[2:12])
################################################################################
## Step 11.03 vizualize the tables                                           ###
################################################################################
# p11a1 <- plot_ly(tail(dt_pell11_awd,11),
#                               x = ~ay, 
#                               y = ~awd_uga, 
#                          marker = list(
#                           color = '#BA0C2F'), 
#                            name = 'UGA', 
#                            type = 'bar') %>% 
#                     add_trace(y = ~awd_usa, 
#                          marker = list(
#                           color = 'dodgerblue'), 
#                            name = 'USA')  %>% 
#                    layout(title = "AVERAGE FEDERAL PELL GRANT AWARD",
#                           xaxis = list(title = "Academic Year",
#                       tickangle = -45),
#                           yaxis = list(title = "Pell Award Amount", 
#                      tickformat = "$"))
################################################################################
## Step 11.99: VERSION HISTORY                                                ###
################################################################################
a11.version <- "1.0.0"
a11.ModDate <- as.Date("2020-04-16")
# ------------------------------------------------------------------------------
# 2020.04.14 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
