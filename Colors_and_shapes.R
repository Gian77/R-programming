# Some useful tricks about how to plot colors palette and avaialbel shapes in R

# Hot to visualize available shapes
library(ggpubr)
show_point_shapes()

# How to print a custom color palette in basic R
paletteCB6 = c("#2D3142","#058ED9","#848FA2","#599861","#FF934F", "#CC2D35")
pie(rep(1, length(paletteCB6)), labels = sprintf("%d (%s)",
     seq_along(paletteCB6),paletteCB6), col = paletteCB6)

paletteCB3 = c("#599861","#FF934F", "#CC2D35")
pie(rep(1, length(paletteCB3)), labels = sprintf("%d (%s)",
        seq_along(paletteCB3),paletteCB3), col = paletteCB3)
