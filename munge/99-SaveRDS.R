################################################################################
## Step 99.00 Save .rds files                                                ###
################################################################################
saveRDS(dt00_sc_debt,      file = "./rds/dt00_sc_debt.rds")
saveRDS(dt00_sc_default,      file = "./rds/dt00_sc_default.rds")
# ------------------------------------------------------------------------------
saveRDS(ay,                  file = "./rds/ay.rds")
saveRDS(ay_1,                file = "./rds/ay_1.rds")
saveRDS(currentAY,           file = "./rds/currentAY.rds")
saveRDS(currentAY_row,       file = "./rds/currentAY_row.rds")
# ------------------------------------------------------------------------------
saveRDS(dt_awd,              file = "./rds/dt_awd.rds")
# ------------------------------------------------------------------------------
saveRDS(dtCOA,               file = "./rds/dtCOA.rds")
saveRDS(dtCOAprior,          file = "./rds/dtCOAprior.rds")
# ------------------------------------------------------------------------------
saveRDS(fin.aid.long,        file = "./rds/fin_aid_long.rds")
saveRDS(fin.aid.wide,        file = "./rds/fin_aid_wide.rds")
# ------------------------------------------------------------------------------
saveRDS(grad_res,            file = "./rds/grad_res.rds")
saveRDS(grad_non_res,        file = "./rds/grad_non.rds")
# ------------------------------------------------------------------------------
saveRDS(c_pie_grad_non,      file = here::here("rds/", "c_pie_grad_non.rds"))
saveRDS(c_pie_grad_res,      file = here::here("rds/", "c_pie_grad_res.rds"))
# ------------------------------------------------------------------------------
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
saveRDS(X05awards.fb.0,      file = here::here("rds/", "X05awards.fb.0"))
saveRDS(X05awards.fb.1,      file = here::here("rds/", "X05awards.fb.1"))
saveRDS(X05awards.fb.2,      file = here::here("rds/", "X05awards.fb.2"))
# ------------------------------------------------------------------------------
saveRDS(X06hope.wide,        file = here::here("rds/", "dt_hope.rds"))
saveRDS(dt_hope_bar_amt,     file = here::here("rds/", "dt_hope_bar_amt.rds"))
# ------------------------------------------------------------------------------
saveRDS(X06zell.wide,        file = here::here("rds/", "dt_zell.rds"))
saveRDS(dt_zell_bar_amt,     file = here::here("rds/", "dt_zell_bar_amt.rds"))
# ------------------------------------------------------------------------------
saveRDS(dt_hz_awd,           file = here::here("rds/", "dt_hz_awd.rds"))
saveRDS(dt_hz_awd_tbl,       file = here::here("rds/", "dt_hz_awd_tbl.rds"))
# ------------------------------------------------------------------------------
saveRDS(dt_hz_tot,           file = here::here("rds/", "dt_hz_tot.rds"))
# ------------------------------------------------------------------------------
saveRDS(dt_hz_amt,           file = here::here("rds/", "dt_hz_amt.rds"))
saveRDS(dt_hz_pct,           file = here::here("rds/", "dt_hz_pct.rds"))
saveRDS(dt_hz_tbl,           file = here::here("rds/", "dt_hz_tbl.rds"))
# ------------------------------------------------------------------------------
saveRDS(dt_pell_awd,         file = here::here("rds/", "dt_pell_awd.rds"))
# ------------------------------------------------------------------------------
saveRDS(dt11_pell_in_st,     file = here::here("rds/", "dt11_pell_in_st.rds"))
saveRDS(dt11_pell_out_st,    file = here::here("rds/", "dt11_pell_out_st.rds"))
saveRDS(dt11_pell_ug,        file = here::here("rds/", "dt11_pell_ug.rds"))
# ------------------------------------------------------------------------------
saveRDS(dt12_pell_tbl[,c(1,4,6,8,10,9,11)],
                             file = here::here("rds/", "dt12_pell_tbl.rds"))
# ------------------------------------------------------------------------------
saveRDS(dt13_loan_tbl,       file = here::here("rds/", "dt13_loan_tbl.rds"))
saveRDS(dt13_loan_tbl_w,     file = here::here("rds/", "dt13_loan_tbl_w.rds"))                             
################################################################################
## Step 00.99: VERSION HISTORY                                               ###
################################################################################
a99.version <- "1.0.0"
a98.ModDate <- as.Date("2020-01-01")
# ------------------------------------------------------------------------------
# 2019.06.09 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------

