# How to change or rename rownames in a tidy way

library(tibble)
library(tidiverse)
library(tidyr)

# Detect if a data frame has row names
df %>% has_rownames(.data)
# Remove rownames
df %>% remove_rownames(.data)

# Convert them back-and-forth between an explicit column
df %>% rownames_to_column(.data, var = "rowname")
df %>% column_to_rownames(.data, var = "rowname")

# Adds a column at the start of the dataframe of ascending sequential row ids starting at 1
df %>% rowid_to_column(.data, var = "rowid")

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
df %>%
  select(.data = ., starts_with("FOTU")) %>%
  t() %>%
  as.data.frame() %>%
  mutate(Sum = rowSums(x = .)) %>%
  full_join(x = rownames_to_column(., var = "OTU"),
            y = sel_df_fungi_tax,
            by = "OTU") %>%
  arrange(., desc(Sum))


# How to calculate frequency across dataframe columns
df %>% mutate(count=rowSums(.!=0))
df %>% mutate(count=rowSums(.[1:3]!=0))
df %>% mutate(count=rowSums(select(.,starts_with("mode"))!=0))

# How to remove any row with NA’s
df %>% na.omit()

# How to remove any row with NA’s in specific column
df %>% filter(!is.na(column_name))

# How to remove duplicates
df %>% distinct()

# How to remove rows by index position
df %>% filter(!row_number() %in% c(1, 2, 4))

# How to remove rows based on condition
df %>% filter(column1=='A' | column2 > 8)

# How to remove rows with all NAs (most intuitive solution)
df %>% filter_all(all_vars(!is.na(.)))

# How to turn a tibble into a df with row names from a variable e.g. Group
df %>% column_to_rownames(.data = ., var = "Group")

# How to rows that have NAs in all columns
df %>% filter(.data = ., rowSums(is.na(x = .)) != ncol(x = .))

# How to filter rows matching a certain string in a defined column
df %>%  filter(.data = ., !grepl("unclassified_*",Genus))

# How to substitute NA with a text
df$x %>% replace_na("unknown")
replace(is.na(.), 0)
