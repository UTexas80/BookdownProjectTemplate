# ------------------------------------------------------------------------------
# How Do I in R? # https://tinyurl.com/y9j67lfk
# The Janitor package https://garthtarr.github.io/meatR/janitor.html
################################################################################
## Step 00.00 Processing Start Time - start the timer                        ###
################################################################################
fin.aid.long <- janitor::clean_names(setDT(fin.aid.long))
fin.aid.long[ , avg_awd := total_aid/recipients]
fin.aid.long[ , ay_abbv := substr(fin.aid.long$ay, 3,9)]
# ------------------------------------------------------------------------------
fin.aid.wide <- janitor::clean_names(fin.aid.wide)
################################################################################
## Step 00.A: VERSION HISTORY                                                ###
################################################################################
a00.version <- "1.0.0"
a00.ModDate <- as.Date("2020-03-19")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0
# 1st release