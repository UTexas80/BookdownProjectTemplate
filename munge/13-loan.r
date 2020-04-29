# ------------------------------------------------------------------------------
# 13.00 Student and Parent Loans                                             ###
################################################################################
## Step 13.01 - clean the tables                                    ###
################################################################################
x13 <- grep("^X13", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(x13, function(nm) {
  df  <- get(nm)
  setkey(df, "id")
  setorder(df, id)
})
################################################################################
## Step 13.02 - munge the tables                                    ###
################################################################################
dt13_loan_tbl     <-  X13loan.tier[X13loan.awd] 
dt13_loan_tbl_w   <-  dcast.data.table(
                        dt13_loan_tbl, name ~ay, 
                        value.var = c('number', 'amt'))[
                        ,c(1,2,9,3,10,4,11,5,12,6,13,7,14,8,15)]
dt13_loan_tbl_bar <-  dcast.data.table(
                        X13loan.awd, ay~id, value.var = 'amt')[
                        ,c(1:4,6:8)]
data.table::setnames(dt13_loan_tbl_bar, 1:7,
  c("ay", "Perkins","DL_Sub","DL_Unsub","GRAD_Plus","Parent_Plus","Private"))
################################################################################
## Step 13.03 visualize the tables                                           ###
################################################################################
# ------------------------------------------------------------------------------ Student and Parent Loans Bar Chart
p13a_bar  <- plot_ly(dt13_loan_tbl_bar, x = ~ay,
                                        y = ~Perkins,     name = 'Perkins',     marker = list(color = '#BA0C2F'), type = 'bar')
p13a_bar  <- p13a_bar %>% add_trace(    y = ~DL_Sub,      name = 'DL Sub',      marker = list(color = '#000000'), type = 'bar')
p13a_bar  <- p13a_bar %>% add_trace(    y = ~DL_Unsub,    name = 'DL Unsub',    marker = list(color = '#7f827c'), type = 'bar')
p13a_bar  <- p13a_bar %>% add_trace(    y = ~GRAD_Plus,   name = 'GRAD Plus',   marker = list(color = '#19488a'), type = 'bar')
p13a_bar  <- p13a_bar %>% add_trace(    y = ~Parent_Plus, name = 'Parent Plus', marker = list(color = '#cc5500'), type = 'bar')
p13a_bar  <- p13a_bar %>% add_trace(    y = ~Private,     name = 'Private',     marker = list(color = '#7034FF'), type = 'bar')
p13a_bar  <- p13a_bar %>% layout(   title = paste0("UGA: Student and Parent Loans, ", 
                                                   ay[currentAY_row - (ncol(dt13_loan_tbl_bar)),2],
                                                   " through ",
                                                   ay[currentAY_row-1,2]), 
                                   xaxis  = list(
                                   title  = "Academic Year",
                               tickangle  = -45),
                                   yaxis  = list(
                                   title  = "Award Amount"),
                                 barmode  = 'group',
                              tickformat  = '$')
# ------------------------------------------------------------------------------Student and Parent Loans Line Chart
p13b_line <- plot_ly(dt13_loan_tbl_bar, x = ~ay,          type = 'scatter', mode = 'lines+markers',  yaxis = 'y2',
                                        y = ~Perkins,     name = 'Perkins',     line   = list(color = '#BA0C2F'))
p13b_line <- p13b_line %>% add_trace(   y = ~DL_Sub,      name = 'DL_Sub',      line   = list(color = '#000000'))
p13b_line <- p13b_line %>% add_trace(   y = ~DL_Unsub,    name = 'DL_Unsub',    line   = list(color = '#7f827c'))
p13b_line <- p13b_line %>% add_trace(   y = ~GRAD_Plus,   name = 'GRAD_Plus',   line   = list(color = '#19488a'))
p13b_line <- p13b_line %>% add_trace(   y = ~Parent_Plus, name = 'Parent_Plus', line   = list(color = '#cc5500'))
p13b_line <- p13b_line %>% layout(  title = paste0("UGA: Student and Parent Loans, ",
                                                   ay[currentAY_row - (ncol(dt13_loan_tbl_bar)),2],
                                                   " through ",
                                                   ay[currentAY_row-1,2]),
#                       titlefont         = list(
#                         color           = '#ffffff'),
#                       paper_bgcolor     = '#4666d1',
#                       plot_bgcolor      = '#4666d1',
                        xaxis             = list(
#                         color           = '#ffffff',
                          title           = "Academic Year",
                          tickangle       = -45),
                        yaxis             = list(
#                         color           = '#ffffff',
                          showline        = TRUE,
                          title           = "Award Amount"))
# ------------------------------------------------------------------------------ Student and Parent Loans Horizontal Bar Chart
dt13_loan_tbl_bar_h <- dt13_loan_tbl_w[,c(1,3,15)]
dt13_loan_tbl_bar_h$pct_chg <- apply( dt13_loan_tbl_bar_h[,c(2:3)], 1, 
                             function(x) { (x[2] - x[1])/x[1]})
# ------------------------------------------------------------------------------
p13c_bar <- plot_ly(dt13_loan_tbl_bar_h,
                    x = ~pct_chg,
                    y             = ~name,
                    type          = 'bar',
                    orientation   = 'h',
                    layout(title  = "UGA: Student and Parent Loans, ",
                           xaxis       = list(
                             title      = "Academic Year", 
                             tickangle  = -45,
                             tickformat = '%'),
                           yaxis       = list(title = "Tier"))
################################################################################
## Step 13.A: VERSION HISTORY                                                ###
################################################################################
a13.version         <- "1.0.0"
a13.ModDate         <- as.Date("2020-04-21")
# ------------------------------------------------------------------------------
# 2020.04.21 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
