# modified from https://stackoverflow.com/questions/8161836/how-do-i-replace-na-values-with-zeros-in-an-r-dataframe

baseR.sbst.rssgn   <- function(x) { x[is.na(x)] <- 0; x }
baseR.replace      <- function(x) { replace(x, is.na(x), 0) }
baseR.for          <- function(x) { for(j in 1:ncol(x)) x[[j]][is.na(x[[j]])] = 0 }

# tidyverse
## dplyr
dplyr_if_else      <- function(x) { mutate_all(x, ~if_else(is.na(.), 0, .)) }
dplyr_coalesce     <- function(x) { mutate_all(x, ~coalesce(., 0)) }

## tidyr
tidyr_replace_na   <- function(x) { replace_na(x, as.list(setNames(rep(0, 10), as.list(c(paste0("var", 1:10)))))) }

## hybrid
hybrd.ifelse     <- function(x) { mutate_all(x, ~ifelse(is.na(.), 0, .)) }
hybrd.replace_na <- function(x) { mutate_all(x, ~replace_na(., 0)) }
hybrd.replace    <- function(x) { mutate_all(x, ~replace(., is.na(.), 0)) }
hybrd.rplc_at.idx<- function(x) { mutate_at(x, c(1:10), ~replace(., is.na(.), 0)) }
hybrd.rplc_at.nse<- function(x) { mutate_at(x, vars(var1:var10), ~replace(., is.na(.), 0)) }
hybrd.rplc_at.stw<- function(x) { mutate_at(x, vars(starts_with("var")), ~replace(., is.na(.), 0)) }
hybrd.rplc_at.ctn<- function(x) { mutate_at(x, vars(contains("var")), ~replace(., is.na(.), 0)) }
hybrd.rplc_at.mtc<- function(x) { mutate_at(x, vars(matches("\\d+")), ~replace(., is.na(.), 0)) }
hybrd.rplc_if    <- function(x) { mutate_if(x, is.numeric, ~replace(., is.na(.), 0)) }

# data.table
library(data.table)
DT.for.set.nms   <- function(x) { for (j in names(x))
    set(x,which(is.na(x[[j]])),j,0) }
DT.for.set.sqln  <- function(x) { for (j in seq_len(ncol(x)))
    set(x,which(is.na(x[[j]])),j,0) }
DT.nafill        <- function(x) { nafill(df, fill=0)}
DT.setnafill     <- function(x) { setnafill(df, fill=0)}

library(microbenchmark)
# 20% NA filled dataframe of 10 Million rows and 10 columns
set.seed(42) # to recreate the exact dataframe
dfN <- as.data.frame(matrix(sample(c(NA, as.numeric(1:4)), 1e7*10, replace = TRUE),
                            dimnames = list(NULL, paste0("var", 1:10)),
                            ncol = 10))
# Running 600 trials with each replacement method
# (the functions are excecuted locally - so that the original dataframe remains unmodified in all cases)
perf_results <- microbenchmark(
    hybrid.ifelse    = hybrid.ifelse(copy(dfN)),
    dplyr_if_else    = dplyr_if_else(copy(dfN)),
    hybrd.replace_na = hybrd.replace_na(copy(dfN)),
    baseR.sbst.rssgn = baseR.sbst.rssgn(copy(dfN)),
    baseR.replace    = baseR.replace(copy(dfN)),
    dplyr_coalesce   = dplyr_coalesce(copy(dfN)),
    tidyr_replace_na = tidyr_replace_na(copy(dfN)),
    hybrd.replace    = hybrd.replace(copy(dfN)),
    hybrd.rplc_at.ctn= hybrd.rplc_at.ctn(copy(dfN)),
    hybrd.rplc_at.nse= hybrd.rplc_at.nse(copy(dfN)),
    baseR.for        = baseR.for(copy(dfN)),
    hybrd.rplc_at.idx= hybrd.rplc_at.idx(copy(dfN)),
    DT.for.set.nms   = DT.for.set.nms(copy(dfN)),
    DT.for.set.sqln  = DT.for.set.sqln(copy(dfN)),
    times = 600L
)

ggplot(perf_results, aes(x=expr, y=time/10^9)) +
    geom_boxplot() +
    xlab('Expression') +
    ylab('Elapsed Time (Seconds)') +
    scale_y_continuous(breaks = seq(0,7,1)) +
    coord_flip()


    qplot(y=time/10^9, data=perf_results, colour=expr) +
        labs(y = "log10 Scaled Elapsed Time per Trial (secs)", x = "Trial Number") +
        coord_cartesian(ylim = c(0.75, 7.5)) +
        scale_y_log10(breaks=c(0.75, 0.875, 1, 1.25, 1.5, 1.75, seq(2, 7.5)))
