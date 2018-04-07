library(plyr)
library(dplyr)
library(reshape2)
library(lubridate)

sexes = c('boys','girls')
divisions = c('1A','2A','3A')
years = 2015:2017

data = list()

convert_race_time_to_seconds <- function(x){
  nminutes = gsub('(\\d+):\\d+(\\.\\d+)?', '\\1', x)
  nseconds = gsub('^(\\d+):','', x)
  times = 60*as.numeric(nminutes) + as.numeric(nseconds)
  return(ifelse(times > 0, times, NA))
}

format_race_time <- function(x){
  nminutes = x %/% 60
  nseconds = x %% 60
 sprintf('%s:%0.1f', nminutes, nseconds)
}

# converts times to seconds, calculates splits, paces, and ranks
clean_data <- function(df){
  split_columns = c('time_1_mile','time_1.5_mile','time_2_mile','time_overall')
  for (colname in split_columns){
    if (!colname %in% names(df)){
      print(paste('missing', colname))
      next
    }
    new_colname = paste0(colname, '_seconds')
    df[,new_colname] = convert_race_time_to_seconds(df[,colname])
  }
  df = df %>% mutate(
    time_1_mile_seconds_total = time_1_mile_seconds,
    time_1.5_mile_seconds_total = ifelse(year==2017, time_1.5_mile_seconds, time_1_mile_seconds + time_1.5_mile_seconds),
    time_2_mile_seconds_total = ifelse(year==2017, time_2_mile_seconds, time_2_mile_seconds + time_1.5_mile_seconds_total),
    mile_1_split = time_1_mile_seconds_total,
    mile_2_split = time_2_mile_seconds_total - time_1_mile_seconds_total,
    mile_3_split = time_overall_seconds - time_2_mile_seconds_total,
    mile_1_rank = rank(time_1_mile_seconds_total, ties.method='first'),
    mile_2_rank = rank(time_2_mile_seconds_total, ties.method='first'),
    mile_3_rank = as.numeric(place),
    overall_pace = time_overall_seconds/3,
    mile_2_split_deviation = mile_2_split - mile_1_split,
    mile_3_split_deviation = mile_3_split - mile_2_split,
    mile_2_split_deviation_percent = mile_2_split_deviation/mile_1_split,
    mile_3_split_deviation_percent = mile_3_split_deviation/mile_2_split,
    time_difference_with_median = time_overall_seconds - median(time_overall_seconds),
    time_difference_with_winning_time = time_overall_seconds - min(time_overall_seconds)
  ) 
  return(df)
}

for (year in years){
  for (division in divisions){
    for (sex in sexes){
      # data is missing for this year
      if (year==2017 & sex=='boys' & division=='2A')
        next
      filename = sprintf('runners_%s_%s_%s.csv', year, sex, division)
      df = read.csv(filename, stringsAsFactors=FALSE, colClasses = c('character'))
      df$year = year
      df$sex = sex
      df$division = division
      if (year==2015){
        filename2 = sprintf('runners_%s_%s_%s_individual.csv', year, sex, division)
        df2 = read.csv(filename2, stringsAsFactors=FALSE, colClasses = c('character'))
        df2$name = NULL
        df3 = df %>% dplyr::left_join(df2, by = "bib_number", suffix = c('', '__2'))
        data[[filename]] = clean_data(df3)
      }
      else{
        data[[filename]] = clean_data(df)
      }
      
    }
  }
}

xcresults = bind_rows(data) %>% mutate(
  standing=factor(
    mapvalues(standing, from=c('FR.','SO.','JR.','SR.'), to=c('Fr','So','Jr','Sr')),
    levels=c('Fr','So','Jr','Sr')
  )
)

# let's look at duplicates
# data is ordinal
unique_names = list()
for (division in divisions){
  unique_names[[division]] = unique((xcresults %>% filter(division==!!division))$name)  
}

xcresults$years_experience = 1
xcresults$has_multiple_years = FALSE

for (division in divisions){
  for (name in unique_names[[division]]){
    rows = xcresults$division==division & xcresults$name==name
    xcresults[rows,'years_experience'] = 1:sum(rows)
    if (sum(rows) > 1)
      xcresults[rows, 'has_multiple_years'] = TRUE
  }
}

write.csv(xcresults, file='xcresults.csv', row.names=FALSE)
