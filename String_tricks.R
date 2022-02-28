# Here some code to play with strings

# Search for patters in R objects

# Searching for rownames matching patterms in a dataframe
grep(
  pattern = "Sam*",
  x = rownames(dataframe),
  value = TRUE
)

dataframe %>%
  dplyr::filter(grepl("Sam*", dataframe$SampleID))
