# class
> library (dslabs)
> data("murders")
> class(murders)
[1] "data.frame"

#structure => str
str(murders)
head(murders)
# access variables => $, the accessor
> murders$population
> names(murders) # get the names like population

> pop <- murders$population
> length(pop)
[1] 51
> class(pop)
[1] "numeric"

# character vectors
> a <- 1
> a
[1] 1
>"a" # character string a.
[1] "a"
> class(murders$state)
[1] "character"

#logiccal vectors: TRUE or FLASE
# Factor for storing Characterical data
> class(murders$regions)
[1] "factor"
> levels(murders$regions)
[1] "Northest" "South" "North Central" "West"

#/ The function table takes a vector as input
# and returns the frequency of each unique element in the vector.

# Vector: a series of values, all of the same type. The most basic data type in R, and can hold numeric data, character data or logical data.
# create a vector with fuction c(): concatenate
> codes <- c(380, 124, 818)
> country <- c("italy","canda","egypt")
> codes <- c(italy=380,canada=124,egypt=818)
# same as
> codes <- c("italy"=380,"canada"=124,"egypt"=818)
> class(codes)
[1] "numeric"
# use name fuction to assign names to the entries of a vector
> names(codes) <- country # naming the codes-- according to country
> codes

> seq(1,10)
[1] 1 2 3 4 5 6 7 8 9 10
> seq(1,10,2)
[1] 1 3 5 7 9
> 1:10
[1] 1 2 3 4 5 6 7 8 9 10

# Subsetting []: display subset of a vector, use subset []
> codes[2]
> codes [c(1,3)]
> codes["canada"]
> codes["egypt","italy"]

#coercion
> x <- c(1,"canada",3)
> x
[1] "1" "canada" "3"
> class(x)
[1] "character"
#as.character
> x <- 1:5
> y <- as.character(x)
> y
[1] "1" "2" "3" "4" "5"
> as.numeric(y)
[1] 1 2 3 4 5

> x <- c

# sort
> library(slabs)
> data(murders)
> sort(murders$total)

# order: returns the indices that sort the vector parameter
> x <- c(31,4,15,92,65)
> x
[1] 31 4 15 92 65
> sort(x)
[1] 4 15 31 65 92
> index <- order(x)
> x[index]
[1] 4 15 31 65 92
> x
[1] 31 4 15 92 65
> order(x) # is the index that puts the vector x in order
[1] 2 3 1 5 4

> index <- order(murders$total)
> murders$abb[index]

# max
> max(murders$total)
[1] 1257
> i_max <- which.max(murders$total)
> i_max
[1] 5
> murders$state[i_max]
[1] "California"
# min which.min

#rank: give the ranking from smallest to largest
> x <- c(31, 4, 15, 92,65)
> x
[1] 31 4 15 92 65
> rank(x)
[1] 3 1 2 5 4

# create a data frame using data.frame function
> temp <- c(35, 88, 42, 84, 81, 30)
> city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")
> city_temps <- data.frame(name = city, temperature = temp)

# PRACTICE
# Define a variable states to be the state names from the murders data frame
states <- murders$state
# Define a variable ranks to determine the population size ranks
ranks <- rank(murders$population)
# Define a variable ind to store the indexes needed to order the population values
ind <- order(murders$population)
# Create a data frame my_df with the state name and its rank and ordered from least populous to most
my_df <- data.frame(state = states[ind], rank = ranks[ind])

# vector artithmetic
> murders$state[which.max(murders$population)]
[1] "California"
> max(murders$population)
[1] 37253956

> heights <- c(69, 62,66,70,70,73,67,73,67,70)
> heights * 2.54
[1] 175.26 157.48 167.64 177.80 177.80
[6] 185.42 170.18 185.42 170.18 177.80
> height - 69
[1] 0 -7 -3 1 1 4 -2 4 -2 1

> murder_rate <- murders$total/murders$population*100000 # for unit correction
> murders$state[order(murder_rate,decreasing=TRUE)]
[1] "Distric of Columbia" "Louisana"

# indexing, using logical operator
> index <- murder_rate < 0.71
> index <- murder_rate <= 0.71
> index
[1] FALSE FALSE TRUE...
> murders$state[index]
[1] "Hawaii"
[2] "Iowa"
[3] "New Hampshire"
[4] "North Dakota"
[5] "Vermont"

# to calculate how many is under 0.71, use sum function because TRUE is 1, FALSE is 0.
> sum(index)
[1] 5

> west <- murder$region == "West"
> safe <- murder_rate <= 1
> index <- safe & west # set the index when two vectors are both TRUE.
# > murders$state[west&safe] # my version
> murders$state[index]

# indexing functions. which, match, %in%
> x <- c(FALSE, TRUE, FALSE, TRUE, TRUE)
> which(x)
[1] 2 4 5

# which : give the index where the logical is TRUE.
> index <- which(murders$state == "Massachusetts")
> index
[1] 22
> murder_rate[index]
[1] 1.802

# match
> index <- match(c("New York", "Florida", "Texas"), murders$state)
> index
[1] 33 10 44
> murder_state[index]
[1] "New York", "Florida", "Texas"
> murder_rate[index]
[1] 2.668 3.398 3.201

# %in% useful in subset data
> x <- c("a", "b", "c", "d", "e")
> y <- c("a", "d", "f")
> y %in% x
[1] TRUE, TRUE, FALSE

# Store the murder rate per 100,000 for each state, in murder_rate
> murder_rate <- murders$total/murders$population*100000
# Store the murder_rate < 1 in low
> low <- murder_rate < 1
# Get the indices of entries that are below 1
> which(low)

# dplyr for data manipulation/wrangling
> library(dplyr)
# mutate, filter, select, pipe operator (%>%)

# mutate: add new variable to data frame
> murders <- mutate(murders, rate= total/population*100000) # mutate function looks for variables in the data frame, not in the workplace (e.g., total & population)
# mutate(data table, name = value)
# if reload the dslab package, may overwrite

# filter the rows you need # filter(data table, conditional statement)
> filter(murders, rate <= 0.71)
# get the resulting table

# select the column you need
> new_table <- select(murders, state, region, rate) # select(data table, column1, column2,...)
> filter(new_table, rate <= 0.71)
# yield the filtered new_table

# %>% pipe: data -> select -> filter
> murders %>% select(state,region,rate) %>% filter(rate <= 0.71)

# creating data frames
> grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), exam_1 = c(95,80,90,85), exam_2 = c(90,85,85,90))
> class(grades$names)
[1] "factor"
> grades <- data.frame(names = c("John", "Juan", "Jean", "Yao"), exam_1 = c(95,80,90,85), exam_2 = c(90,85,85,90), stringAsFactors = FALSE)> class(grades$names)
> class(grades$names)
[1] "character"

nrow() # calculate the row number

# add the rate column
murders <- mutate(murders, rate =  total / population * 100000, rank = rank(-rate))
# Create a table, call it my_states, that satisfies both the conditions
my_states = filter(murders, rate < 1 & region %in% c("Northeast","West"))
# Use select to show only the state name, the murder rate and the rank
(my_states, state, rate, rank)

# scatter plot
> population_in_millions <- murders$population/10^
> total_gun_murders <- murders$total
> plot(population_in_millions, total_gun_murders)

# histogram
> hist(murders$rate)
> murders$state[which.max(murders$rate)]
[1] "District of Columbia"

#boxplot
> boxplot(rate~region, data = murders)

# if-else
> a = 2
> if (a!= 0) {
    print(1/a)
} else{
    print("No reciprocal for 0.")
}
[1] 0.5

# find lower murder rate
> ind = which.min(murder_rate)
> if(murder_rate[ind] < 0.5) {
    print(murders$state[ind])
} else{
    print("No state has murder rate that low")
}
[1] "Vermont"

# ifelse
> a = 0
> ifelse(a > 0, 1/a, NA)
[1] NA

> a = c(0, 1, 2, -4, 5)
> result = ifelse(a>0, 1/a, NA)
# good to replace NA with other value
> data(na_exapmle)
> sum(is.na(na_example))
[1] 145
> no_nas = ifelse(is.na(na_example),0, na_example)
> sum(is.na(no_nas))
[1] 0

# any all
> z = c(TRUE, TRUE, FALSE)
> any(z) # at least 1 entry is true
[1] TRUE
> z = c(FALSE, FALSE, FALSE)
> all(z) # all entries should be true
[1] FALSE

## write function
> sum(x)/length(x)
> mean(x)

avg = function(x){
    s = sum(x)
    n = length(x)
    s/n          #
}  #
> identical(mean(x), avg(x))
[1] TRUE

> avg = function(x, arithmetic=TRUE){
    n = length(x)
    ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}

# for loop
> compute_s_n = function(n){
    x = 1:n
    sum(x)
}
> compute_s_n(3)
[1] 6

> for(i in 1:5){
    print(i)
}


> m = 25
> s_n = vector(length = m) # create an empty vector to store the result
> for(n in 1:m){
    s_n[n] = compute_s_n(n)
}
# create a plot
> n = 1:m
> plot(n, s_n)

> plot(n, s_n)
> lines(n, n*(n+1)/2)

# apply family: apply sapply tapply mapply
# split cut quantile reduce identical unique