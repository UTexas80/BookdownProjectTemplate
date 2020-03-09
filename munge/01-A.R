# ------------------------------------------------------------------------------
# url <- 'https://tinyurl.com/ybjbdpp3'                                           #Specifying the url for desired website to be scrapped
# webpage <- read_html(url)                                                       #Reading the HTML code from the website
# rank_data_html <- html_nodes(webpage,'.tableauViz')                             #Using CSS selectors to scrap the rankings section
################################################################################
## Step 00.01 process .pdf's                                                 ###
################################################################################
pdf.file <- here::here("docs/input", "02UndergraduateCostOfAttendance.pdf")     # Define path to PDF file
pdf.dat <- extract_tables(pdf.file)                                             # Extract data table
# ------------------------------------------------------------------------------
pdf.tbl <- data.table(pdf.dat[[1]][-1, ])                                       # Coerce output matrix to data.table
names(pdf.tbl)     <- pdf.dat[[1]][1, ]                                         # rename columns        
names(pdf.tbl)[1]  <- "Description"                                             # rename columns  
# ------------------------------------------------------------------------------
dtCOA  <- as.data.table(pdf.dat)  
names(dtCOA)[1]<-"costs"
names(dtCOA)[2:11]<-paste0('ay', dtCOA[1,-1])                                   # rename multiple columns by index
dtCOA <- dtCOA[-1]
dtCOA[is.na(dtCOA)] <- ""                                                       # replace NA's with spaces
# ------------------------------------------------------------------------------
pdf.tbl[, c(2:11)] <- lapply(pdf.tbl[, c(2:11)], 
    function(y) as.numeric(gsub('[^a-zA-Z0-9.]', '', y)))                       # https://tinyurl.com/ya4ok9tb
pdf.tbl[is.na(pdf.tbl)] <- ""
pdf.tbl<-dplyr::mutate_if(pdf.tbl, is.numeric, format_dol_fun)
pdf.tbl<-pdf.tbl[, c(2:11)] <-lapply(pdf.tbl[, c(2:11)], 
    function(y) as.numeric(gsub('[^a-zA-Z0-9.]', '', y)))
pdf.tbl[is.na(pdf.tbl)] <- ""                                                   # replace NA's with spaces
# ------------------------------------------------------------------------------
names(pdf.tbl)<- gsub("20","",names(pdf.tbl))                                   # rename columns
# ------------------------------------------------------------------------------
pdf2<-datatable(data.table(pdf.tbl), 
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
pdf2<-formatCurrency(pdf2,2:11, digits = 0) %>%
      formatStyle(columns = c(2:11), fontSize = '100%')
pdf2
################################################################################
## Step 00.B: VERSION HISTORY                                                ###
################################################################################
a01.version         <- "1.0.0"
a01.ModDate         <- as.Date("2020-03-01")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0
# 1st release
