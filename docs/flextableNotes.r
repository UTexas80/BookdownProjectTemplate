# https://davidgohel.github.io/flextable/articles/overview.html#formatting
# Many sugar functions can be used to format flextables: bg(), fontsize(), italic(), bold(), color(), padding()…
# Conditional formatting can be made by using the selector arguments. All formatting functions are accepting selector arguments.
myft <- italic(myft, j = 1)
myft <- bg(myft, bg = "#C90000", part = "header")
myft <- color(myft, color = "white", part = "header")
myft <- color(myft, ~ drat > 3.5, ~ drat, color = "red")
myft <- bold(myft, ~ drat > 3.5, ~ drat, bold = TRUE)
myft <- autofit(myft)
myft

# Flextable borders - Vline [https://davidgohel.github.io/flextable/articles/selectors.html ]
# Selectors and flextable parts # 
# https://tinyurl.com/qvarnre

border <- officer::fp_border()
ft <- flextable(head(iris, n = 10))
ft <- vline(ft, j = c('Sepal.Length', 'Sepal.Width'), border = border, part = "all")
ft

# https://davidgohel.github.io/flextable/articles/layout.html#adjusts-manually-cell-widths-and-heights
# Function width() and height() let you control dimensions of a flextable. height_all() is an helper function to set the same height to # each part of the table.
ft <- autofit(ft_base)
ft <- width(ft, j = ~ mpg + cyl + disp, width = 2)
ft <- height_all( ft, height = .4 )
ft <- height( ft, i = 3, height = 1 )
ft

# https://davidgohel.github.io/flextable/articles/format.html#function-style

# Function style
# The style function lets you style a selection of the flextable with several formatting properties.
# Its main advantage is to let specify a set of formatting properties for a selection.
# Package officer needs to be loaded, it provides the following formatting properties:
#   for text: fp_text 
# for paragraphs: fp_par 
# for cells: fp_cell and fp_border 
library(officer)
def_cell <- fp_cell(border = fp_border(color="#00C9C9"))
def_par <- fp_par(text.align = "center")
def_text <- fp_text(color="#999999", italic = TRUE)
def_text_header <- update(color="black", def_text, bold = TRUE)

ft <- flextable(head(mtcars, n = 10 ))
ft <- style( ft, pr_c = def_cell, pr_p = def_par, pr_t = def_text, part = "all")
ft

ft <- style( ft, pr_t = def_text_header, part = "header")
ft


theme_alafoli()
theme_booktabs()
theme_box()
theme_tron()
theme_tron_legacy()
theme_vader()
theme_vanilla()
theme_zebra()