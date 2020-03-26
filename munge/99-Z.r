################################################################################
## Step 99.00: VERSION HISTORY                                               ###
################################################################################
z99.version = "1.0.0"
z99.ModDate = as.Date("2020-03-01")
################################################################################
## Step 99.02 remove unwanted data.frames; e.g. 'metadata' in its name       ###
################################################################################
rm(list = ls()[grepl("(SQL|metadata)", ls())])
################################################################################
## Step 99.03: Processing                                                    ###
################################################################################
# bookdown::render_book("01-intro.Rmd", output_format = "bookdown::gitbook")
# bookdown::render_book("01-intro.Rmd", output_format = "bookdown::pdf_book")
# bookdown::render_book("01-intro.Rmd", 
#    output_format = "bookdown::powerpoint_presentation2")
bookdown::render_book("01-intro.Rmd", output_format = "bookdown::word_document2")
################################################################################
## Step 99.98: PROCESSING TIME                                               ###
################################################################################
finish.time = Sys.time()
time = finish.time - start.time
print(finish.time - start.time)
################################################################################
## Step 00.99: VERSION HISTORY                                               ###
################################################################################
z99.version             <- "1.0.0"
z99.ModDate             <- as.Date("2020-03-01")
# ------------------------------------------------------------------------------
# 2020.03.01 - v.1.0.0                               http://tinyurl.com/y54k8gsw
# 1st release                                        http://tinyurl.com/yx9w8vje
# ------------------------------------------------------------------------------


