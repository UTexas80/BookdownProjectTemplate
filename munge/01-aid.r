# ------------------------------------------------------------------------------
# 01. Student Financial Aid Summary                                          ---
# ------------------------------------------------------------------------------
################################################################################
## Step 01.01 clean the tables                                               ###
################################################################################
x01 <- grep("^X01", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(x01, function(nm) {
  df  <- get(nm)
  setDT(df)
  setkey(df, "id")
  setorder(df, id)
  }
)
################################################################################
## Step 01.02 - set the tables                                               ###
################################################################################
dt01_debt                    <- X01aid.debt
# ------------------------------------------------------------------------------
names(dt01_debt)[2:ncol(dt01_debt)] <-              #remove X from Academic Year
  gsub(x = names(dt01_debt[1, -1]), pattern = "X*", replacement = "")
# names(dt01_debt)[2:ncol(dt01_debt)] <-          #remove '.' from Academic Year
#   gsub(x = names(dt01_debt[1, -1]), pattern = "\\.", replacement = "_")
# ------------------------------------------------------------------------------
dt01_coa                     <- as.data.table(pdf.dat)
names(dt01_coa)              <- as.character(dt01_coa[1,])
dt01_coa                     <- dt01_coa[-1]
dt01_coa[is.na(dt01_coa)]    <- ""
# ------------------------------------------------------------------------------
dt01_aid_coa_res             <- coa.res[,c(7,3:6)]
dt01_aid_coa_res             <- data.table::melt.data.table(
                                  tail(dt01_aid_coa_res[,-1],1),measure.vars = 1:4)
names(dt01_aid_coa_res)[1:2] <- c("desc", "Resident")
# ------------------------------------------------------------------------------
dt01_aid_coa_non             <- dt01_coa[8:11,c(1,11)]
names(dt01_aid_coa_non)[1:2] <- c("desc", "NonResident")
dt01_aid_coa_non$NonResident <-
  as.numeric(                                          # replace $, , wiht blank
    gsub(",", "",
      gsub("\\.", "",
        gsub("\\$", "",
  dt01_aid_coa_non$NonResident))))
dt01_aid_coa <- cbind(dt01_aid_coa_non, dt01_aid_coa_res[,2])[,c(1,3,2)]
################################################################################
## Step 01.03 viz the tables                                                 ###
################################################################################
p01a1_pie <- plot_ly(dt01_aid_coa,
      labels           = ~desc,
      values           = ~Resident,
      type             = "pie",
      marker           = list(
        colors         = c("#BA0C2F", "#7f827c", "#000000", "#4666d1")),
      hole             = 0.00,
      domain           = list(x = c(0, 0.45)),
      title            = "Resident On-Campus",
      showlegend       = TRUE) %>%
  add_trace(dt01_aid_coa,
      labels           = ~desc,
      values           = ~NonResident,
      type             = 'pie',
      marker           = list(
        colors         = c("#BA0C2F", "#7f827c", "#000000", "#4666d1")),
      hole             = 0.00,
      domain           = list(x = c(0.55, 1)),
      title            = 'Non-Resident On-Campus') %>%
  layout(
    title              = str_c(ay[currentAY_row,2], ": Undergraduates Cost of Attendance"),
      legend = list(
        orientation      = "h",      # show entries horizontally
        xanchor          = "center", # use center of legend as anchor
        x                = 0.5),
    xaxis           = list(
      title            = "",
      showgrid         = FALSE,
      zeroline         = FALSE,
      showticklabels   = FALSE
    ),
    yaxis              = list(
      title            = "",
      showgrid         = FALSE,
      zeroline         = FALSE,
      showticklabels   = FALSE
    )
  )
# ------------------------------------------------------------------------------
p01b1_pie <- plot_ly(X01aid.tot.aid[, -1],
    labels             = ~desc,
    values             = ~amount,
    text               = ~dollar(amount),    
    type               = "pie",
    marker             = list(
      colors           = c("#BA0C2F", "#000000", "#7f827c")),
    hole               = 0.00,
    title              = "All Students",
    showlegend         = TRUE) %>%
  layout(
    title              = str_c(ay[currentAY_row,2], ": Total Student Aid"),
    legend = list(
      orientation      = "h", # show entries horizontally
      xanchor          = "center", # use center of legend as anchor
      x                = 0.5
    ), xaxis           = list(
      title            = "",
      showgrid         = FALSE,
      zeroline         = FALSE,
      showticklabels   = FALSE
    ),
    yaxis              = list(
      title            = "",
      showgrid         = FALSE,
      zeroline         = FALSE,
      showticklabels   = FALSE
    )
  )
# -----------------------------------------------------------------------------
p01c1_pie <- plot_ly(X01aid.source[, -1],
    labels             = ~desc,
    values             = ~amount,
    text               = ~dollar(amount),
    type               = "pie",
    marker             = list(
      colors           = c('#19488a', "#000000", "#7f827c", "#BA0C2F")),
    hole               = 0.00,
    title              = "All Students",
    showlegend         = TRUE) %>%
  layout(
    title              = str_c(ay[currentAY_row,2], ": Undergraduate Scholarships & Grants by Source"),
    legend = list(
      orientation      = "h", # show entries horizontally
      xanchor          = "center", # use center of legend as anchor
      x                = 0.5
    ), xaxis           = list(
      title            = "",
      showgrid         = FALSE,
      zeroline         = FALSE,
      showticklabels   = FALSE
    ),
    yaxis              = list(
      title            = "",
      showgrid         = FALSE,
      zeroline         = FALSE,
      showticklabels   = FALSE
    )
  )  
################################################################################
## Step 01.A: VERSION HISTORY                                                ---
################################################################################
a01.version            <- "1.0.0"
a01.ModDate            <- as.Date("2020-05-12")
# ------------------------------------------------------------------------------
# 2020.05.12 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
