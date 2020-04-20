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
# ------------------------------------------------------------------------------
names(dt11_pell_in_st)[2:ncol(dt11_pell_in_st)] <-
  gsub(x = names(dt11_pell_in_st[1, -1]), pattern = "X*", replacement = "")
names(dt11_pell_out_st)[2:ncol(dt11_pell_out_st)] <-
  gsub(x = names(dt11_pell_out_st[1, -1]), pattern = "X*", replacement = "")
names(dt11_pell_ug)[2:ncol(dt11_pell_ug)] <-
  gsub(x = names(dt11_pell_ug[1, -1]), pattern = "X*", replacement = "")
# ------------------------------------------------------------------------------
dt11_pell_line <- cbind(melt.data.table(X11pell.in.state[3,], id = 1)[,2:3],
                        melt.data.table(X11pell.out.state[3,], id = 1)[,3])
setnames(dt11_pell_line,1:3,c("ay","in_state","out_state")) 
################################################################################
## Step 11.03 vizualize the tables                                           ###
################################################################################
# p11a1 <- plot_ly(tail(dt_pell11_awd,11),
# ------------------------------------------------------------------------------Award by Tier Line chart
p11a1 <- plot_ly(tail(dt11_pell_line, 10),
  x = ~ay, type = "scatter", mode = "lines+markers", yaxis = "y2",
  y = ~in_state, name = "In-State", line = list(color = "#BA0C2F")
) %>%
  add_trace(y = ~out_state, name = "Out-of-State", line = list(color = "#000000")) %>%
  layout(
    title = "Maximum Federal Pell Grant Award - as a % of UGA Tuition/Fees",
    xaxis = list(
      title = "Academic Year",
      tickangle = -45
    ),
    yaxis = list(
      title = "Pell Pct",
      tickformat = "%")
    )
################################################################################
## Step 11.99: VERSION HISTORY                                                ###
################################################################################
a11.version <- "1.0.0"
a11.ModDate <- as.Date("2020-04-16")
# ------------------------------------------------------------------------------
# 2020.04.14 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
