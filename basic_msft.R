# Clear the entire workspace
rm(list = ls())

# create and name a vector
remain = c(11,12,11,13)
remain
[1] 11 12 11 13

# names()
suits = c("spades","hearts", "diamonds","clubs")
names(remain) = suits
remain
spades  hearts  diamonds    clubs
11      12      11          13

remain = c(spades = 11, hearts = 12, diamonds = 11, clubs =13)
remain = c("spades" = 11, "hearts" = 12, "diamonds" = 11, "clubs" =13)

str(remain)
Named num [1:4] 11 12 11 13
- attr(*,"names") = char [1:4] "spades" "hearts" "diamonds" "clubs"

# vectors are homogenous: only elements of the same type. Vectors are one dimensional arrays that can hold numeric data, character data, or logical data.
# Atomic vectors <> lists (different types)
# if not the same type, R automatically coercion.
# for example
drawn_ranks = c(7,4,"A",10,"K",3,2,"Q")
class(drawn_ranks)
[1] "character"


# Assign the names of the day to roulette_vector and poker_vector
poker_vector <- c(140, -50, 20, -120, 240)
roulette_vector <- c(-24, -50, 100, -350, 10)
days_vector <- c("Monday", "Tuesday","Wednesday","Thursday","Friday")
names(poker_vector) = days_vector
names(roulette_vector) = days_vector

# use names() to get the names of a vector

# subset
> remain = c(spades = 11, hearts =12, diamonds = 11, clubs =13)
> remain
spades   hearts diamonds    clubs
11       12       11       13
> remain[1]
spades
11
> remain[3]
diamonds
11
> remain["spades"]
spades
11
> ls()
[1] "remain"
> remain_black = remain[c(1,4)]
> remain_black
spades  clubs
11     13
> remain[c(4,1)] # select differnt elements
clubs spades
13     11
> remain[-1] # exclude
hearts diamonds    clubs
12       11       13
> remain[-c(1,2)]
diamonds    clubs
11       13
# use logical to select elements
> remain[c(F,T,F,T)]
hearts  clubs
12     13
> selection_vector = c(F,T,F,T)
> remain[selection_vector]
hearts  clubs
12     13

> matrix(1:6, nrow = 2)
[,1] [,2] [,3]           # fill column by column
[1,]    1    3    5
[2,]    2    4    6

> matrix(1:6, ncol = 2)
[,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6

> matrix(1:6, ncol = 2, byrow = TRUE)     # fill by rows
[,1] [,2]
[1,]    1    2
[2,]    3    4
[3,]    5    6
>
    > matrix(1:5, ncol = 2)
[,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    1
Warning message:
    In matrix(1:5, ncol = 2) : 資料長度 [5] 並非列數量 [3] 的因數或倍數

# rbind(), cbind()
> cbind(1:3, 1:3)
[,1] [,2]
[1,]    1    1
[2,]    2    2
[3,]    3    3
> cbind(1:3, 1:4)
[,1] [,2]
[1,]    1    1
[2,]    2    2
[3,]    3    3
[4,]    1    4
Warning message:
    In cbind(1:3, 1:4) :
    number of rows of result is not a multiple of vector length (arg 1)
> rbind(1:3, 1:3)
[,1] [,2] [,3]
[1,]    1    2    3
[2,]    1    2    3

##
> m = matrix(1:6, byrow = T, nrow =2)
> m
[,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
> rbind(m,7:9)
[,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9
> rbind(m,7:10)
[,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9
Warning message:
    In rbind(m, 7:10) :
    number of columns of result is not a multiple of vector length (arg 2)

# naming a matrix rownames(), colnames()
> m = matrix(1:6, byrow = TRUE, nrow = 2)
> rownames(m) = c("row1", "row2")
> m
[,1] [,2] [,3]
row1    1    2    3
row2    4    5    6
> colnames(m) = c("apple",2,"try")
> m
apple 2 try
row1     1 2   3
row2     4 5   6

> m = matrix(1:6, byrow = TRUE, nrow = 2, dimnames = list(c("row1","row2"),c("col1","col2","col3")))
> m
col1 col2 col3
row1    1    2    3
row2    4    5    6

#coercion
> char = matrix(LETTERS[1:6], nrow =4,ncol=3)
> char
[,1] [,2] [,3]
[1,] "A"  "E"  "C"
[2,] "B"  "F"  "D"
[3,] "C"  "A"  "E"
[4,] "D"  "B"  "F"

> cbind(num, char)
[,1] [,2] [,3] [,4] [,5]
[1,] "1"  "5"  "A"  "E"  "C"
[2,] "2"  "6"  "B"  "F"  "D"
[3,] "3"  "7"  "C"  "A"  "E"
[4,] "4"  "8"  "D"  "B"  "F"

# sum of row or colum
worldwide_vector = rowSums(star_wars_matrix)
colSums

# subsetting matrix
> n
[,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    5    6    7    8
[3,]    9   10   11   12
[4,]   13   14   15   16
[5,]   17   18   19   20
> n[2,3]
[1] 7
> n[2, c(2,3)]
[1] 6 7
> n[c(4,5), c(3,4)]
[,1] [,2]
[1,]   15   16
[2,]   19   20

# subset with name
> n
Spring Summer Fall Winter
LeBron       1      2    3      4
Kobe         5      6    7      8
Carmelo      9     10   11     12
Daywne      13     14   15     16
Chris       17     18   19     20
> n["Carmelo","Winter"]
[1] 12

> n[c(T,F,F,T,T),c(T,F,F,T)]
Spring Winter
LeBron      1      4
Daywne     13     16
Chris      17     20
>
    
    # Vector = 1D, matrix = 2D
    # Coercion if necessary. Recycling if necessary.
    # Calculation is element-wise
    
    # categorical variable = factor
    > blood = c("B", "A", "AB", "A", "O", "O", "B")
> blood
[1] "B"  "A"  "AB" "A"  "O"  "O"  "B"
> bf = factor(blood)
> bf
[1] B  A  AB A  O  O  B
Levels: A AB B O    # R sorts levels aphabetically
> str(bf)
Factor w/ 4 levels "A","AB","B","O": 3 1 2 1 4 4 3
# factors are actually integer vectors, where each integer corresponds to a category or a level.

# change the order of levels
> blood_factor = factor(blood, levels = c("O", "A", "B", "AB"))
> blood_factor
[1] B  A  AB A  O  O  B
Levels: O A B AB
> str(blood_factor)
Factor w/ 4 levels "O","A","B","AB": 3 2 4 2 1 1 3

# together: levels define the level of variable (unordered!!)
# labels define the names of categorical variable
> factor(blood, levels = c("O","A","B","AB"), labels = c("BT_O","BT_A","BT_B","BT_AB")) # <- label the original data into new names (by argument labels= )
[1] BT_B  BT_AB BT_O  BT_A  BT_O  BT_O  BT_A  BT_B
Levels: BT_O BT_A BT_B BT_AB
> blood
[1] "B"  "AB" "O"  "A"  "O"  "O"  "A"  "B"

# ordinal categorical variable
> tshirt = c("M", "L", "S", "S", "XL")
> tshirt
[1] "M"  "L"  "S"  "S"  "XL"
> tshirt_factor = factor(tshirt, ordered= TRUE, levels = c("S","M","L")) # give order to the levels (integer/math)
> tshirt_factor
[1] M    L    S    S    <NA>
    Levels: S < M < L
> tshirt_factor = factor(tshirt, ordered= TRUE, levels = c("S","M","L","XL"))
> tshirt_factor
[1] M  L  S  S  XL
Levels: S < M < L < XL

# wrapup: factors for categorical variables. Factors are integer vectors.
# Change factor levels:
#    levels() function or labels argument
# ordered factors: ordered = TRUE

# It is important not to confuse an argument with a function here! An argument can be specified inside a function as an extra option.
# You can name the categories of your factor by either using the labels argument inside the factor() function or by using the levels function afther you have created the factor.

my_factor <- factor(my_vector,
                    levels = c("S", "M", "L"),
                    labels = c("Small", "Medium", "Large"))

