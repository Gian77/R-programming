# Settingup the work environemnt

# Displaied lines and decimal numbers
options(scipen = 999)
options(max.print = 100000000)

# Remove objects from the working environment
rm(list = ls(all=TRUE)) # removes all variables in the global environment so you start fresh
rm(list= ls()[!(ls() %in% c('keepThis','andThis'))])

# Check time and date
Sys.time() # prints out the time and date you ran the code

# Detocuh packages
detach(package:phyloseq, unload = TRUE)

# Search and information
search()
session.info()

# Citation resourches
citation()
version$version.string
devtools::session_info()
print(citation("MASS"), style = "text")
library(purrr)
c("vegan", "phyloseq", "ape") %>%
  map(citation) %>%
  print(style = "text")
