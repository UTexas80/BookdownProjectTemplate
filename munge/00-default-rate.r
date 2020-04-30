# ------------------------------------------------------------------------------
# 14. College Scorecard
# ------------------------------------------------------------------------------
################################################################################
## Step 14.00 load the dictionary                                            ###
################################################################################
dict_sc <-  setkey(
              data.table(
                sc_dict('.', print_off = TRUE, return_df = TRUE)
              ),
              varname)
################################################################################
## Step 14.01 Janitor - clean the tables                                     ###
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

dt_sc_peers  <- setorder(
  data.table(
    distinct(
      bind_rows(
        peer.aspire, peer.comparator, peer.sec
      )
    )
  ),
  id, unitid)

dt_sc_peers  <-  setkey(dt_sc_peers[, ope_id := paste0("00", as.character(opeid))][
              , c(1,7,2:4,5:6)], opeid)
# ------------------------------------------------------------------------------
dt_sc_uga <-  sc_init() %>%
              sc_filter(unitid == dt_sc_peers[,3]) %>%
              sc_select(unitid, instnm, stabbr, ugds, grad_debt_mdn) %>%
              sc_year('latest') %>%
              sc_get(key_get("sc_key"))
################################################################################
## Step 14.02 set the tables                                                 ###
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
## Step 14.03 Amass College Scorecard debt data https://tinyurl.com/y9zutvnk ###
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
dt_sc_debt           <- setkey(
                          setDT(rbind(df18,df17,df16), keep.rownames = T),
                        unitid)
dt_sc_peers          <- setkey(dt_sc_peers, unitid)
# ------------------------------------------------------------------------------
dt14_sc_debt         <- setorder(dt_sc_peers[dt_sc_debt][,c(8,1:2,4,6:7,11:12)], id, rn)
dt_sc_debt$cdr3      <- dt_sc_debt$cdr3 * 100
names(dt_sc_debt)[5] <- "default"
# ------------------------------------------------------------------------------
dt14_default         <- dcast.data.table(
                          dt14_sc_debt, year ~ abbv, 
                          value.var = "cdr3", 
                          fun.aggregate = max)
# ------------------------------------------------------------------------------
dt14_default_aspire  <- dcast.data.table(
                          dt14_sc_debt[id == 'a'], year ~ abbv, 
                          value.var = "cdr3", 
                          fun.aggregate = max)
# ------------------------------------------------------------------------------
dt14_default_compare <- dcast.data.table(
  dt14_sc_debt[id == 'c'], year ~ abbv, 
  value.var = "cdr3", 
  fun.aggregate = max)
# ------------------------------------------------------------------------------
dt14_default_sec     <- dcast.data.table(
                          dt14_sc_debt[id == 's'], year ~ abbv, 
                          value.var = "cdr3", 
                          fun.aggregate = max)
################################################################################
## Step 14.a: VERSION HISTORY                                                ###
################################################################################
a14.version          <- "1.0.0"
a14.ModDate          <- as.Date("2020-04-28")
# ------------------------------------------------------------------------------
# 2020.04.28 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
