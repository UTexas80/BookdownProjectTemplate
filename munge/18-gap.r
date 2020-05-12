# ------------------------------------------------------------------------------
# 18. Gap Analysis                                                           ---
# ------------------------------------------------------------------------------
################################################################################
## Step 18.00 clean the tables                                               ###
################################################################################
x18 <- grep("^X18", ls(), value = TRUE)
# ------------------------------------------------------------------------------
lapply(x18, function(nm) {
  df  <- get(nm)
  setDT(df)
  setkey(df, "id")
  setorder(df, id)
  }
)
################################################################################
## Step 18.01 - set the tables                                             ###
################################################################################
################################################################################
## Step 18.02 - viz the tables                                               ###
################################################################################
p18a1_pie <- plot_ly(X18gap.analysis[3:5, c(2, 3)], 
    labels             = ~desc, 
    values             = ~resident, 
    type               = "pie", 
    marker             = list(
    colors             = c("#BA0C2F", "#7f827c", "#000000")), 
    hole               = 0.00, 
    title              = "Resident Undergraduates with Complete FAFSAs and Need", 
    showlegend         = TRUE) %>%
  layout(
    title              = str_c(currentAY, " - GAP Analysis"), legend = list(
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
# ------------------------------------------------------------------------------
p18a2_pie <- plot_ly(X18gap.analysis[3:5, c(2, 4)], 
    labels             = ~desc, 
    values             = ~non.resident, 
    type               = "pie", 
    marker             = list(
      colors           = c("#BA0C2F", "#7f827c", "#000000")), 
    hole               = 0.00, 
    title              = "Non-Resident Undergraduates with Complete FAFSAs and Need", 
    showlegend         = TRUE) %>%
  layout(
    title              = str_c(currentAY, " - GAP Analysis"), legend = list(
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
# ------------------------------------------------------------------------------
p18a3_pie <- plot_ly(X18gap.analysis[3:5, c(2, 5)], 
    labels             = ~desc, 
    values             = ~total, 
    type               = "pie", 
    marker             = list(
      colors           = c("#BA0C2F", "#7f827c", "#000000")), 
    hole               = 0.00, 
    title              = "All Undergraduates with Complete FAFSAs and Need", 
    showlegend         = TRUE) %>%
  layout(
    title              = str_c(currentAY, " - GAP Analysis"), legend = list(
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
## Step 18.A: VERSION HISTORY                                                ###
################################################################################
a18.version           <- "1.0.0"
a18.ModDate           <- as.Date("2020-05-06")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0
# 1st release
# ------------------------------------------------------------------------------
