################################################################################
## Step 99.01 create object table                                            ###
################################################################################
dtObj           <- setDT(lsos(), keep.rownames = T)[]
names(dtObj)[1] <- "Name" ### rename data.table column
# ------------------------------------------------------------------------------
dtTables        <- data.table::tables()
# ------------------------------------------------------------------------------
lsObj           <- list(dtObj[Type == "data.table" & Length_Rows == 0][, 1])
lTables         <- lsos()
################################################################################
## Step 99.02 compile list of dataframes                                     ###
################################################################################
lf              <- lapply(dtTables[,1], function(x) x)

z               <- paste0(unlist(lf), sep =",", collapse = ' ')
z               <- left(z, nchar(z)-1)
# ------------------------------------------------------------------------------
df              <- sapply(dtTables[,1], function(x) x)
# ------------------------------------------------------------------------------
dm_f            <- dm_from_data_frames(ay, 
                                       enroll.by.class.L, 
                                       enroll.by.class.w, 
                                       tbl.class, tbl.level)
graph           <- dm_create_graph(dm_f, 
                                   rankdir = "BT", 
                                   col_attr = c("column", "type"))
dm_render_graph(graph)
################################################################################
## Step 00.99: VERSION HISTORY                                               ###
################################################################################
a99.version     <- "1.0.0"
a98.ModDate     <- as.Date("2019-01-01")
# ------------------------------------------------------------------------------
# 2019.06.09 - v.1.0.0
# 1st release
