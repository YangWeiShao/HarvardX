#list
> song = list("Rsome times",190,5)
> names(song) = c("title", "duration", "track")
> song
$`title`
[1] "Rsome times"

$duration
[1] 190

$track
[1] 5

# subset a list
> song = list(title = "Rsome times", duration = 190, track =5)
> song
$`title`
[1] "Rsome times"

$duration
[1] 190

$track
[1] 5

> str(song)
List of 3
$ title   : chr "Rsome times"
$ duration: num 190
$ track   : num 5


> similar_song = list(title="R you on time?", duratoin = 230)
> song = list(title = "Rsome times", duration = 190, track = 5, similar = similar_song)
> song
$title
[1] "Rsome times"

$duration
[1] 190

$track
[1] 5

$similar
$similar$title
[1] "R you on time?"

$similar$duratoin
[1] 230

> str(song)
List of 4
$ title   : chr "Rsome times"
$ duration: num 190
$ track   : num 5
$ similar :List of 2
..$ title   : chr "R you on time?"
..$ duratoin: num 230

# shining_list[[c(2,4)]] is equivalent to shining_list[[2]][[4]]. -> find the 2nd element in the list, and find into that element (4th)


# subset data frame : [ or [[ $

# example: people data frame
> name = c("Anne","Pete","Frank","Julia","Cath")
> age = c(28,30,21,39,35)
> child = c(F,T,T,F,T)
> people = data.frame(name, age,child,stringsAsFactors = F)
> people
name age child
1  Anne  28 FALSE
2  Pete  30  TRUE
3 Frank  21  TRUE
4 Julia  39 FALSE
5  Cath  35  TRUE

# subset/choose a data in data frame
> people[3,2]
[1] 21
> people[3,"age"]
[1] 21
> people[3,]
name age child
3 Frank  21  TRUE
> people[,"name"]
[1] "Anne"  "Pete"  "Frank" "Julia" "Cath"

> people[c(2,5),c("name","child")]
name child
2 Pete  TRUE
5 Cath  TRUE

> people[1]  # return a data frame, not a vector!
name
1  Anne
2  Pete
3 Frank
4 Julia
5  Cath

# but data frame can also be regarded as lists, so the command for list will return a vector/vectors!
> people$name
[1] "Anne"  "Pete"  "Frank" "Julia" "Cath"   #vector
> people$Pete
NULL
> people$age
[1] 28 30 21 39 35
> people[["age"]]  # [[]] for list -> return a vector!
[1] 28 30 21 39 35
> people[[2]]
[1] 28 30 21 39 35
> people["age"]   # [] for data frame -> return a data frame!
age
1  28
2  30
3  21
4  39
5  35
> people[,"age"]
[1] 28 30 21 39 35

# extend data frame
> height = c(163,177,163,162,157)
> people$height = height
> people
name age child height
1  Anne  28 FALSE    163
2  Pete  30  TRUE    177
3 Frank  21  TRUE    163
4 Julia  39 FALSE    162
5  Cath  35  TRUE    157

# or people[["height"]] = height
> region = c("NYC","LA","DAL","UTH","SEA")
> region
[1] "NYC" "LA"  "DAL" "UTH" "SEA"
> people[["region"]] = region
> people
name age child height region
1  Anne  28 FALSE    163    NYC
2  Pete  30  TRUE    177     LA
3 Frank  21  TRUE    163    DAL
4 Julia  39 FALSE    162    UTH
5  Cath  35  TRUE    157    SEA
> str(people)
'data.frame':   5 obs. of  5 variables:
    $ name  : chr  "Anne" "Pete" "Frank" "Julia" ...
$ age   : num  28 30 21 39 35
$ child : logi  FALSE TRUE TRUE FALSE TRUE
$ height: num  163 177 163 162 157
$ region: chr  "NYC" "LA" "DAL" "UTH" ...

# or use cbind = add column
> weight = c(74,63,68,55,56)
> cbind(people, weight)
name age child height region weight
1  Anne  28 FALSE    163    NYC     74
2  Pete  30  TRUE    177     LA     63
3 Frank  21  TRUE    163    DAL     68
4 Julia  39 FALSE    162    UTH     55
5  Cath  35  TRUE    157    SEA     56

my_df$new_column <- my_vec
my_df[["new_column"]] <- my_vec
my_df <- cbind(my_df, new_column = my_vec)

# add row
> tom = data.frame(name="Tom", age = 37, child=F, height =183)
> tom$region = "CHI"
> tom["weight"] = 70
> rbind(tom,people)
name age child height region weight
1   Tom  37 FALSE    183    CHI     70
2  Anne  28 FALSE    163    NYC     74
3  Pete  30  TRUE    177     LA     63
4 Frank  21  TRUE    163    DAL     68
5 Julia  39 FALSE    162    UTH     55
6  Cath  35  TRUE    157    SEA     56

# sorting
> sort(people$age)
[1] 21 28 30 35 39   # just look at people$age
> people$age
[1] 28 30 21 39 35
> order = order(people$age) # ordered from smallest to biggest (return thier index)
> order
[1] 3 1 2 5 4   # [3] < [1] < [2] < [5] < [4] the index of lowest... to highest
> rank(people$age)   # giving their ranking (on their current order)
[1] 2 3 1 5 4   # [1] is ranked 2nd, [3] is ranked 3rd, [1] is ranked 1st...
> people[order,]
name age child height region weight
3 Frank  21  TRUE    163    DAL     68
1  Anne  28 FALSE    163    NYC     74
2  Pete  30  TRUE    177     LA     63
5  Cath  35  TRUE    157    SEA     56
4 Julia  39 FALSE    162    UTH     55
> people[order(people$age, decreasing = TRUE),]
name age child height region weight
4 Julia  39 FALSE    162    UTH     55
5  Cath  35  TRUE    157    SEA     56
2  Pete  30  TRUE    177     LA     63
1  Anne  28 FALSE    163    NYC     74
3 Frank  21  TRUE    163    DAL     68

a <- c(100,9,101)
order(a)
a[order(a), decreasing = T] # reorder by highest to lowest

# another reorder
positions = order(planets_df[,"diameter"], decreasing = T)
largest_first_df = planets_df[positions,]

## Dataframe [] -> subset: data frame
## Dataframe $ or [[]]-> subset: vector

# subset/choose part of data frame with some criteria
has_rings_df = planets_df[planets_df$has_rings == TRUE, ]
# You can reach the same thing with the subset(). You should see the subset() function:
has_rings_df = subset(planets_df, subset = has_rings == TRUE)