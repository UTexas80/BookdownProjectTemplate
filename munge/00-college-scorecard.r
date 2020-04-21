# ------------------------------------------------------------------------------
# 00. College Scorecard
# ------------------------------------------------------------------------------
################################################################################
## Step 00.01 Janitorr - clean the tables                                    ###
################################################################################
# lapply(dtTables[NAME %like% "peer*" ,], function(x) janitor::clean_names(x))
# clean_col_names("peer") 
# ------------------------------------------------------------------------------
dfLs <-  grep("MERGED(19|20)", ls(), value = TRUE)
peers <- grep("^U.*Peers$", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(dfLs, function(nm) {
  df <- get(nm)
  #   setDT(df)[, OPEID := as.character(UNITID)]
  #    colnames(df)[1] <- "UNITID"
  setnames(df, 1, "UNITID")
  setkeyv(df, "UNITID")
  df[, ay := substr(gsub("\\.", "", nm), 9, 12)]
})
# ------------------------------------------------------------------------------
lapply(peers, function(nm) {
  df <- get(nm)    
  #    setDT(df)[, OPEID := as.character(UNITID)]
  setkeyv(df, "UNITID")
})
# ------------------------------------------------------------------------------
dt_peers <- setorder(
              setkeyv(
                data.table(
                  distinct(
                    bind_rows(
                      UGaAspirationalPeers, UGaComparatorPeers, UGaSEC.Peers
                      )
                    )
                  ), 
                "UNITID"),
              ID, UNITID)
# ------------------------------------------------------------------------------              
sc_key = ('2z7hOeXJ7YNjkzAf4rwJwtxhcUNG1tw33nYoJdbz')
dt_sc   <-  sc_init() %>% 
            sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) %>% 
            sc_select(unitid, instnm, stabbr) %>% 
            sc_year("latest") %>% 
            sc_get('2z7hOeXJ7YNjkzAf4rwJwtxhcUNG1tw33nYoJdbz')
################################################################################
## Step 00.02 set the tables                                                 ###
################################################################################
setkey(X05awards.fb.0, key)
setkey(X05awards.fb.1, key)
################################################################################
## Step 00.C: VERSION HISTORY                                                ###
################################################################################
c00.version <- "1.0.0"
c00.ModDate <- as.Date("2020-04-21")
# ------------------------------------------------------------------------------
# 2020.04.21 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
