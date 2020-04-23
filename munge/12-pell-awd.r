################################################################################
## Step 12.00 Clean the tables                                               ###
## Student Aid Pell Grant Volume                https://tinyurl.com/yd4fsntd ###
################################################################################
x12 <- grep("^X12", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(x12, function(nm) {
  df  <- get(nm)
  setDT(df)[, OPEID := as.integer(OPE.ID)][
            , c(8,1:5)]
  setkey(df, "OPEID")
  setorder(df, OPEID)
})
# ------------------------------------------------------------------------------
dt12_pell_awd <-inner_join(dt_sc_peers,X12pell.awd)[,c(1,3:4,6, 12:13)]
# ------------------------------------------------------------------------------
dt12_pell_tbl <- 
  setorder(
    setDT(
      inner_join(
        dt_sc_uga, dt12_pell_awd, by = c('unitid' = 'UNITID'))[,c(7,1,8,2:5,10:11)]
    ),
  ID, unitid)
# ------------------------------------------------------------------------------
names(dt12_pell_tbl)[2:ncol(dt12_pell_tbl)] <-
  tolower(
    gsub(x = names(dt12_pell_tbl[1, -1]), 
    pattern = "PELL.YTD.", replacement = "pell_")
  )
# ------------------------------------------------------------------------------
dt12_pell_tbl[, c(6:9)] <- lapply(dt12_pell_tbl[, c(6:9)], as.integer)
# ------------------------------------------------------------------------------
dt12_pell_tbl = mutate(dt12_pell_tbl, 
                pell_pct = (pell_recipients/ugds) * 100,
                pell_avg = as.integer(pell_disbursements/pell_recipients))
# ------------------------------------------------------------------------------
setorder(dt12_pell_tbl, ID, -pell_pct)
################################################################################
## Step 12.03 visualize the tables                                           ###
################################################################################
# ------------------------------------------------------------------------------ Aspire
p12a_bar <- setorder(dt12_pell_tbl[ID == "a"], ID, -pell_pct) %>%
  plot_ly(x = ~instnm, y = ~pell_pct, type = 'bar') %>%
          layout(
            title = "Comparison of Pell Grant Recipients to Aspirational Institutions",
          xaxis          = list(
            title        = "SEC Institutions",
            tickangle    = -45),
          yaxis          = list(
            title        = "Awd Pct"),
            barmode      = 'group',
            tickformat   = '%')
# ------------------------------------------------------------------------------ Comparator
p12c_bar <- setorder(dt12_pell_tbl[ID == "c"], ID, -pell_pct) %>%
  plot_ly(x = ~instnm, y = ~pell_pct, type = 'bar') %>%
          layout(
            title = "Comparison of Pell Grant Recipients to Comparator Institutions",
          xaxis          = list(
            title        = "SEC Institutions",
            tickangle    = -45),
          yaxis          = list(
            title        = "Awd Pct"),
            barmode      = 'group',
            tickformat   = '%')
# ------------------------------------------------------------------------------ SEC
p12s_bar <- setorder(dt12_pell_tbl[ID == "c"], ID, -pell_pct) %>%
  plot_ly(x = ~instnm, y = ~pell_pct, type = 'bar') %>%
          layout(
            title = "Comparison of Pell Grant Recipients to SEC Institutions",
          xaxis          = list(
            title        = "SEC Institutions",
            tickangle    = -45),
          yaxis          = list(
            title        = "Awd Pct"),
            barmode      = 'group',
            tickformat   = '%')
################################################################################
## Step 12.A: VERSION HISTORY                                                ###
################################################################################
a12.version         <- "1.0.0"
a12.ModDate         <- as.Date("2020-04-21")
# ------------------------------------------------------------------------------
# 2020.04.21 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
