################################################################################
## Step 00.01 process munge & wrangle                                        ###
################################################################################
# ------------------------------------------------------------------------------
ay$desc        <- sapply(ay[, 1], function(x) paste0("20", left(x,2), "-", right(x,2)))
currentAY_row  <- as.integer(ay[, which(ay==currentAY)])
coa.res$ay_yr1 <- as.Date(as.character(coa.res$ay_yr1), format = "%Y")
coa.res$ay_yr2 <- as.Date(as.character(coa.res$ay_yr2), format = "%Y")
# coa.res$ay_yr2 <- year(coa.res$ay_yr2)
# ------------------------------------------------------------------------------
m_grad_res              <- t(coa.current[level =='grad'&
                        residency == 'instate' &
                        campus == 'on' &
                        program == 'Regular'][,c(6:14)])
df_grad_res             <- data.frame(m_grad_res)
grad_res                <-setDT(df_grad_res, keep.rownames = 'Description')[]
names(grad_res)[2]      <- paste0("ay", currentAY)
# ------------------------------------------------------------------------------
m_grad_non_res          <- t(coa.current[level =='grad'&
                        residency == 'outstate' &
                        campus == 'on' &
                        program == 'Regular'][,c(6:14)])
df_grad_non             <- data.frame(m_grad_non_res)
grad_non_res            <-setDT(df_grad_non, keep.rownames = 'Description')[]
names(grad_non_res)[2]  <- paste0("ay", currentAY)
################################################################################
## Step 00.B: VERSION HISTORY                                                ###
################################################################################
b00.version             <- "1.0.0"
b00.ModDate             <- as.Date("2020-03-01")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0
# 1st release
