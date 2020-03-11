# Chap05_DataVisualization

# 차트 데이터 생성
chart_data <- c(305,450, 320, 460, 330, 480, 380, 520) 
names(chart_data) <- c("2016 1분기","2017 1분기","2016 2분기","2017 2분기","2016 3분기","2017 3분기","2016 4분기","2017 4분기")
str(chart_data)
chart_data
max(chart_data)


# 1. 이산 변수 시각화
# - 정수단위로 나누어지는 수(자녀수, )


# (1) 막대그래프
?barplot
# 세로막대그래프
barplot(chart_data, ylim = c(0, 600),
        main = "2016 vs 2017년 판매현황",
        col = rainbow(8))

# 가로막대그래프
barplot(chart_data, xlim = c(0, 600),
        horiz = T,
        main = "2016 vs 2017년 판매현황",
        col = rainbow(8))

# 1행 2열 구조
par(mfrow = c(1, 2)) # 1행 2열
VADeaths
str(VADeaths)

row_names <- row.names(VADeaths)
col_names <- colnames(VADeaths)

max(VADeaths) # 71.1

barplot(VADeaths, beside = TRUE, horiz = FALSE, main = "버지니아 사망비율")
barplot(VADeaths, beside = FALSE, horiz = FALSE, main = "버지니아 사망비율")

# 범례추가
legend(x = 3.8, y = 209.5,
       legend = row_names)


# (2) 점그래프
par(mfrow = c(1,1))
dotchart(chart_data,
         color = c("green", "red"),
         lcolor = "black",
         pch = 1:2,
         labels = names(chart_data),
         xlab = "매출액",
         main = "분기별 판매현황",
         cex = 1.2)
dev.off()

# (3) 파이그래프
pie(chart_data,
    labels = names(chart_data),
    border = 'blue',
    col = rainbow(8),
    cex = 1.2)
title("2014-2015년도 분기별 매출현황")

table(iris$Species)
pie(table(iris$Species),
    col = rainbow(3),
    main = "iris 꽃의 종 빈도수")


# 2. 연속변수 시각화
# - 시간, 길이 등의 연속성을 갖는 변수


# 1) 상자 그래프 시각화
summary(VADeaths)
boxplot(VADeaths)


# 2) 히스토그램 시각화 : 대칭성 확인
par(mfrow = c(1,2))
hist(iris$Sepal.Width,
     xlab = 'iris$Sepal.Width',
     col = 'green',
     main = 'iris 꽃받침 넓이 histogram',
     freq = T,
     xlim = c(2.0, 4.5))

hist(iris$Sepal.Width,
     xlab = 'iris$Sepal.Width',
     col = 'mistyrose',
     main = 'iris 꽃받침 넓이 histogram',
     freq = F, # 밀도 표현
     xlim = c(2.0, 4.5))

# 밀도분포 곡선 : 'freq = F' 선행조건 충족 요구
lines(density(iris$Sepal.Width),
      col = 'red')


# 3) 산점도 시각화
x <- runif(n = 15, min = 1, max = 100)
plot(x)

y <- runif(n = 15, min = 5, max = 120)

plot(x, y) # (y ~ x)
plot(y~x)

# col 속성
head(iris, 10)
plot(iris$Sepal.Length, iris$Petal.Length,
     col = iris$Species)

par(mfrow = c(2,2))
price <- rnorm(10)
plot(price, type = "l") # 실선
plot(price, type = "o") # 실선2
plot(price, type = "h") # 직선
plot(price, type = "s") # 꺾은선

plot(price, type = 'o', pch = 5) # 빈 사각형
plot(price, type = 'o', pch = 15) # 채워진 마름모
plot(price, type = 'o', pch = 20, col = 'blue')
plot(price, type = 'o', pch = 20, col = 'orange')

par(mfrow = c(1,1))

# 만능차트
methods(plot)

# plot.ts : 시계열자료
data(WWWusage)
plot(WWWusage) # 추세선

# plot.lm* : 회귀모델
install.packages('UsingR')
library(help = 'UsingR')
data(galton) # 유전학자 Galton : Regression'회귀' 용어 제안
str(galton)

# lm(y ~ x, data = )
model <- lm(child ~ parent, data = galton)
plot(model)
summary(model) # 매우 유의하다


# 4) 산점도 행렬 : 변수 간의 비교
pairs(iris[-5])

# 꽃의 종별 산점도 행렬
table(iris$Species)
pairs(iris[iris$Species == 'setosa', 1:4])


# 5) 차트 파일 저장
setwd("c:/itwill/2_rwork/output")
getwd()
jpeg("iris.jpg", width = 720, height = 480)
plot(iris$Sepal.Length, iris$Petal.Length,
     col = iris$Species)
title(main = 'iris 데이터 테이블 산포도 차트')
dev.off()


# 6) 3차원 산점도
install.packages('scatterplot3d')
library(scatterplot3d)

# 꽃의 종류별 분류 
iris_setosa = iris[iris$Species == 'setosa',]
iris_versicolor = iris[iris$Species == 'versicolor',]
iris_virginica = iris[iris$Species == 'virginica',]

# scatterplot3d(밑변, 오른쪽변, 왼쪽변, type='n') # type='n' : 기본 산점도 제외 
d3 <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type = 'n')

d3$points3d(iris_setosa$Petal.Length, iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width,
            bg = 'orange',
            pch = 21)

d3$points3d(iris_versicolor$Petal.Length, iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width,
            bg = 'blue',
            pch = 23)

d3$points3d(iris_virginica$Petal.Length, iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width,
            bg = 'green',
            pch = 25)
