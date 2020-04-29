# ------------------------------------------------------------------------------
# 02. Cost of Attendance
# ------------------------------------------------------------------------------
################################################################################
## Step 02.01 Admin: munge COA files                                         ###
################################################################################
dtTables        <- data.table::tables()
sapply(dtTables[NAME %like% "coa" ,],
    function(x) janitor::clean_names(data.table(x)))
# ------------------------------------------------------------------------------
m_grad_res              <- t(setDT(coa.current)[level =='grad'&
                        residency == 'instate' &
                        campus == 'on' &
                        program == 'Regular'][,c(6:14)])
df_grad_res             <- data.frame(m_grad_res)
grad_res                <-setDT(df_grad_res, keep.rownames = 'Description')[]
names(grad_res)[2]      <- paste0("ay", currentAY)
# ------------------------------------------------------------------------------
m_grad_non_res          <- t(setDT(coa.current)[level =='grad'&
                        residency == 'outstate' &
                        campus == 'on' &
                        program == 'Regular'][,c(6:14)])
df_grad_non             <- data.frame(m_grad_non_res)
grad_non_res            <-setDT(df_grad_non, keep.rownames = 'Description')[]
names(grad_non_res)[2]  <- paste0("ay", currentAY)
# ------------------------------------------------------------------------------
coa.res$ay_yr1 <- as.Date(as.character(coa.res$ay_yr1), format = "%Y")
coa.res$ay_yr2 <- as.Date(as.character(coa.res$ay_yr2), format = "%Y")
# coa.res$ay_yr2 <- year(coa.res$ay_yr2)
# ------------------------------------------------------------------------------
################################################################################
## Step 02.02 COA tales                                                      ###
################################################################################
dtCOA  <- as.data.table(pdf.dat)
names(dtCOA)[1]<-"costs"
names(dtCOA)[2:11]<-paste0('ay', dtCOA[1,-1]) # rename multiple columns by index
dtCOA <- dtCOA[-1]

names(dtCOA)[2:ncol(dtCOA)] <-
  gsub(x = names(dtCOA[1, -1]), pattern = "ay*", replacement = "")

dtCOA[is.na(dtCOA)] <- ""                     # replace NA's with spaces
################################################################################
## Step 02.03 COA Percentage of Total Cost viz                               ###
################################################################################
p2a1 <- plot_ly(grad_res,
            labels           = ~Description,
            values           = ~ay1920,
            type             = 'pie',
            hole             = 0.00,
            domain           = list(x = c(0, 0.45)),
            title            = 'RESIDENTS',
            showlegend       = TRUE)  %>%
        add_trace(grad_non_res,
            labels           = ~Description,
            values           = ~ay1920,
            type             = 'pie', 
            hole             = 0.00,
            title            = 'NON-RESIDENTS',
            domain           = list(x = c(0.55, 1))) %>%
        layout(title         = str_c(currentAY, ' - Percentage of Total Cost for:'),
            legend           = list(
              orientation    = "h",      # show entries horizontally
              xanchor        = "center", # use center of legend as anchor
              x              = 0.5
              ),
            xaxis            = list(
              title          = "TEST",
              showgrid       = FALSE,
              zeroline       = FALSE,
              showticklabels = FALSE),
            yaxis            = list(
              title          = "TEST",
              showgrid       = FALSE,
              zeroline       = FALSE,
              showticklabels = FALSE))
# ------------------------------------------------------------------------------
c_pie_grad_res <- plot_ly(grad_res, 
        labels = ~Description, 
        values = ~ay1920, 
        type = 'pie',
        textposition = 'inside',
        textinfo = 'label+percent',
        insidetextfont = list(color = '#FFFFFF'),
        hoverinfo = 'text',
        text = ~paste('$', ay1920, ' dollars'),
        marker = list(colors = colors,
                      line = list(color = '#FFFFFF', width = 1)),
        showlegend = FALSE) %>%
  layout(title = str_c(currentAY, '-Resident Graduate COA'),
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# ------------------------------------------------------------------------------
c_pie_grad_non<- plot_ly(grad_non_res, 
        labels = ~Description, 
        values = ~ay1920, 
        type = 'pie',
        textposition = 'inside',
        textinfo = 'label+percent',
        insidetextfont = list(color = '#FFFFFF'),
        hoverinfo = 'text',
        text = ~paste('$', ay1920, ' dollars'),
        marker = list(colors = colors,
                      line = list(color = '#FFFFFF', width = 1)),

        showlegend = FALSE) %>%
  layout(title = str_c(currentAY, '-Non-Resident Graduate COA'),
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
# ------------------------------------------------------------------------------
print(c_pie_grad_res)
print(c_pie_grad_non)
# ------------------------------------------------------------------------------
dtCOAprior <- DT::datatable(coa.prior,
    rownames = FALSE,
    extensions = c("Scroller"),
    options = list(
      pageLength = 20
      ,order = list(list(0, "desc"))
      ,scrollX = TRUE
      ,scrollY = 280
      ,scroller = TRUE)
    )%>%
    formatCurrency(c(
      "X2006.07",
      "X2011.12",
      "X2012.13",
      "X2013.14",
      "X2014.15",
      "X2015.16", 
      "X2016.17",
      "X2017.18"
    ))
# ------------------------------------------------------------------------------
p02a_bar <- setorder(grad_res, -ay1920) %>%
  plot_ly(x = ~Description, y = ~ay1920, type = 'bar') %>%
  layout(
    title = "Graduate Resident Expenses",
    xaxis          = list(
      title        = "Description",
      tickangle    = -45),
    yaxis          = list(
      title        = "Amount"),
    barmode      = 'group',
    tickformat   = '$')
# ------------------------------------------------------------------------------
p02b_bar <- setorder(grad_non_res, -ay1920) %>%
  plot_ly(x = ~Description, y = ~ay1920, type = 'bar') %>%
  layout(
    title = "Graduate Non-Resident Expenses",
    xaxis          = list(
      title        = "Description",
      tickangle    = -45),
    yaxis          = list(
      title        = "Amount"),
    barmode      = 'group',
    tickformat   = '$')
################################################################################
## Step 00.99: VERSION HISTORY                                               ###
################################################################################
c01.version         <- "1.0.0"
c01.ModDate         <- as.Date("2020-03-01")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0                               http://tinyurl.com/y54k8gsw            
# 1st release                                        http://tinyurl.com/yx9w8vje
# ------------------------------------------------------------------------------


