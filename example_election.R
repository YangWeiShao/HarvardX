# d ~ N(mu, tau) describes our best guess had we not seen any polling data
# Xbar|d~N(d,sigma) describes randomness due to sampling and the pollster effect

mu = 0
tau = 0.035
sigma = results$se
Y = results$avg
B = sigma^2/(sigma^2+tau^2)
posterior_mean = B*mu + (1-B)*Y
posterior_se = sqrt(1/ (1/sigma^2 + 1/tau^2))

posterior_mean + c(-1.96, 1.96)*posterior_se
1 - pnorm(0, posterior_mean, posterior_se)

# We observe several measurements of the spread: X1,...,XJ; expected value: d; standard error: 2*sqrt(p(1-p)/N)
# Xj = d + epsilonj             epislonj: random variable of poll to poll variability introduced by sampling error

J = 6  # simulate 6 data points
N = 2000
d = 0.021
p = (d+1)/2
X = d + rnorm(J,0,2*sqrt(p*(1-p)/N))
# Xi,j => i: pollster, j: jth poll from that pollster
# Xi,j = d + epsiloni,j
I = 5
J = 6
N = 2000
X = sapply(1:I, function(i){
    d + rnorm(J,0,2*sqrt(p*(1-p)/N))
})

# hi: house effect for the pollster
# Xi,j = d + hi + epsiloni,j
I = 5
J = 6
N = 2000
d = 0.021
p = (d+1)/2
h = rnorm(I, 0, 0.025)
X = sapply(1:I, function(i){
    d + h[i] + rnorm(J, 0, 2*sqrt(p*(1-p)/N))
})

# Xi,j = d + b + hi + epsiloni,j     b is modeled to have expected value 0, general bias
# Xbar = d + b + 1/N * sum(X1...XN)
# sd = sqrt(sigma^2/(N+sigmab^2))

mu = 0
tau = 0.035
sigma = sqrt(results$se^2 + 0.025^2)  # include the general bias variability
Y = results$avg
B = sigma^2/(sigma^2 + tau^2)

posterior_mean = B*mu + (1-B)*Y
posterior_se = sqrt( 1/ (1/sigma^2 + 1/tau^2))
1 - pnorm(0, posterior_mean, posterior_se)

# predicting the electoral college
results_us_election_2016 %>% arrange(desc(electoral_votes)) %>% top_n(5, electoral_votes)

results = polls_us_election_2016 %>%
    +   filter(state != "U.S." & !grepl("CD", state) & enddate >= "2016-10-31" & (grade %in% c("A+","A","A-","B+") | is.na(grade))) %>%
    +   mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) %>%
    +   group_by(state) %>%
    +   summarize(avg = mean(spread), sd = sd(spread), n = n()) %>%
    +   mutate(state = as.character(state))
results %>% arrange(abs(avg))

left_join()
results = left_join(results, results_us_election_2016, by = "state")
results_us_election_2016 %>% filter(!state %in% results$state)
results = results %>% mutate(sd = ifelse(is.na(sd), median(results$sd, na.rm=T), sd))

mu = 0
tau = 0.02
clinton_EV = replicate(1000, {
    +   results %>% mutate(sigma = sd/sqrt(n),     # sigma = sqrt(sd^2/n + bias_sd^2)  => include general bias
                           +   B = sigma^2/(sigma^2 + tau^2),
                           +   posterior_mean = B*mu + (1-B)*avg
                           +   posterior_se = sqrt( 1/ (1/sigma^2 + 1/tau^2)),
                           +   simulated_result = rnorm(length(posterior_mean), posterior_mean, posterior_se),
                           +   clinton = ifelse(simulated_result>0, electoral_votes, 0)) %>%
        +   summarize(clinton = sum(clinton)) %>%
        +   .$clinton + 7 ## 7 for Rhode Island and D.C.
})
mean(clinton_EV > 269)
[1] 0.998    # 0.837

data.frame(clinton_EV) %>% ggplot(aes(clinton_EV)) + geom_histogram(binwidth = 1) + geom_vline(xintercept = 269)

# Forecasting: time.        Focus on 1 pollster
one_pollster = polls_us_election_2016 %>% filter(pollster == "Ipsos" & state == "U.S.") %>% mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)
se = one_pollster %>% summarize(empirical = sd(spread),
                                theoretical = 2*sqrt(mean(spread)*(1-mean(spread))/min(samplesize)))
one_pollster %>% ggplot(aes(spread)) + geom_histogram(binwidth = 0.01, color = "black")

# Yijt = d + b + hj + bt + f(t) + epsilonijt   => bt : time, f(t): trend