# How to change or rename rownames in a tidy way

library(tibble)

# Detect if a data frame has row names
has_rownames(.data)
# Remove rownames
remove_rownames(.data)

# Convert them back-and-forth between an explicit column
rownames_to_column(.data, var = "rowname")
column_to_rownames(.data, var = "rowname")

# Adds a column at the start of the dataframe of ascending sequential row ids starting at 1
rowid_to_column(.data, var = "rowid")

# How to first filter then join 2 dataframes

left_join(
  rownames_to_column(fungi_otu_rf[, sel_df_fungi_tax$OTU], var = "SampleID"),
  rownames_to_column(fungi_otu_rf %>%
                       select(last_col(
                         offset = 0:(6 - 1), everything()
                       )),
                     var = "SampleID"),
  by = "SampleID"
)


# How to sum across only numeric columns in a dataframes
fungi_otu_rf %>%
  select(.data = ., starts_with("FOTU")) %>%
  t() %>%
  as.data.frame() %>%
  mutate(Sum = rowSums(x = .)) %>%
  full_join(x = rownames_to_column(., var = "OTU"),
            y = sel_df_fungi_tax,
            by = "OTU") %>%
  arrange(., desc(Sum))


# How to calculate frequency across dataframe columns
library(dplyr)
df %>% mutate(count=rowSums(.!=0))
df %>% mutate(count=rowSums(.[1:3]!=0))
df %>% mutate(count=rowSums(select(.,starts_with("mode"))!=0))
