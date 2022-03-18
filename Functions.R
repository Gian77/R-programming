# Hot to write complex functions

# Pass column name as parameter to a function using dplyr.
# Note! enquo(Var) and the double !! before each time Var appear in
# the function

GetMeans <-function(df, Var){
  Var <- enquo(Var)
result_df <-
  df %>%
  select(Class, Abund, !!Var) %>%
  mutate(Class = ifelse(is.na(Class),paste("Unclassified"),paste(Class))) %>%
  nest(-Class, -!!Var) %>%
  mutate(Abund = map(.x=data, ~colMeans(x=.), data = .x)) %>%
  unnest(Abund) %>%
  select(Class, !!Var, Abund) %>%
  pivot_wider(names_from = !!Var, values_from = Abund)
return(result_df)
}
