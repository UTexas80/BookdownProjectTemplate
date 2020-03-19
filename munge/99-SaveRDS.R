################################################################################
## Step 99.00 Save .rds files                                                ###
################################################################################
saveRDS(ay,             file    = "./rds/ay.rds")
saveRDS(currentAY,      file    = "./rds/currentAY.rds")
saveRDS(currentAY_row,  file    = "./rds/currentAY_row.rds")
# ------------------------------------------------------------------------------
saveRDS(dtCOA,          file    = "./rds/dtCOA.rds")
saveRDS(dtCOAprior,     file    = "./rds/dtCOAprior.rds")
# ------------------------------------------------------------------------------
saveRDS(fin.aid.long,   file    = "./rds/fin_aid_long.rds")
saveRDS(fin.aid.wide,   file    = "./rds/fin_aid_wide.rds")
# ------------------------------------------------------------------------------
saveRDS(grad_res,       file    = "./rds/grad_res.rds")
saveRDS(grad_non_res,   file    = "./rds/grad_non.rds")
# -----------------------------------------------------------------------.rds---
saveRDS(c_pie_grad_non, file    = here::here("rds/", "c_pie_grad_non.rds"))
saveRDS(c_pie_grad_res, file    = here::here("rds/", "c_pie_grad_res.rds"))
# ------------------------------------------------------------------------------
saveRDS(pdf.tbl,        file    = here::here("rds/", "pdf_tbl.rds"))
saveRDS(pdf2,           file    = here::here("rds/", "pdf2.rds"))
################################################################################
## Step 00.99: VERSION HISTORY                                               ###
################################################################################
a99.version <- "1.0.0"
a98.ModDate <- as.Date("2019-01-01")
# ------------------------------------------------------------------------------
# 2019.06.09 - v.1.0.0
# 1st release
