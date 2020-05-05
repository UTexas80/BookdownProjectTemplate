# ------------------------------------------------------------------------------
# 14. 3 Yr Cohort Default Rate Comparisons                              ###
################################################################################
## Step 14.00 Clean the tables                                               ###
################################################################################
x14 <- grep("^X14", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(x14, function(nm) {
  df  <- get(nm)
  setDT(df)[, OPEID := as.integer(OPE.ID)][
            , c(8,1:5)]
  setkey(df, "OPEID")
  setorder(df, OPEID)
})
################################################################################
## Step 14.01 Amass College Scorecard debt data https://tinyurl.com/y9zutvnk ###
################################################################################
dt_sc_debt_18        <- sc_init() %>%
    sc_filter(unitid  == dt_sc_uga[,1]) %>%
    sc_select(unitid, instnm, stabbr, cdr3) %>%
    sc_year("latest") %>%
    sc_get()
dt_sc_debt_18[,5]    <- '2016'
# ------------------------------------------------------------------------------
dt_sc_debt_17        <- sc_init() %>%
    sc_filter(unitid  == dt_sc_uga[,1]) %>%
    sc_select(unitid, instnm, stabbr, cdr3) %>%
    sc_year(2017) %>%
    sc_get()
dt_sc_debt_17[,5]    <- '2015'
# ------------------------------------------------------------------------------
dt_sc_debt_16        <- sc_init() %>%
    sc_filter(unitid  == dt_sc_uga[,1]) %>%
    sc_select(unitid, instnm, stabbr, cdr3) %>%
#   sc_select(unitid, instnm, stabbr, cdr3, debt_mdn, dep_debt_mdn, female_debt_mdn, firstgen_debt_mdn,
#    grad_debt_mdn,hi_inc_debt_mdn, ind_debt_mdn,  lo_inc_debt_mdn, male_debt_mdn, md_inc_debt_mdn,nopell_debt_mdn,notfirstgen_debt_mdn,
#    pell_debt_mdn) %>%
    sc_year(2016) %>%
    sc_get()
dt_sc_debt_16[,5]    <- '2014'
# ------------------------------------------------------------------------------
dt_sc_debt           <- setkey(
                          setDT(rbind(dt_sc_debt_18,dt_sc_debt_17,dt_sc_debt_16), keep.rownames = T),
                        unitid)
dt_sc_peers          <- setkey(dt_sc_peers, unitid)
# ------------------------------------------------------------------------------
dt_sc_debt$cdr3      <- dt_sc_debt$cdr3 * 100
names(dt_sc_debt)[5] <- "default"
################################################################################
## Step 14.02 - wrangle the tables                                           ###
################################################################################
dt14_sc_debt         <- setorder(dt_sc_peers[dt_sc_debt][
                                    ,c(8,1:2,4,6:7,11:12)], 
                                id, rn)
# ------------------------------------------------------------------------------
dt14_default         <- dcast.data.table(
                          dt14_sc_debt, year ~ abbv,
                          value.var = "default",
                          fun.aggregate = max)
dt14_default         <-cbind.data.frame(dt14_default, peer.national)[
                          ,c(1,37,21, 2:20,22:35)]
################################################################################
## Step 14.03.a - Aspirational Processing                                    ###
################################################################################
dt14_default_aspire  <- dcast.data.table(
                          dt14_sc_debt[id == 'a'], year ~ abbv,
                          value.var = "default",
                          fun.aggregate = max)
dt14_default_aspire  <- cbind(dt14_default_aspire,dt14_default[,2])[,c(1,11,5,2:4,6:10)]
data.table::setnames(dt14_default_aspire, 1:2, c("Year", "National"))
# ------------------------------------------------------------------------------
dt14_default_aspire_by_year                 <- data.table::transpose(
    dt14_default_aspire, keep.names = 'Institution')
dt14_default_aspire_by_year %>%
  row_to_names(row_number = 1)
dt14_default_aspire_by_year                 <- dt14_default_aspire_by_year[-1,]
dt14_default_aspire_by_year[, c(2:4)]       <- lapply(dt14_default_aspire_by_year[, c(2:4)], as.double)
names(dt14_default_aspire_by_year)[2]       <- 'yr2014'
names(dt14_default_aspire_by_year)[3]       <- 'yr2015'
names(dt14_default_aspire_by_year)[4]       <- 'yr2016'
################################################################################
## Step 14.03.b - Aspirational Default Rate by Institution:                  ###
## team colors https://tinyurl.com/ycj883pl                                  ###
################################################################################
p14a1_bar <- plot_ly(dt14_default_aspire, 
                                     x      = ~Year,
                                     y      = ~National,
                                     name   = 'National',
                                     marker = list(  color = '#041E42'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~`Univ. of Georgia`,
                                     name   = 'Univ. of Georgia',
                                     marker   = list(color = '#BA0C2F'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~`Pennsylvania State University`,
                                     name   = 'Penn State Univ.',
                                     marker   = list(color = '#002D62'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~`Univ. of California - Berkeley`,
                                     name   = 'UC - Berkeley',
                                     marker = list(color = '#FFC72C'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~`Univ. of California - Los Angeles`,
                                     name   = 'UCLA',
                                     marker = list(color = '#2D68C4'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~`Univ. of Illinois at Urbana-Champaign`,
                                     name   = 'Univ. of Illinois',
                                     marker = list(color = '#E84A27'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~ `Univ. of Michigan - Ann Arbor`,
                                     name   = 'Univ. of Michigan',
                                     marker = list(color = '#FFCB05'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~ `Univ. of Minnesota - Twin Cities`,
                                     name   = 'Univ. of Minnesota.',
                                     marker = list(color = '#862334'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~ `Univ. of Texas at Austin`,
                                     name   = 'Univ. of Texas - Austin',
                                     marker = list(color = '#BF5700'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% add_trace(y      = ~ `Univ. of Virginia`,
                                     name   = 'Univ. of Virginia',
                                     marker = list(color = '#232D4B'),
                                     type   = 'bar')
p14a1_bar <- p14a1_bar %>% layout(title     =  "UGA: Aspirational Cohort Default Rate by Year",
                                  xaxis           = list(
                                    title         = "Academic Year",
                                    tickangle     = -45),
                                  yaxis           = list(
                                    title         = "Default Rate"),
                                  barmode         = 'group',
                                  tickformat      = '%')
################################################################################
## Step 14.03.c - Aspirational Default Rate by Year                          ###
################################################################################
p14a2_bar <- plot_ly(dt14_default_aspire_by_year,
                     x      = ~Institution,
                     y      = ~yr2014,
                     name   = '2014',
                     type   = 'bar')
p14a2_bar <- p14a2_bar %>% add_trace(y      = ~yr2015,
                                     name   = '2015')
p14a2_bar <- p14a2_bar %>% add_trace(y      = ~yr2016,
                                     name   = '2016')
p14a2_bar <- p14a2_bar %>% layout(title     = "UGA: Aspirational Cohort Default Rate by Year",
                                  xaxis           = list(
                                    title        = "Institution",
                                    tickangle        = -45),
                                  yaxis             = list(
                                    title        = "Default Rate"),
                                  barmode        = 'group',
                                  tickformat        = '%')
################################################################################
## Step 14.04.a - Comparator Processing                                      ###
################################################################################
dt14_default_compare                        <- dcast.data.table(
                          dt14_sc_debt[id == 'c'], year ~ abbv,
                          value.var = "default",
                          fun.aggregate = max)
dt14_default_compare                        <- cbind(dt14_default_compare,dt14_default[,2])[,c(1,18,12,2:11,13:17)]
data.table::setnames(dt14_default_compare, 1:2, c("Year", "National"))
# ------------------------------------------------------------------------------
dt14_default_compare_by_year                <- data.table::transpose(
    dt14_default_compare, keep.names = 'Institution')
dt14_default_compare_by_year %>%
  row_to_names(row_number = 1)
dt14_default_compare_by_year                <- dt14_default_compare_by_year[-1,]
dt14_default_compare_by_year[, c(2:4)]      <- lapply(dt14_default_compare_by_year[, c(2:4)], as.double)
names(dt14_default_compare_by_year)[2]      <- 'yr2014'
names(dt14_default_compare_by_year)[3]      <- 'yr2015'
names(dt14_default_compare_by_year)[4]      <- 'yr2016'
################################################################################Comparator
## Step 14.04.b - Comparator Default Rate by Institution:                    ###
## team colors https://tinyurl.com/ycj883pl                                  ###
################################################################################
p14b1_bar <- plot_ly(dt14_default_compare,x = ~Year,
                                      y     = ~National,
                                      name  = 'National',
                                    marker  = list(color = '#041E42'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~`Univ. of Georgia`,
                                     name   = 'Univ. of Georgia',
                                   marker   = list(color = '#BA0C2F'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~`Indiana Univ. - Bloomington`,
                                     name   = 'Indiana Univ.',
                                   marker   = list(color = '#EDEBEB'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~`Iowa State Univ.`,
                                     name   = 'Iowa State Univ.',
                                     marker = list(color = '#F1BE48'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~`Michigan State Univ.`,
                                     name   = 'Michigan State Univ.',
                                     marker = list(color = '#18453B'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~`North Carolina State Univ.`,
                                     name   = 'North Carolina State Univ.',
                                     marker = list(color = '#CC0000'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Ohio State Univ.`,
                                     name   = 'Ohio State Univ.',
                                     marker = list(color = '#B0B7BC'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Purdue Univ.`,
                                     name   = 'Purdue Univ.',
                                     marker = list(color = '#CEB888'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Stony Brook Univ.`,
                                     name   = 'Stony Brook Univ.',
                                     marker = list(color = '#16243E'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Univ. of Arizona`,
                                     name   = 'Univ. of Arizona',
                                     marker = list(color = '#AB0520'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Univ. of California - Davis`,
                                     name   = 'UC -Davis',
                                     marker = list(color = '#B3A369'),
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Univ. of Florida`,
                                     name   = 'Univ. of Florida', 
                                     marker = list(color = '#FA4616'), 
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Univ. of Iowa`,
                                     name   = 'Univ. of Iowa', 
                                     marker = list(color = '#FCD116'), 
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Univ. of Kentucky`,
                                     name   = 'Univ. of Kentucky', 
                                     marker = list(color = '#0033A0'), 
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Univ. of Maryland - College Park`,
                                     name   = 'Univ. of Maryland', 
                                     marker = list(color = '#CF102D'), 
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Univ. of Missouri`,
                                     name   = 'Univ. of Missouri', 
                                     marker = list(color = '#C69214'), 
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% add_trace(y      = ~ `Virginia Tech`,
                                     name   = 'Virginia Tech', 
                                     marker = list(color = '#6A2C3E'), 
                                     type   = 'bar')
p14b1_bar <- p14b1_bar %>% layout(title     =  "UGA: Comparator Cohort Default Rate by Year",
                            xaxis           = list(
                              title         = "Academic Year",
                              tickangle     = -45),
                            yaxis           = list(
                              title         = "Default Rate"),
                            barmode         = 'group',
                            tickformat      = '%')
################################################################################
## Step 14.04.c - Comparator Default Rate by Year                            ###
################################################################################
p14b2_bar <- plot_ly(dt14_default_compare_by_year,
                                     x      = ~Institution,
                                     y      = ~yr2014,
                                     name   = '2014',
                                     type   = 'bar')
p14b2_bar <- p14b2_bar %>% add_trace(y      = ~yr2015,
                                     name   = '2015')
p14b2_bar <- p14b2_bar %>% add_trace(y      = ~yr2016,
                                     name   = '2016')
p14b2_bar <- p14b2_bar %>% layout(title     = "UGA: Comparator Cohort Default Rate by Year",
                            xaxis           = list(
                               title        = "Institution",
                           tickangle        = -45),
                          yaxis             = list(
                               title        = "Default Rate"),
                             barmode        = 'group',
                          tickformat        = '%')
################################################################################
## Step 14.05.a - SEC Processing                                             ###
################################################################################
dt14_default_sec     <- dcast.data.table(
                          dt14_sc_debt[id == 's'], year ~ abbv,
                          value.var = "default",
                          fun.aggregate = max)
dt14_default_sec     <- cbind(dt14_default_sec,dt14_default[,2])[,c(1,16,9,2:8,10:15)]
data.table::setnames(dt14_default_sec, 1:2, c("Year", "National"))
# ------------------------------------------------------------------------------
dt14_default_sec_by_year                    <- data.table::transpose(
    dt14_default_sec, keep.names = 'Institution')
dt14_default_sec_by_year %>%
  row_to_names(row_number = 1)
# setnames(dt14_default_sec_by_year,
#    as.character(dt14_default_sec_by_year[1,]))
# dt14_default_sec_by_year                  <- dt14_default_sec_by_year[-1,]
dt14_default_sec_by_year                    <- dt14_default_sec_by_year[-1,]
dt14_default_sec_by_year[, c(2:4)]          <- lapply(dt14_default_sec_by_year[, c(2:4)], as.double)
names(dt14_default_sec_by_year)[2]          <- 'yr2014'
names(dt14_default_sec_by_year)[3]          <- 'yr2015'
names(dt14_default_sec_by_year)[4]          <- 'yr2016'
################################################################################
## Step 14.05.b - SEC Default Rate by Institution:                           ###
## team colors https://tinyurl.com/ycj883pl                                  ###
################################################################################
p14c1_bar <- plot_ly(dt14_default_sec,x     = ~Year,
                                      y     = ~National,
                                      name  = 'National',
                                    marker  = list(color = '#041E42'),
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~`Univ. of Georgia`,
                                     name   = 'Univ. of Georgia', 
                                   marker   = list(color = '#BA0C2F'),
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~`Auburn Univ.`,
                                     name   = 'Auburn Univ.',
                                   marker   = list(color = '#E87722'),
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~LSU,
                                     name   = 'LSU',
                                     marker = list(color = '#461D7C'),
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~`Mississippi State`,
                                     name   = 'Mississippi St.', 
                                     marker = list(color = '#75787B'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~`Texas A&M`,
                                     name   = 'Texas A&M', 
                                     marker = list(color = '#500000'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of Alabama`,
                                     name   = 'Univ. of Alabama', 
                                     marker = list(color = '#A60C31'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of Arkansas`,
                                     name   = 'Univ. of Arkansas', 
                                     marker = list(color = '#9D2235'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of Florida`,
                                     name   = 'Univ. of Florida', 
                                     marker = list(color = '#FA4616'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of Kentucky`,
                                     name   = 'Univ. of Kentucky', 
                                     marker = list(color = '#0033A0'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of Mississippi`,
                                     name   = 'Univ. of Mississippi', 
                                     marker = list(color = '#CE1126'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of Missouri`,
                                     name   = 'Univ. of Missouri', 
                                     marker = list(color = '#C69214'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of S. Carolina`,
                                     name   = 'Univ. of South Carolina', 
                                     marker = list(color = '#73000A'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Univ. of Tennessee`,
                                     name   = 'Univ. of Tennessee', 
                                     marker = list(color = '#FF8200'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% add_trace(y      = ~ `Vanderbilt Univ.`,
                                     name   = 'Vanderbilt', 
                                     marker = list(color = '#A8996E'), 
                                     type   = 'bar')
p14c1_bar <- p14c1_bar %>% layout(title     =  "UGA: SEC Cohort Default Rate by Year",
                            xaxis           = list(
                              title         = "Academic Year",
                              tickangle     = -45),
                            yaxis           = list(
                              title         = "Default Rate"),
                            barmode         = 'group',
                            tickformat      = '%')
################################################################################
## Step 14.05.c - SEC Default Rate by Year                                   ###
################################################################################
p14c2_bar <- plot_ly(dt14_default_sec_by_year,
                                     x      = ~Institution,
                                     y      = ~yr2014,
                                     name   = '2014',
                                     type   = 'bar')
p14c2_bar <- p14c2_bar %>% add_trace(y      = ~yr2015,
                                     name   = '2015')
p14c2_bar <- p14c2_bar %>% add_trace(y      = ~yr2016,
                                     name   = '2016')
p14c2_bar <- p14c2_bar %>% layout(title     = "UGA: SEC Cohort Default Rate by Year",
                            xaxis           = list(
                               title        = "Institution",
                           tickangle        = -45),
                          yaxis             = list(
                               title        = "Default Rate"),
                             barmode        = 'group',
                          tickformat        = '%')
################################################################################
## Step 14.a: VERSION HISTORY                                                ###
################################################################################
a14.version          <- "1.0.0"
a14.ModDate          <- as.Date("2020-04-28")
# ------------------------------------------------------------------------------
# 2020.04.28 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------                          