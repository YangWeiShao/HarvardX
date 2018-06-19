# continuous probability
# culmulative distribution function (CDF)

library(tidyverse)
library(dslabs)
data(heights)
x = heights %>% filter(sex == "Male") %>% .$height

F = function(a) mean(x <= a)
1 - F(70) # taller then 70 inches

pnorm()
F(a) = pnorm(a,avg,s)
1 - pnorm(70.5, mean(x),sd(x))

plot(prop.table(talbe(x)), xlab = "a = Height in inches", ylab = "Pr(X = a)")

# discretization
# discretization is the process of transferring continuous functions, models, variables, and equations into discrete counterparts

# probability density
pnrom(x, mean = , sd = ) # probability
dnorm() # d: density

# Monte Carlo: normally ditributed variable
rnorm(n, mean = , sd =) # to generate normally distibuted outcomes

x = heights %>% filter(sex == "Male") %>% .$height
n = length(x)
avg = mean(x)
s = sd(x)
simulated_heights = rnorm(n, avg, s)
data.frame(simulated_heights = simulated_heights) %>% ggplot(aes(simulated_heights)) +
    +   geom_histogram(color ="black", binwidth = 2)

# tallest in 800 people
B = 10000
tallest = replicate(B, {
    simulated_data = rnorm(800, avg, 5)
    max(simulated_data)
})
mean(tallest >= 7*12)

# d: density, q: quantile, p: probability density function, r: random
# t: student-t, dt, qt, pt, rt
# qnorm(): qunatiles -> q(p, mean = , sd = , lower.tail = TRUE)

x = seq(-4, 4, length.out = 100)
data.frame(x, f = dnorm(x)) %>% ggplot(aes(x,f)) + geom_line()

pnorm((a-mu)/sigma)

# random variable
> beads = rep( c("red","blue"), times = c(2,3))
> beads
[1] "red"  "red"  "blue" "blue" "blue"
> X = ifelse(sample(beads,1) == "blue", 1, 0)

# statistical inference
# sampling models: Roulette
> color = rep(c("Black","Red", "Green"), c(18,18,2))
> n = 1000
> X = sample(ifelse(color == "Red", -1, 1), n, replace = TRUE)
> X[1:10]
[1]  1 -1  1 -1 -1  1 -1  1 -1  1
# or
X = sample(c(-1,1), n, replace =TRUE, prob = c(9/19,10/19))  # <- sampling model
S = sum(X)   # X is a random variable
# distrubution function: F(a) = Pr(S <= a)
# using Monte Carlo
> n = 1000
> B = 10000
> S = replicate(B, {
    + X = sample(c(-1,1), n, replace = TRUE, prob = c(9/19,10/19))
    + sum(X)
    + })
> mean(S <0)
[1] 0.0463

> s = seq(min(S),max(S), length = 100)
> normal_density = data.frame(s = s, f = dnorm(s, mean(S), sd(S)))
> data.frame(S=S) %>% ggplot(aes(S, ..density..)) +
    +   geom_histogram(color = "black", binwidth = 10) +
    +   ylab("Probability") +
    +   geom_line(data = normal_density, mapping = aes(s,f), color = "blue")

# (S+n)/2 : binomial distribution

X = sample(c(17,-1), 1, replace = TRUE, prob = c(p_green, p_not_green)) # random variable
17 * p_green + (-1) * p_not_green # expected value

# Given two possible outcomes, a and b with probability of a equals to p,
# the standard error of the random variable is: |b-a|sqrt(p(1-p))
# Assume two possible outcomes, a and b, with the probability of a equal to p. When spins are independent,
# the standard error of the sum of outcomes: sqrt(n*p*q)*abs(b-a)

# average -> expected value: E[X] = mu
# standard deviation -> standard error: SE[X]: sqrt(n)*sd(x) (independent draws)

# SE[X1+X2+...+Xn] = sqrt(SE[X1]^2 + SE[X2]^2 + ... + SE[Xn]^2)

# Law of Large Numbers/average


## interest rate
> n = 1000
> loss_per_foreclosure = -200000
> p = 0.02
> defaults = sample( c(0,1), n, prob = c(1-p,p), replace = TRUE)
> sum(defaults * loss_per_foreclosure)
[1] -3600000

# Monte Carlo
> B = 10000
> losses = replicate(B, {
    + defaults = sample(c(0,1), n, prob = c(1-p,p), replace = TRUE)
    + sum(defaults*loss_per_foreclosure)
})
> data.frame(losses_in_millions = losses/10^6) %>% ggplot(aes(losses_in_millions))
+ geom_histogram(binwidth = 0.6, col = "black")

# use CLT
> e = n*(p*loss_per_foreclosure + (1-p)*0)
> se = sqrt(n)*abs(loss_per_foreclosure)*sqrt(p*(1-p))

# big short
l = loss_per_foreclosure
z = qnorm(0.01)
x = -l*( n*p - z*sqrt(n*p*(1-p)))/ (n*(1-p) + z*sqrt(n*p*(1-p)))

# expected value of S: {lp + x(1-p)}n
# standard error: |x-l|*sqrt(np(1-p))

# to breakeven
# lp + x(1-p) = 0  => x = -lp/(1-p)  = -loss_per_foreclosure*p/(1-p)


# Pr(S<0) = 0.01
# Pr( (S - E[s])/SE[S]  < -E[S]/SE[S] )
#   Pr(Z < -{lp + x(1-p)}n/|x-l|*sqrt(np(1-p))) = 0.01 => z = qnorm(0.01) = -2.32
# P(Z <= z) = 0.01
#       => -{lp + x(1-p)}n/|x-l|*sqrt(np(1-p)) = qnorm(0.01) = -2.32
#       => x = -l * (np - z*sqrt(np(1-p)))/(n(1-p) + z*sqrt(np(1-p)))
