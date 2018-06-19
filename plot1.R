# dplyr: summarize, group_by, dot placeholder, arrange

s = heights %>% filter(sex == "Male") %>%
    +   summarize(average = mean(height),standard_deviation = sd(height))
# summarize(): create a summarize table, only 1 result/output is allowed
# summarize(quantiles = quantiles(.25,.5,.75)) -> error because multiple output
s
average    standard_deviation
1     69.3                  3.61

s$average
[1] 69.3
s$standard_deviation
[1] 3.61

heights %>% filter(sex == "Male") %>%
    +   summarize(median = median(height),
    +   minimum = min(height), +
    +   maximum = max(height))

median  minimum maximum
1       69       50    82.7

# dot placeholder:
# when using the pipe (%>%), it returns a data frame. For example:
us_murder_rate = murders %>% summarize(rate = sum(total)/sum(population) *100000)
us_murder_rate
rate
1   3.03    # <- this is a data frame! Most of dplyr functions return a data frame
# sometimes we need a numeric vector to put into some functions.
# so we need to use dot placeholder to yield a numeric output
us_murder_rate %>% .$rate
[1] 3.03    # .$column_name returns the value in that column in (summarize) table

# or
us_murder_rate = murder %>%
    +   summarize(rate=sum(total)/sum(population)*100000) %>%
    +   .$rate
us_murder_rate
[1] 3.03

# group by
heights %>% group_by(sex)  # yield "group data frame"

heights %>% group_by(sex) %>%
    +   summarize(average = mean(height),standard_deviation = sd(height))
# A tibble: 2 x 3
sex     average standard_deviation
<fctr>   <dbl>          <dbl>
1   Female   64.9            3.76
2     Male   69.3            3.61

# sorting data table: arrange()
murders %>% arrange(population) %>% head()  # default: in acending order
murders %>% arrange(murder_rate) %>% head()
murders %>% arrange(desc(murder_rate) %>% head()  # desc(): in descending order
murders %>% arrange(region, murder_rate) %>% head() # sort within sort
                    
# choose the top nth rows, but NOT ordered
murders %>% top_n(10, murder_rate)
# both top and order
murders %>% arrange(desc(murder_rate)) %>% top_n(10)

#####

# remove na
mean(na_example, na.rm = TRUE)
sd(na_example, na.rm = TRUE)

# case study
gapminder %>% filter(year == 2015 & country %in% c("Sri Lanka","Turkey")) %>%
select(country, infant_mortality)
country infant_mortality
1   Sri Lanka              8.4
2      Turkey             11.6
ds_theme_set()
filter(gapminder, year == 1962) %>% ggplot(aes(fertility, life_expectancy, color = continent))
+ geom_point()

# faceting variables: determine the range of data shown in all plots
facet_grid()
# The data can be split up by one or two variables that vary on the horizontal and/or vertical direction.
filter(gapminder, year %in% c(1962,2012)) %>% ggplot(aes(fertility,life_expectancy, col =continent))
+ geom_point()
+ facet_grid(continent~year) # continent as rows, year as columns
# or
+ facet_grid(.~year) # only show by the grid of year

facet_wrap()
# Instead of faceting with a variable in the horizontal or vertical direction,
# facets can be placed next to each other, wrapping with a certain number of columns or rows.
# The label for each plot will be at the top of the plot.
years = c(1962,1980,1990,2000,2012)
continents = c("Europe","Asia")
gapminder %>% filter(year %in% years & continent %in% continents) %>%
+ ggplot(aes(fertility, life_expectancy, col = continents))
+ geom_point()
+ facet_wrap(~year)

# time series plots: time (x-axis), measurement (y-axis)
gapminder %>% filter(country == "United States") %>%
+ ggplot(aes(year, fertility))
+ geom_line() # line up the dots
# compare 2 countries
countries = c("South Korea","Germany")
gapminder %>% filter(country %in% countries) %>%
+ ggplot(aes(year, fertility, group = country)) +
# ggplot(aes(year, fertility, col = country))  # automatically group by color
+ geom_line()

# add labels
labels = data.frame(country = countries, x = c(1975,1965), y = c(60,72))
gapminder %>% filter(country %in% country) %>%
+ ggplot(aes(year, life_expectancy,col=country)) +
+ geom_line() +
+ geom_text(data = labels, aes(x,y, label = country), size =5) +
+ theme(legend.position="none")

# transformations
gapminder = gapminder %>% mutate(dollars_per_day = gdp/population/365)
# log transformation
gapminder %>% filter(year == past_year & !is.na(gdp)) %>%
+ ggplot(aes(log2(dollars_per_day))) +
+ geom_histogram(binwidth =1, color = "black")
+ scale_x_continuous(trans = "log2") # change the x-axis scale

# stratify and boxplot
p + geom_boxplot()
+ theme(axis.text.x = element_text(angle = 90, hjust=1))
# angle: rotation, hjust: text next to the axis

# reorder(): change the order based on a summary computed on a numeric vector
fac = factor(c("Asia","Asia","West","West","West"))
levels(fac)
[1] "Asia" "West"
value = c(10,11,12,6,4)
fac = reorder(fac, value, FUN = mean) # Function mean: summarize the value. reorder the mean of value in fac vector
levels(fac)
[1] "West" "Asia"  # now "West" has a smaller mean (22/3) than "Asia" (21/2).

# example
p = gapminder %>% filter(year == past_year & !is.na(gdp)) %>%
+ mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
+ ggplot(aes(log2(region, dollars_per_day, fill = continent)) +
 + geom_boxplot() +
 + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
 + xlab("")
p + scale_y_continuous(trans = "log2") # change the y axis
+ geom_point(show.legend = FALSE) # show each country point

## comparing distributions
# compare between region (2 group)
west = c("Western Europe","Northern Europe", "Southern Europe","Northern America","Australia and New Zealand")
gapminder %>% filter(year == past_year & !is.na(gdp)) %>%
 + mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
 + ggplot(aes(dollars_per_day)) +
 + geom_histogram(binwidth = 1, color = "black") +
 + scale_x_continuous(trans = "log2") +
 + facet_grid(. ~group)

# compare between year and region (4 groups)
past_year = 1970
present_year = 2010
gapminder %>% filter(year %in% c(past_year, present_year) & !is.na(gdp)) %>%
 + mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
 + ggplot(aes(dollars_per_day)) +
 + geom_histogram(binwidth = 1, color = "blakc") +
 + scale_x_continuous(trans = "log2") +
 + facet_grid(year ~ group)

# only for data available in 2 years: intersect()
country_list_1 = gapminder %>% filter(year == past_year & !is.na(dollar_per_day) %>% .$country
                                   country_list_2 = gapminder %>% filter(year == present_year & !is.na(dollar_per_day) %>% .$country
country_list = intersect(country_list_1, country_list_2)

gapminder %>% filter(year %in% c(past_year, present_year) & country %in% country_list) ...
# use boxplot to see which regions improve most
p = gapminder %>% filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
+ mutate(region = reorder(region, dollars_per_day,  FUN = median)) %>%
+ ggplot()
+ theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
+ xlab("") + scale_y_continuous(trans = "log2")
p + geom_boxplot(aes(region, dollars_per_day, fill = continent)) + facet_grid(year~.)
# this graphs is vertically adjacent, not easy to compare, so:
# ease comparisons: ggplot automatically assigns a color to each level of factor(category) if we assign that factor to the color argument
p + geom_boxbplot(aes(region, dollars_per_day, fill = factor(year))
       
# density plots: smooth density plots
gapminder %>% filter(year == past_year & country %in% country_list) %>%
   + mutate(group = ifelse(region %in% west, "West", "Developing")) %>% group_by(group) %>%
   + summarize(n=n()) %>% knitr::kable() ## ?????
   |group     |  n|
   |:---------|--:|   # previously we only make plots with density (rule of AUC = 1, using ratio)
   |Developing| 87|   # but now we need to take data count into consideration
   |West      | 21|   # Developing countries are much more than West countries
   
   # To do so, we use geom_density() function
   geom_density()
# computed variables: density: density estimate
#                     count: density * number of points - useful for stacked density plots

# mutiply the y axis values by the size of the group, rather than the density value
# using ..variable.. to access the count
aes(x = dollars_per_day, y = ..count..)
* x = dollars_per_day
* y = ..count..  # put count on y axis

p = gapminder %>% filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
   + mutate(group = ifelse(region %in% west, "West","Developing")) %>%
   + ggplot(aes(dollars_per_day, y = ..count.., fill=group)) +
   + scale_x_continuous(trans = "log2")
p + geom_density(alpha = 0.2, bw = 0.75) + facet_grid(year ~ .)
# bw: smoothness
# case_when: define group
gapminder = gapminder %>% mutate(group = case_when(    # assigning group
   +   .$region %in% west ~ "West",
   +   .$region %in% c("Eastern Asia","South-Eastern Asia") ~ "East Asia",
   +   .$region %in% c("Caribbean", "Central America", "South America") ~ "Latin America",
   +   .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub_Saharan Africa",
   +   TRUE ~ "Others"))
# Then we turn this group variable into a factor to control the order of the levels
gapminder = gapminder %>% mutate(group = factor(group, levels = c("Others", "Latin America","East Asia","Sub-Saharan Africa","West")))
# use stack to make graph more clear
p + geom_density(alpha = 0.2, bw = 0.75, position = "stack") + facet_grid(year ~ .)

# use weight argument to take population into account
gapminder %>% filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
   +   group_by(year) %>%
   +   mutate(weight = population/sum(population)*2) %>%
   +   ungroup() %>%
   +   ggplot(aes(dollars_per_day, fill = group, weight = weight)) +
   +   scale_x_continuous(trans = "log2") +
   +   geom_density(alpha = 0.2, bw = 0.75, position = "stack") + facet_grid(year ~ .)

# ecological fallacy
gapminder = gapminder %>% mutate(group = case_when(
   +   .$region %in% west ~ "The West",
   +   .$region %in% "Northern Africa" ~ "Northern Africa"
   +   .$region %in% c("Eastern Asia","South-Eastern Asia") ~"East Asia",
   +   .$region == "Southern Asia" ~ "Southern Asia",
   +   .$region %in% c("Central America", "South America", "Caribbean") ~ "Latin America",
   +   .$continent == "Africa" & .$region != "Northen Africa" ~ "Sub-Saharan Africa",
   +   .$region %in% c("Melanesia", "Micronesia", "Polynesia") ~ "Pacific Islands"))
surv_income = gapminder %>% filter(year %in% present_year & !is.na(gdp) & !is.na(infant_mortality) & !is.na(group)) %>%
   +   group_by(group) %>%
   +   summarize(income = sum(gdp)sum(population)/365,
   +   infant_survival_rate = 1 - sum(infant_mortality/1000*population)/sum(population)
surv_income %>% arrange(income)

surv_income %>% ggplot(aes(income, infant_survival_rate, label = group, color = group)) +
 +   scale_x_continuous(trans = "log2", limit = c(0.25,150)) +  # limit: change the range of axis
 +   scale_y_continuous(trans = "logit", limit = c(0.875, .9981), breaks = c(.85,.90,.99,.995,.998)) +   #logit transformation: odds = p/(1-p)
 +   geom_label(size = 3,show.legend = FALSE)                   # breaks: set the location of the labels

# 1) jitter: small random shift of all points
# 2) alpha blending: making some point transparent
# align plots
# slope chart: geom_lines()
west = c("Western Europe", "Northern Europe","Southern Europe","Northern America","Australia and New Zealand")
dat = gapminder %>% filter(year %in% c(2010,2015) & region %in% west & !is.na(life_expectancy) & population > 10^7)
dat %>% mutate(location = ifelse(year == 2010,1,2),
            location = ifelse(year == 2015 & country %in% c("United Kinddom","Portugal"), location + 0.22, location).
            hjust = ifelse(year == 2010,1,0)) %>%
 mutate(year = as.factor(year)) %>%
 ggplot(aes(year, life_expectancy, group = country)) +
 +   geom_line(aes(color = country), show.legend = FALSE) +
 +   geom_text(aes(x=location, label = country, hjust = hjust), show.legend = FALSE) +
 xlab("") + ylab("Life Expectancy")

# Bland-Altman plot
geom_vline(xintercept = 1963, col = "blue") # add a vertical line

# use color
dat %>% ggplot(aes(year,state,fill=rate)) + geom_tile(color = "grey50") + scale_x_continuous(expand=c(0,0)) + scale_fill_gradientn(colors = brewer,pal(9,"Reds"), trans =

# average
avg = us_contagious_disease %>% filter(disease = the_disease) %>% group_by(year) %>% summarize(us_rate = sum(count,na.rm=TRUE)/sum(population, na.rm = TRUE)*10000)

# significant digits/round
signif, round
options(digits=n)