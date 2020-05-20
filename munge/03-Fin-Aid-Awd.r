# ------------------------------------------------------------------------------
# 03. Financial Aid Awarded to Students - Five-Year Comparison               ---
# ------------------------------------------------------------------------------
################################################################################
## Step 03.00 clean the tables                                               ###
################################################################################
x03 <- grep("^X03", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(x03, function(nm) {
  df  <- get(nm)
  setDT(df)
  setkey(df, "id")
  setorder(df, id)
  }
)
################################################################################
## Step 03.01 Janitor - clean the tables                                     ###
################################################################################
X03aid.long <- janitor::clean_names(setDT(X03aid.long))
X03aid.long[ , avg_awd := total_aid/recipients]
X03aid.long[ , ay_abbv := substr(X03aid.long$ay, 3,9)]
# ------------------------------------------------------------------------------
X03aid.wide <- janitor::clean_names(X03aid.wide)
################################################################################
## Step 03.03 visualize the tables                                           ###
################################################################################
p03a1_bar <- setorder(X03aid.long[level == "undergrad"],ay) %>%
  plot_ly(x = ~ay, 
          y = ~avg_awd, 
          marker = list(color = '#BA0C2F'), 
          name = 'Undergrad', 
          type = 'bar') %>%
    layout(
      title = "Average Award Per Recipient: Undergraduate Student",
    xaxis          = list(
      title        = "Academic Year",
      tickangle    = -45),
    yaxis          = list(
      title        = "Awd Amt"),
      barmode      = 'group',
      tickformat   = '%')
p03a2_bar <- setorder(X03aid.long[level == "graduate"],ay) %>%
  plot_ly(x = ~ay, 
          y = ~avg_awd, 
          marker = list(color = '#000000'), 
          name = 'Graduate', 
          type = 'bar') %>%
    layout(
      title = "Average Award Per Recipient: Graduate Student",
      xaxis          = list(
        title        = "Academic Year",
        tickangle    = -45),
      yaxis          = list(
        title        = "Awd Amt"),
      barmode      = 'group',
      tickformat   = '%')
plotly::subplot(p03a1_bar, p03a2_bar)
################################################################################
## Step 00.A: VERSION HISTORY                                                ###
################################################################################
a03.version <- "1.0.0"
a03.ModDate <- as.Date("2020-03-19")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
