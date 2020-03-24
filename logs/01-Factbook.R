# ------------------------------------------------------------------------------
# url <- 'https://tinyurl.com/ybjbdpp3'                                           #Specifying the url for desired website to be scrapped
# webpage <- read_html(url)                                                       #Reading the HTML code from the website
# rank_data_html <- html_nodes(webpage,'.tableauViz')                             #Using CSS selectors to scrap the rankings section
################################################################################
## Step 00.01 process .pdf's                                                 ###
################################################################################
pdf_fb <- here::here("docs/input", "factbook_2019.pdf")                         # Define path to PDF file
pdf_fb_dat <- extract_tables(pdf_fb)                                            # Extract data table
# ------------------------------------------------------------------------------
pdf_fb_tbl <- data.table(pdf_fb_dat[[1]][-1, ])                                # Coerce output matrix to data.table
names(pdf_fb_tbl)     <- pdf_fb_dat[[1]][1, ]                                   # rename columns
names(pdf_fb_tbl)[1]  <- "Description"                                             # rename columns
# ------------------------------------------------------------------------------
pdf_fb_tbl[, c(2:4)] <- lapply(pdf_fb_tbl[, c(2:4)], 
    function(y) as.numeric(gsub('[^a-zA-Z0-9.]', '', y)))                       # https://tinyurl.com/ya4ok9tb
pdf_fb_tbl[is.na(pdf_fb_tbl)] <- ""
pdf_fb_tbl<-dplyr::mutate_if(pdf_fb_tbl, is.numeric, format_dol_fun)
pdf_fb_tbl<-pdf_fb_tbl[, c(2:4)] <-lapply(pdf_fb_tbl[, c(2:4)], 
    function(y) as.numeric(gsub('[^a-zA-Z0-9.]', '', y)))
pdf_fb_tbl[is.na(pdf_fb_tbl)] <- ""                                                   # replace NA's with spaces
# ------------------------------------------------------------------------------
names(pdf_fb_tbl)<- gsub("20","",names(pdf_fb_tbl))                                   # rename columns
# ------------------------------------------------------------------------------
fb_pg01<-datatable(data.table(pdf_fb_tbl), 
  caption='Undergraduate Cost of Attendance', 
  rownames=FALSE, 
  options = list(
    autowidth = TRUE,
    bInfo = FALSE,
    bSort = FALSE,
    class = 'dt-center',
    columnDefs = list(list(width = '175px', targets = c(0), width = '210px', targets = c(1:11))),
    colnames = NULL,
    initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
      "}"),
    options = list(dom = 'f'),
    paging = FALSE,
    rownames = FALSE,
    searching = FALSE,
    showNEntries = FALSE
))
# ------------------------------------------------------------------------------
fb_pg01<-formatCurrency(fb_pg01,2:11, digits = 0) %>%
      formatStyle(columns = c(2:11), fontSize = '100%')
fb_pg01
################################################################################
## Step 00.B: VERSION HISTORY                                                ###
################################################################################
a01.version         <- "1.0.0"
a01.ModDate         <- as.Date("2020-03-01")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0
# 1st release
