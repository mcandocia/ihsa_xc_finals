source('cleaning.r')
source('plotting_functions.r')
library(ggplot2)
library(scales)
library(cetcolor)

inferno_palette = cet_pal(7, 'inferno')

format_race_time <- function(x){
  nminutes = x %/% 60
  nseconds = x %% 60
  sprintf('%s:%02.0f', nminutes, nseconds)
}

format_race_time_tenths <- function(x){
  nminutes = x %/% 60
  nseconds = x %% 60
  sprintf('%s:%02.1f', nminutes, nseconds)
}


# data.frame `xcresults``
# time_%s_rank - overall rank
# time_%s_seconds
# mile_%s_split
# time_%s_seconds_total
# time_%s_mile_seconds_total - for 1, 2, and 3
# overall_pace
# time_overall_seconds

library(ggplot2)

# show overall time distribution split up between divisions, sexes, and years (try looking at linear model)

ggplot(xcresults %>% filter(overall_pace < 600)) + geom_density(aes(x=overall_pace, fill=division, color=division),
                                 alpha=0.4) + 
  facet_grid(.~sex) + scale_x_continuous(label=format_race_time, breaks = 60 * seq(5,9,0.5)) + 
  ggtitle("Distribution of Race Times of IHSA State Cross-Country Race", 
          subtitle="race distance = 3 miles; 2015-2017; paces over 10 minutes/mile removed; \n2017 boys 2A division not included due to incomplete data") + 
  xlab('Pace (minutes/mile)')

# show % change in speed vs. overall time


## slow to plot
#ggplot(xcresults) + geom_point(aes(x = time_overall, y=mile_2_split_deviation, color=division), alpha=0.6) + 
#  facet_grid(.~sex)

# summary(lm(mile_2_split_deviation_percent ~ sex + division + time_overall_seconds + factor(year), data=xcresults))

ggplot(xcresults) + stat_density_2d(aes(x=mile_2_split_deviation_percent, y=mile_3_split_deviation_percent,
                                        fill=..level.., alpha=..level..), geom='polygon', n=300) + 
  facet_grid(division ~ sex)

ggplot(xcresults %>% filter(mile_2_split_deviation_percent < 0.5 & mile_3_split_deviation < 2.5 & time_difference_with_median < 250)) + 
  geom_point(aes(x=mile_2_split_deviation_percent, y=mile_3_split_deviation_percent,
                                   color=time_difference_with_median),
             alpha=0.7) + 
  facet_grid(division ~ sex) + 
  scale_color_gradientn('overall time difference \nversus race median', label = format_race_time, colors=inferno_palette) + 
  scale_y_continuous(label=percent) + scale_x_continuous(label=percent) + 
  xlab('Mile 2 Pace Change vs. Mile 1') + ylab('Mile 3 Pace Change vs. Mile 2')


# for top 25 in each race
ggplot(xcresults %>% filter(mile_2_split_deviation_percent < 0.5 & mile_3_split_deviation < 0.5 & as.numeric(place) <= 25 )) + 
  geom_point(aes(x=mile_2_split_deviation_percent, y=mile_3_split_deviation_percent,
                 color=as.numeric(place)),
             alpha=0.7, size=2.5) + 
  facet_grid(division ~ sex) + 
  scale_color_gradientn('place', label = as.integer, colors=inferno_palette) + 
  scale_y_continuous(label=percent) + scale_x_continuous(label=percent) + 
  xlab('Mile 2 Pace Change vs. Mile 1') + ylab('Mile 3 Pace Change vs. Mile 2')

# show rank at 1, 2, 3 vs. each other
# compare speeds across years, divisions, and sexes

percent_custom <- function(n){
  function(x){
    percent(x/n)
  }
}

ggplot(xcresults %>% filter(place <= 25 & year != 2016)) +
  geom_bar(aes(x=standing, color=standing, fill=standing)) +
  facet_grid(division ~ sex) + 
  scale_y_continuous(label=percent_custom(200)) + 
  scale_fill_manual('Year in School', values=cet_pal(4)) + 
  scale_color_manual('Year in School', values = cet_pal(4)) + 
  xlab('') + ylab('Proportion') + ggtitle('Proportion of Students by Year in School \nPlacing Top 25 at IHSA State Cross-Country Race',
                                          subtitle='For years 2015 and 2016; race is 3 miles long at Detweiler Park, Peoria, IL')

experience_table = with(xcresults %>% filter(year==2017 & as.numeric(place) <= 25), 
                        table(division, sex, years_experience))

htmlTable(melt(experience_table)$value, 
          cgroup=c('Boys','Girls'),
          header = rep(c('1A','2A','3A'), 2),
          n.cgroup = c(3, 3),
          rnames = c('1st year','2nd year', '3rd year')
         # rgroup=c('1 year','2 years', '3 years'),
         # n.rgroup = c(1,1,1)
)


ggplot(xcresults %>% filter(as.numeric(place) <= 25 & year==2017)) + 
  geom_boxplot(aes(x=years_experience, y=as.numeric(place), group=years_experience)) + 
  facet_grid(division ~ sex)

# look at splits of top 25 runners in each division