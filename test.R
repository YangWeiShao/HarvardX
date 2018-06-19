totals = research_funding_rates %>% select(-discipline) %>%
    +   summarize_all(funs(sum)) %>%
    +   summarize(yes_men = awards_men,
                  no_men = applications_men - awards_men,
                  yes_women = awards_women,
                  no_women = applications_women - awards_women)
totals %>% summarize(percent_men = yes_men/(yes_men + no_men),
                     percent_women = yes_women/(yes_women + no_women))

tab = matrix(c(3,1,1,3),2,2)
rownames(tab) = c("Poured Before", "Poured After")
colnames(tab) = c("Guessed before", "Guessed after")

fisher.test(tab, alternative = "greater")

# chi squared tests
# step 1: create a 2-by-2 table
two_by_two = tibble(awarded = c("no","yes"),
                    men = c(total$no_men, total$yes_men),
                    women = c(total$no_women, total$yes_women))
tibble(awarded = c("no", "yes"),
       men = (total$no_men + total$yes_men) * c(1-funding_rate, funding rate),
       women = (total$no_women + total$yes_women) * c(1-funding_rate, funding rate))
# step 2: run chisq.test()
two_by_two %>% select(-awarded) %>% chisq.test()
# summary statistics
odds_men = (two_by_two$men[2] / sum(two_by_two$men)) / (two_by_two$men[1] / sum(two_by_two$men))
odds_women = (two_by_two$women[2] / sum(two_by_two$women)) / (two_by_two$women[1] / sum(two_by_two$women))