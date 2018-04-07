library(ggplot2)
library(reshape2)
library(plyr)
library(dplyr)
library(cetcolor)
library(scales)
library(tidyr)


#smart percent scale which adds count in parentheses
smart_percent <- function(prop, cnt)
  paste0(percent(prop), ' (', cnt, ')')

#fixes text size

better_text_size <- theme(axis.text=element_text(size=rel(2)),
                          axis.title=element_text(size=rel(2)),
                          plot.title=element_text(size=rel(2)),
                          plot.subtitle=element_text(size=rel(2)),
                          legend.title=element_text(size=rel(2)),
                          legend.text=element_text(size=rel(2)))

better_text_size_manylabs <- theme(axis.text=element_text(size=rel(1)),
                                   axis.title=element_text(size=rel(2)),
                                   plot.title=element_text(size=rel(2)),
                                   plot.subtitle=element_text(size=rel(2)),
                                   legend.title=element_text(size=rel(2)),
                                   legend.text=element_text(size=rel(2)))

better_text_size_tiled <- theme(axis.text=element_text(size=rel(1)),
                                axis.title=element_text(size=rel(2)),
                                plot.title=element_text(size=rel(2)),
                                plot.subtitle=element_text(size=rel(2)),
                                legend.title=element_text(size=rel(1.8)),
                                legend.text=element_text(size=rel(1.1)))