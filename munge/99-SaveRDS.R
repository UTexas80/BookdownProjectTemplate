################################################################################
## Step 99.00 Save .rds files                                                ###
################################################################################
saveRDS(ay,                  file = "./rds/ay.rds")
saveRDS(currentAY,           file = "./rds/currentAY.rds")
saveRDS(currentAY_row,       file = "./rds/currentAY_row.rds")
# ------------------------------------------------------------------------------
saveRDS(dtCOA,               file = "./rds/dtCOA.rds")
saveRDS(dtCOAprior,          file = "./rds/dtCOAprior.rds")
# ------------------------------------------------------------------------------
saveRDS(fin.aid.long,        file = "./rds/fin_aid_long.rds")
saveRDS(fin.aid.wide,        file = "./rds/fin_aid_wide.rds")
# ------------------------------------------------------------------------------
saveRDS(grad_res,            file = "./rds/grad_res.rds")
saveRDS(grad_non_res,        file = "./rds/grad_non.rds")
# -----------------------------------------------------------------------.rds---
saveRDS(c_pie_grad_non,      file = here::here("rds/", "c_pie_grad_non.rds"))
saveRDS(c_pie_grad_res,      file = here::here("rds/", "c_pie_grad_res.rds"))
# ------------------------------------------------------------------------------
saveRDS(p4a0,                file = here::here("rds/", "p4a0.rds"))
saveRDS(p4a1,                file = here::here("rds/", "p4a1.rds"))
saveRDS(p4a2,                file = here::here("rds/", "p4a2.rds"))
# ------------------------------------------------------------------------------
saveRDS(p4b1,                file = here::here("rds/", "p4a1.rds"))
saveRDS(p4b2,                file = here::here("rds/", "p4a2.rds"))
# ------------------------------------------------------------------------------
saveRDS(pdf.tbl,             file = here::here("rds/", "pdf_tbl.rds"))
saveRDS(pdf2,                file = here::here("rds/", "pdf2.rds"))
# ------------------------------------------------------------------------------
saveRDS(X04aid.sources.long, file = here::here("rds/", "aid_sources_long.rds"))
saveRDS(X04aid.types.long,   file = here::here("rds/", "aid_types_long.rds"))
# ------------------------------------------------------------------------------
# plotly::plotly_IMAGE(p4a1, width =400, height = 400, format = "png", scale = 2,
#                     out_file = here::here("/png", "p4a1.png"))
plotly::plotly_IMAGE(p4a0, 
                    format = "png", 
                    scale =1,  
                    out_file = here::here("/png", "p4a0.png"))
################################################################################
## Step 00.99: VERSION HISTORY                                               ###
################################################################################
a99.version <- "1.0.0"
a98.ModDate <- as.Date("2019-01-01")
# ------------------------------------------------------------------------------
# 2019.06.09 - v.1.0.0
# 1st release
