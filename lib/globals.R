# Add any project specific configuration here.
add.config(
  apply.override = FALSE
)
# ------------------------------------------------------------------------------
Sys.setenv('sc_key' = '2z7hOeXJ7YNjkzAf4rwJwtxhcUNG1tw33nYoJdbz')
# ------------------------------------------------------------------------------
currentYr        <- as.numeric(format(Sys.Date(), format = "%y"))
currentYr4       <- as.numeric(format(Sys.Date(), format = "%Y"))
lastYr           <- as.numeric(format(Sys.Date(), format = "%y")) - 1
LastYr4          <- as.numeric(format(Sys.Date(), format = "%Y")) - 1
currentAY        <- as.numeric(paste(lastYr, currentYr, sep = ""))
# ------------------------------------------------------------------------------
ay               <- data.table(sprintf("%04d", seq(0001,9899, by = 101)))
names(ay)[1] <- "ay" # rename column name by index
# ------------------------------------------------------------------------------
gap_col          <- c(1:3, 14, 15, 26, 27, 38)
gap_col_names    <- c("x1617", "x1617Gap","x1718", "x1718Gap","x1819", "x1819Gap")
gap_cond         <- ("Ecology|Forestry|Pharmacy|Public Health|Social Work")
# ------------------------------------------------------------------------------
gift_col         <- c(1:3, 5, 15, 17, 27, 29)
gift_col_names   <- c("x1617", "x1617Gift","x1718", "x1718Gift","x1819", "x1819Gift")
gift_cond        <- ("Ecology|Env a|Forestry|Pharmacy|Public Health|Social Work")
# ------------------------------------------------------------------------------