# percitiles
quantile(heights$height, seq(.01, 0.99, 0.01))


names() # to show the name of a variable
unique()
table() # to compute the frequencies of each unique value
sum(tab == 1) # count the number of times that reported only once
prop.table(table(heights$sex)) # show the propotion of sex in the categorical (eg, height) = frequency table
# categorical -> show distribution with porpotion
# numerical -> show distribution with CDF (culmulative distribution function), report the porpotion of the data below that numeric point
# CDF:  F(a) = Pr(x <= a) ; F(b) - F(a)
# eCDF: Empirical CDF

# smooth density plots: count on a frequency scale, not a count scale. Using bin size appropriate to our data
# we can choose degree of smoothness by ggplot
# AUC = 1

# normal distribution
average = sum(x)/length(x)
SD = sqrt( sum((x-average)^2)/length(x))

index = heights$sex =="Male"
x = heights$height[index]
average = mean(x)
SD = sd(x)

# standard units: z = (x-average)/SD
z = scale(x)
mean(ab(z) < 2)  # use mean function to get the porpotion of a subset data!
[1] 0.95

# eg
x <- heights$height[heights$sex == "Male"]
#average = mean(x)
#SD = sd(x)
#z1 = (69-average)/SD
#z2 = (72-average)/SD
mean(x > 69 & x <= 72)

# review: subset a data.frame
male <- heights$height[heights$sex=="Male"]


pnorm(0)    # pnorm: probability normal distribution
[1] 0.5 # pnorm(x) returns the prob that below (x).
pnorm(2, mean = 5, sd = 3, lower.tail = FALSE)

round() # round numbers, round(123.456, digits=2) [1] 123.46

# quantile-quantile plots (q-q plots): to check how approximated the observed is a normal distribution
observed_quantiles = quantile(x,p) # p = 0.1, 0.2 ,...
theoratical_quantiles = qnorm(p, mean = mean(x), sd = sd(x))
# or we can use standard units
observed_quantiles = quantile(z,p)
theoratical_quantiles = qnorm(p)
plot(theoratical_quantiles, observed_quantiles) # see they're match or not
abline(0,1)

# percentiles, quartiles

# grid, lattice, ggplot2 (grammer of graphics)
# graph components: 1. data  2. geometry  3. aesthetic mappings  4. scale  5. labels, title, legend, etc.
ggplot(data = murders)
# or
murders %>% ggplot()
# assign object
p = ggplot(data = murders)
class(p)
[1] "gg" "ggplot"

# median absolute deviation (MAD). mad(x)

# DATA %>% ggplot() + LAYER1 + LAYER2 + ... + LAYER N
geom_point(x,y, ...)
aes # aesthetic mapping

murders $>$ ggplot() +
    + geom_point(aes(x = population/10^6, y = total))

p = ggplot(data = murders)
p + geom_point(aes(population/10^6, total)) # population & total (local variable) are accessible only in aes()

geom_label # box text
geom_text  # pure text
p + geom_point(aes(population/10^6, total)) + geom_text(aes(population/10^6, total, label = abb))

#tinkering
p + geom_point(aes(population/10^6, total), size = 3) + geom_text(aes(population/10^6, total, label = abb))
# size = 3 => outside of aes()

nudge_x # move the label a little bit
p + geom_point(aes(population/10^6, total), size = 3) + geom_text(aes(population/10^6, total, label = abb), nudge_x = 1)

# global aesthetic mapping
p = murders %>% ggplot(aes(population/10^6, total, lable = abb))
p + geom_point(size = 3) + geom_text(nudge_x = 1.5)

# to overwrite the global aes by local aes
p + geom_point(size = 3) + geom_text(aes(x=10, y= 80, lable = "Hello there!"))

# transform to log scale by scale_x_continuous
p + geom_point(size = 3) + geom_text(nudge_x = 0.075) + scale_x_continuous(trans = "log10") + scale_y_continuous(trans = "log10")
# or
p + geom_point(size = 3) + geom_text(nudge_x = 0.075) + scale_x_log10() + scale_y_log10()

# add title and x/y labels
p + geom_point(size = 3) +
    +  geom_text(nudge_x = 0.075) +
    +  scale_x_log10() +
    +  scale_y_log10() +
    +  xlab("Populations in millions (log scale)") +
    +  ylab("Total number of murders (log scale)") +
    +  ggtitle("US Gun Murders in US 2010")


###############
# redifine the object p to be everything except point layer
p = murders $>$ ggplot(aes(population/10^6, total, label =abb)) +
    +  geom_text(nudge_x = 0.075) +
    +  scale_x_log10() +
    +  scale_y_log10() +
    +  xlab("Populations in millions (log scale)") +
    +  ylab("Total number of murders (log scale)") +
    +  ggtitle("US Gun Murders in US 2010")

# add the point layer, making the point blue
p + geom_point(size = 3 , color = "blue")

# however, we want to apply different color by region, so change the code to:
p + geom_point(aes(col=region), size = 3)
# color automatically apply to different category (here: region). Legends with demo of colors will show up automatically too.

# y = r*x (y: local murder rate, r: avg murder rate in US, x: local population)
r = murders %>% summarize(rate = sum(total)/ sum(population) * 10^6) %>% .$rate
# add the relation line by geom_abline
p + geom_point(aes(col=region), size =3) + geom_abline(intercept = log10(r)) # default line for geom: slope = 1, intercept = 0
# ??? geom_abline(intercept = log10(r)   ?????

p = p + geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
    + geom_point(aes(col=region), size = 3)

# scale_color_discrete
p = p + scale_color_discrete(name = "Region")

# add-on packages: ggthemes, ggrepel
ggthemes
ds_theme_set()
theme_economist

library(ggthemes)
p + theme_economist()
or
p + theme_fivethirtyeight()
geom_text_repel

# build from scratch
library(ggthemes)
library(ggrepel)
# First define the slope of the line
r = murders %>% summarize(rate = sum(total)/sum(population)*10^6) %>% .$rate
# Now make the plot
murders %>% ggplot(aes(population/10^6, total, label =abb)) +
    +   geom_abline(intercept = log10(r), lty =2, color="darkgrey") +
    +   geom_point(aes(col=region), size =3) +
    +   geom_text_repel() +
    +   scale_x_log10() +
    +   scale_y_log10() +
    +   xlab("Population in millions (log scale)") +
    +   ylab("Total number of murders (log scale)") +
    +   ggtile("US Gun Murders in US 2010") +
    +   scale_color_discrete(name = "Region") +
    +   theme_economist()

# make histogram: geom_histogram()
p = height %>% filter(sex =="Male") %>% ggplot(aes(x=height))

p + geom_histogram(binwidth = 1, fill ="blue", col="black") +
    +   xlab("Male heights in inches") +
    +   ggtitle("Histogram")

# make smooth density: geom_density
p + geom_density(fill="blue")

# show by group: group
heights %>% ggplot(aes(height, group = sex)) + geom_density()
# or grouped by color!
heights %>% ggplot(aes(height, color = sex)) + geom_density()
# add alpha blending!
heights %>% ggplot(aes(height, fill = sex)) + geom_density(alpha = 0.2)

# q-q plot: geom_qq()
p = heights %>% filter(sex =="Male") %>% + ggplot(aes(sample = height))
p + geom_()

# dparams argument
params = heights %>% filter(sex == "Male") %>% + summarize(mean = mean(height), sd = sd(height))
p + geom_qq(dparams = params)
## ??? dparams params
+   geom_abline()
# or
height %>% filter(sex =="Male") %>% + ggplot(aes(sample = scale(height))) +
    +   geom_qq() +
    +   geom_abline()

# grid
p = heights %>% filter(sex =="Male") %>% ggplot(aes(x=height))
p1 = p + geom_histogram(binwidth = 1, fill ="blue", col = "black")
p2 = p + geom_histogram(binwidth = 2, fill ="blue", col = "black")
p3 = p + geom_histogram(binwidth = 3, fill ="blue", col = "black")
library(gridExtra)
grid.arrange(p1,p2,p3, ncol=3)