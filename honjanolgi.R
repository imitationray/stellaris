# honjanolgi
install.packages('dplyr')
install.packages('car')
install.packages('psych')
library(car)
library(help = 'car')
library(dplyr)
library(ggplot2)
library(MASS)
library(readxl)
library(psych)

set.seed(2) # Random number fixed
x <- runif(20, 0, 11) # Random number (count, min value, max value)
y <- 2 + 3*x + rnorm(20, 0, 0.2) # Random number following normal distribution (count, min value, max value)
dfrm <- data.frame(x, y)
dfrm

lm(y ~ x, data = dfrm)
##

set.seed(2)
u <- runif(10, 0, 11)
v <- runif(10, 11, 20)
w <- runif(10, 1, 30)
y <- 3 + 0.1*u + 2*v - 3*w + rnorm(10, 0, 0.1)
dfrm1 <- data.frame(y, u, v, w)
dfrm1

m <- lm(y ~ u + v + w)
m

summary(m)
##

head(ChickWeight)
Chick <- ChickWeight[ChickWeight$Diet == 1, ]

Chick

chick <- ChickWeight[ChickWeight$Chick == 1, ]

chick

lm(weight ~ Time, data = chick)

summary(lm(weight ~ Time, data = chick))
##

data(cars)
head(cars)

speed2 <- cars$speed^2
cars <- cbind(speed2, cars)
head(cars)

lm(dist ~ speed + speed2, data = cars)

summary(lm(dist ~ speed + speed2, data = cars))
##

x <- c(1:9)
y <- c(5, 3, 2, 3, 4, 6, 10, 12, 18)
df1 <- data.frame(x, y)
df1
plot(df1)

x2 <- x^2
x2
df2 <- cbind(x2, df1)
df2
##

lm(y ~ x, data = df1)
summary(lm(y ~ x, data = df1))
plot(lm(y ~ x, data = df1))
##

lm(y ~ x + x2, data = df2)
summary(lm(y ~ x + x2, data = df2))
plot(lm(y ~ x + x2, data = df2))
##

x1 <- c(7, 1, 11, 11, 7, 11, 3, 1, 2, 21, 1, 11, 10)
x2 <- c(26, 29, 56, 31, 52, 55, 71, 31, 54, 47, 40, 66, 68)
x3 <- c(6, 15, 8, 8, 6, 9, 17, 22, 18, 4, 23, 9, 8)
x4 <- c(60, 52, 20, 47, 33, 22, 6, 44, 22, 26, 34, 12, 12)
y <- c(78.5, 74.3, 104.3, 87.6, 95.9, 109.2, 102.7, 72.5, 93.1, 115.9, 83.8, 113.3, 109.4)
df <- data.frame(x1, x2, x3, x4, y)
head(df)

a <- lm(y ~ x1 + x2 + x3 + x4, data = df)
a

summary(a)

b <- lm(y ~ x1 + x2 + x4, data = df)
b

summary(b)

c <- lm(y ~ x1 + x2, data = df)
c

summary(c)
##

step(lm(y ~ 1, df), scope = list(lower = ~ 1, upper = ~ x1 + x2 + x3 + x4), direction = "forward")
##

step(lm(y ~ 1, df), scope = list(lower = ~ 1, upper = ~ x1 + x2 + x3 + x4), direction = "both")
##

data(hills)
head(hills)

step(lm(time ~ 1, hills), scope = list(lower = ~ 1, upper = ~ dist + climb), distriction = "forward")
##

House_p <- read.csv("kc_house_data.csv")
House_p

HP <- lm(price ~ bedrooms + bathrooms + sqft_living + sqft_lot + floors + grade, data = House_p)
summary(HP)
plot(HP)
##

n <- 1000000
es_circle <- function(n){
  data <- cbind(runif(n, min = -1, max = 1),runif(n, min = -1, max = 1))
  colnames(data) <- c('x','y')
  N <- length(which(data[,1]^2 + data[,2]^2 <= 1))
  PI <- N/n * 4
  plot(y~x,data=data, ylim = c(-1,1), xlim = c(-1,1),
       pch = c(20), cex = 0.7, col = 2,
       main = paste('n=',n,' pi =',PI,sep=''))
  abline( v = 0, lwd = 2); abline( h = 0, lwd = 2)
  theta <- seq(-pi,pi,length=1000)
  x<- cos(theta); y<- sin(theta)
  polygon(x,y, lwd=3, border = 4)
}
# install.packages('animation')
# library(animation)
for (i in c(10,100,1000,2000,4000,8000,16000,24000,32000)) {
  es_circle(i)
}
