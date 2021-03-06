helper.function <- function()
{
  return(1)
}
################################################################################
# Replicate left, mid, right formulas               https://tinyurl.com/yyq62obr
################################################################################
left = function(text, num_char) {
  substr(text, 1, num_char)
}

mid = function(text, start_num, num_char) {
  substr(text, start_num, start_num + num_char - 1)
}

right = function(text, num_char) {
  substr(text, nchar(text) - (num_char-1), nchar(text))
}

clean_col_names <- function(dt_name) {
  dt <- as.data.table( as.table(sapply(dtTables[NAME %like% paste0(dt_name,"*") ,][,1], function(x) x)))[,3]
  for(i in 1:nrow(dt)) {
    dt[i,] <<- clean_names( dt[i,])
  }  
}
################################################################################
# Remove 'x' from ay column names                  https://tinyurl.com/y9grewde
################################################################################
remove_x <- function(x) {
  names(x) <- gsub(x = names(x), pattern = "\\.", replacement = "_")
  names(x) <- gsub(x = names(x), pattern = "X*", replacement = "")
  names(x) <- gsub(x = names(x), pattern = "ay*", replacement = "")
  names(x)[2:ncol(x)] <- gsub(x = names(x[1,-1]), pattern = "ay*", replacement = "")
  names(x)[2:ncol(x)] <- gsub(x = names(x[1,-1]), pattern = "X*", replacement = "")
  names(x)[2:ncol(x)] <- gsub(x = names(x[1,-1]), pattern = "201*", replacement = "yr201")
}
# ------------------------------------------------------------------------------
format_dol_fun <- function(x){
  ifelse(x < 0,
         paste0('(', scales::dollar(-x, digits = 0), ')'),
         scales::dollar(x))
}

#S3 print method for the class    
print.money <- function(x, ...) {
  print.default(paste0("$", formatC(as.numeric(x), format="f", digits=0, big.mark=",")))
}

#format method, which is necessary for formating in a data.frame
format.money  <- function(x, ...) {
  paste0("$", formatC(as.numeric(x), format="f", digits=0, big.mark=","))
}
################################################################################
# Tricks to manage available memory in an R session https://tinyurl.com/yxcttpsa
################################################################################
.ls.objects <- function (pos = 1, pattern, order.by,
                         decreasing=FALSE, head=FALSE, n=5) {
    napply <- function(names, fn) sapply(names, function(x)
      fn(get(x, pos = pos)))
    names <- ls(pos = pos, pattern = pattern)
    obj.class <- napply(names, function(x) as.character(class(x))[1])
    obj.mode <- napply(names, mode)
    obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
    obj.prettysize <- napply(names, function(x) {
      format(utils::object.size(x), units = "auto") })
    obj.size <- napply(names, object.size)
    obj.dim <- t(napply(names, function(x)
      as.numeric(dim(x))[1:2]))
    vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
    obj.dim[vec, 1] <- napply(names, length)[vec]
    out <- data.frame(obj.type, obj.size, obj.prettysize, obj.dim)
    names(out) <- c("Type", "Size", "PrettySize", "Length_Rows", "Columns")
    if (!missing(order.by))
      out <- out[order(out[[order.by]], decreasing=decreasing), ]
    if (head)
      out <- head(out, n)
    out
}

# shorthand improved list of objects
lsos <- function(..., n=100) {
  .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}
################################################################################
# Duplicates between groups
# http://www.cookbook-r.com/Manipulating_data/Comparing_data_frames/
################################################################################
dupsBetweenGroups <- function (df, idcol) {
    # df: the data frame
    # idcol: the column which identifies the group each row belongs to

    # Get the data columns to use for finding matches
    datacols <- setdiff(names(df), idcol)

    # Sort by idcol, then datacols. Save order so we can undo the sorting later.
    sortorder <- do.call(order, df)
    df <- df[sortorder,]

    # Find duplicates within each id group (first copy not marked)
    dupWithin <- duplicated(df)

    # With duplicates within each group filtered out, find duplicates between groups.
    # Need to scan up and down with duplicated() because first copy is not marked.
    dupBetween = rep(NA, nrow(df))
    dupBetween[!dupWithin] <- duplicated(df[!dupWithin,datacols])
    dupBetween[!dupWithin] <- duplicated(df[!dupWithin,datacols], fromLast=TRUE) | dupBetween[!dupWithin]

    # ============= Replace NA's with previous non-NA value ==============
    # This is why we sorted earlier - it was necessary to do this part efficiently

    # Get indexes of non-NA's
    goodIdx <- !is.na(dupBetween)

    # These are the non-NA values from x only
    # Add a leading NA for later use when we index into this vector
    goodVals <- c(NA, dupBetween[goodIdx])

    # Fill the indices of the output vector with the indices pulled from
    # these offsets of goodVals. Add 1 to avoid indexing to zero.
    fillIdx <- cumsum(goodIdx)+1

    # The original vector, now with gaps filled
    dupBetween <- goodVals[fillIdx]

    # Undo the original sort
    dupBetween[sortorder] <- dupBetween

    # Return the vector of which entries are duplicated across groups
    return(dupBetween)
}

# How to run multiple functions one after another?
`%@%` <- function(x, f) eval.parent(as.call(append(as.list(substitute(f)), list(x), 1))) # https://tinyurl.com/qo443mb
# f(trend_ind); f(dT.metrics); f(dT.rules) # https://tinyurl.com/rkmef5n
