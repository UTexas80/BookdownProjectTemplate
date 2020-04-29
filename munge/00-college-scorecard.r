# ------------------------------------------------------------------------------
# 00. College Scorecard
# ------------------------------------------------------------------------------
################################################################################
## Step 00.00 load the dictionary                                            ###
################################################################################
dict_sc <-  setkey(
              data.table(
                sc_dict('.', print_off = TRUE, return_df = TRUE)
              ),
              varname)
################################################################################
## Step 00.01 Janitor - clean the tables                                     ###
################################################################################
# lapply(dtTables[NAME %like% "peer*" ,], function(x) janitor::clean_names(x))
# clean_col_names("peer") 
# ------------------------------------------------------------------------------
dfLs  <-  grep("MERGED(19|20)", ls(), value = TRUE)
peers <- grep("^U.*Peers$", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(dfLs, function(nm) {
  df  <- get(nm)
  #   setDT(df)[, OPEID := as.character(UNITID)]
  #    colnames(df)[1] <- "UNITID"
  setnames(df, 1, "UNITID")
  setkeyv(df, "UNITID")
  df[, ay := substr(gsub("\\.", "", nm), 9, 12)]
})
# ------------------------------------------------------------------------------
lapply(peers, function(nm) {
  df  <- get(nm)
  #    setDT(df)[, OPEID := as.integer(OPE.ID)]
  setkeyv(df, "UNITID")
})
# ------------------------------------------------------------------------------
dt_sc_peers  <- setorder(
                data.table(
                  distinct(
                    bind_rows(
                      UGaAspirationalPeers, UGaComparatorPeers, UGaSEC.Peers
                      )
                    )
                  ),
              ID, UNITID)
dt_sc_peers  <-  setkey(dt_sc_peers[, ope_id := paste0("00", as.character(OPEID))][
              , c(1,6,2:5)], OPEID)
# ------------------------------------------------------------------------------
dt_sc_uga <-  sc_init() %>%
              sc_filter(unitid == dt_sc_peers[,3]) %>%
              sc_select(unitid, instnm, stabbr, ugds, grad_debt_mdn) %>%
              sc_year('latest') %>%
              sc_get(key_get("sc_key"))
################################################################################
## Step 00.02 set the tables                                                 ###
################################################################################
dt_sc_uga <- setorder(
              setkeyv(
                setDT(
                  distinct(
                    dt_sc_uga
                  )
                ),
              "unitid"),
            unitid)
################################################################################
## Step 00.03 Amass College Scorecard debt data https://tinyurl.com/y9zutvnk ###
################################################################################
df18 <- sc_init() %>%
    sc_filter(unitid  == dt_sc_uga[,1]) %>%
    sc_select(unitid, instnm, stabbr, cdr3) %>%
    sc_year("latest") %>%
    sc_get()
df18[,5] <- '2016'
# ------------------------------------------------------------------------------
df17 <- sc_init() %>%
    sc_filter(unitid  == dt_sc_uga[,1]) %>%
    sc_select(unitid, instnm, stabbr, cdr3) %>%
    sc_year(2017) %>%
    sc_get()
df17[,5] <- '2015'
# ------------------------------------------------------------------------------
df16 <- sc_init() %>%
    sc_filter(unitid  == dt_sc_uga[,1]) %>%
    sc_select(unitid, instnm, stabbr, cdr3) %>%
#   sc_select(unitid, instnm, stabbr, cdr3, debt_mdn, dep_debt_mdn, female_debt_mdn, firstgen_debt_mdn,
#    grad_debt_mdn,hi_inc_debt_mdn, ind_debt_mdn,  lo_inc_debt_mdn, male_debt_mdn, md_inc_debt_mdn,nopell_debt_mdn,notfirstgen_debt_mdn,
#    pell_debt_mdn) %>%
    sc_year(2016) %>%
    sc_get()
df16[,5] <- '2014'
# ------------------------------------------------------------------------------
dt_sc_debt    <- setkey(
                setDT(
                  rbind(df18,df17,df16),keep.rownames = T
                  ),
                unitid)
dt_sc_peers   <- setkey(dt_sc_peers, UNITID)
dt00_sc_debt  <- setorder(dt_sc_peers[dt_sc_debt][,c(7,1,11, 6,10)],ID, rn)
dt00_sc_default <- dcast(dt00_sc_debt, year ~ INSTNM, value.var = "cdr3")
################################################################################
## Step 00.C: VERSION HISTORY                                                ###
################################################################################
c00.version <- "1.0.0"
c00.ModDate <- as.Date("2020-04-21")
# ------------------------------------------------------------------------------
# 2020.04.21 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
