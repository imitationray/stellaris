# Chap06_Datahandling


# 1. dplyr package

install.packages('dplyr')
library(dplyr)
library(help = dplyr)


# 1) 파이프 연산자 : %>%
# 형식) df %>% func1() %>% func2()

iris %>% head() 
head(iris)

iris %>% head() %>% filter(Sepal.Length >= 5.0) 
# 160 관측치 > 6 관측치 > 3 관측치

install.packages('hflights')
library(hflights)

str(hflights)


# 2) tbl_df() : 콘솔 크기만큼 자료를 구성
hflights_df <- tbl_df(hflights)


# 3) filter() : 행 추출
# 형식) df %>% filter(조건식)
names(iris)
iris %>% filter(Species == 'setosa') %>% head()
iris %>% filter(Sepal.Width > 3) %>% head()
iris_df <- iris %>% filter(Sepal.Width > 3)
str(iris_df)

# 형식) filter(df, 조건식)
filter(iris, Sepal.Width >3)
filter(hflights_df, Month == 1 & DayofMonth == 1)
filter(hflights_df, Month == 3 & DayofMonth == 2)
filter(hflights_df, Month == 1 | Month == 2) %>% arrange(desc(DepTime))


# 4) arrange() : 정렬 함수
# 형식) df %>% arrange(칼럼명)
iris %>% arrange(Sepal.Width) %>% head(5) # 오름차순
iris %>% arrange(desc(Sepal.Width)) %>% head(5) # 내림차순

# 형식) arrange(df, 칼럼명)
arrange(hflights_df, Month, ArrTime, DepTime) # 월 > 출발시간 > 도착시간 순

arrange(hflights_df, Month, ArrTime, desc(DepTime))


# 5) select() : 열 추출
# 형식) df %>% select()
names(iris)
iris %>% select(Sepal.Length, Petal.Length, Species) %>% head()

# 형식) select(df, col1, col2, ...)
select(hflights_df, DepTime, ArrTime, TailNum, Distance)
select(hflights_df, Year:DayOfWeek)

# 문) Month 기준으로 내림차순 정렬하고, Year, Month, AirTime 칼럼 선택하기
select(arrange(hflights_df, desc(Month)), Year, Month, AirTime)


# 6) mutate() : 파생변수 생성
# 형식) df %>% mutate(변수 = 함수 or 수식)
iris %>% mutate(diff = Sepal.Length - Sepal.Width) %>% head()
iris_diff <- iris %>% mutate(diff = Sepal.Length - Sepal.Width)

# 형식) mutate(df, 변수 = 함수 or 수식)
mutate(hflights_df,
       diff_delay = ArrDelay - DepDelay)
hflights_df_delay <- mutate(hflights_df,
                            diff_delay = ArrDelay + DepDelay)

select(hflights_df_delay, ArrDelay, DepDelay, diff_delay)


# 7) summarise() : 통계 구하기
# 형식) df %>% summarise(변수 = 통계함수())
iris %>% summarise(col1_avg = mean(Sepal.Length),
                   col2_SD = sd(Sepal.Width))

# 형식) summarise(df, 변수 = 통계함수())
summarise(hflights_df, 
          delay_avg = mean(DepDelay, na.rm = T),
          delay_tot = sum(DepDelay, na.rm = T))


# 8) group_by(dataset, 집단변수)
# 형식) df %>% group_by(집단변수)
names(iris)
table(iris$Species)
grp <- iris %>% group_by(Species)

summarise(grp, mean(Sepal.Length))

summarise(grp, sd(Sepal.Length))

# group_by() [실습]
install.packages("ggplot2")
library(ggplot2)

data('mtcars') # 자동차 연비
head(mtcars)
str(mtcars)

table(mtcars$cyl) # 4 6 8
table(mtcars$gear) # 3 4 5

# group : cyl
grp <- group_by(mtcars, cyl)

# 각 cyl 집단별 연비 평균/표준편차
summarise(grp,
          mpg_avg = mean(mpg),
          mpg_sd = sd(mpg))

# 각 gear 집단별 무게(wt) 평균/표준편차
grp <- group_by(mtcars, gear)

summarise(grp,
          wt_avg = mean(wt),
          wt_sd = sd(wt))

# 두 집단 변수 -> 그룹화
grp2 <- group_by(mtcars, cyl, gear) # cyl:1차, gear:2차

summarise(grp2,
          mpg_avg = mean(mpg),
          mpg_sd = sd(mpg))

# 형식) group_by(dataset, 집단변수)

# 예제) 각 항공기별 비행편수가 40편 이상이고,
# 평균 비행거리가 2,000마일 이상인 경우의
# 평균 도착지연시간을 확인하시오.

# 1) 항공기별 그룹화
str(hflights_df)
planes <- group_by(hflights_df, TailNum) # 항공기 일련번호

# 2) 항공기별 요약 통계 'n() : 집계함수'
planes_state <- summarise(planes, count = n(), # 비행편수 
          dist_avg = mean(Distance, na.rm = T), # 평균 비행거리
          delay_avg = mean(ArrDelay, na.rm = T)) # 평균 지연시간

# 3) 항공기별 요약 통계 필터링
filter(planes_state, count >= 40 & dist_avg >= 2000)


# 2. reshape2
install.packages('reshape2')
library(reshape2)

# 1) dcast() : long -> wide

data <- read.csv(file.choose()) # data.csv

# Date : 구매일자(col)
# ID : 고객구분자(row)
# Buy : 구매수량
names(data)

# 형식) dcast(dataset, row - col, func)
wide <- dcast(data, Customer_ID ~ Date, sum)
str(wide)
dim(data) # 22 3
dim(wide) # 5 8

data(mpg) # 자동차 연비
str(mpg)

mpg_df <- as.data.frame(mpg)
str(mpg_df)

mpg_df <- select(mpg_df, c(cyl, drv, hwy))
head(mpg_df)

# 교차셀에 hwy 합계
tab <- dcast(mpg_df, cyl ~ drv, sum)

# 교차셀에 hwy 출현 건수
tab2 <- dcast(mpg_df, cyl ~ drv, length)

# 교차분할표
# table(행집단변수, 열집단변수)
tab3 <- table(mpg_df$cyl, mpg_df$drv)
str(tab2) # data.frame
str(tab3) # table

unique(mpg_df$cyl) # 4 6 8 5
unique(mpg_df$drv) # "f" "4" "r"


# 2) melt() : wide -> long
long <- melt(wide, id = 'Customer_ID')
str(long)
# Customer_ID : 기준 칼럼
# variable : 열이름
# value : 교차셀의 값

names(long) <- c('User_ID', 'Date', 'Buy')
long

# example
data('smiths')
smiths

# wide -> long
long <- melt(smiths, id = 'subject') # == long <- melt(smiths, id = 1)

long2 <- melt(smiths, id = 1:2)

# long -> wide
wide <- dcast(long, subject ~ ...) # ... : 나머지


# 3. acast(datasets, 행 ~ 열 ~ 면)
data("airquality")
str(airquality)

table(airquality$Month)
#  5  6  7  8  9 -> 월
# 31 30 31 31 30 -> 일
table(airquality$Day)

# wide -> long
air_melt <- melt(airquality, id = c('Month', 'Day'))
air_melt2 <- melt(airquality, id = c('Month', 'Day'), na.rm = T)
dim(air_melt) # 612 4
dim(air_melt2) # 568 4

table(air_melt$variable)
# Ozone Solar.R    Wind    Temp 
# 153     153     153     153 
table(air_melt2$variable)
# Ozone Solar.R    Wind    Temp 
# 116     146     153     153 
# Ozone과 Solar.R을 제외한 부분은 결측치가 존재하지 않음을 확인할 수 있다.

# [일, 월, variable] ->  [행, 열, 면]
# acast(dataset, Day ~ Month ~ variable)
air_arr3d <- acast(air_melt, Day ~ Month ~ variable) # 
dim(air_arr3d) # 31 5 4 : 31일 5개월 4데이터
# Ozone data
air_arr3d[,,1]
# Solar.R data
air_arr3d[,,2]
# Wind data
air_arr3d[,,3]
# Temp data
air_arr3d[,,4]


# 추가내용 (뇌절)

# 4. URL 만들기 : http://www.naver.com?name='홍길동'
# ? : 쿼리

# 1) base url 만들기
baseurl <- "http://www.sbus.or.kr/2018/lost/lost_02.htm"

# 2) page query 추가
# http://www.sbus.or.kr/2018/lost/lost_02.htm?Page=1
no <- 1:5
library(stringr)
page <- str_c('?Page=', no)
page # "?Page=1" "?Page=2" "?Page=3" "?Page=4" "?Page=5"

# outer(x(1), y(n), func)
page_url <- outer(baseurl, page, str_c)
dim(page_url) # 1 5

# reshape : 2d -> 1d
page_url <- sort(as.vector(page_url))
str(page_url)

# 3) sear query 추가
# http://www.sbus.or.kr/2018/lost/lost_02.htm?Page=1&search=&selectstate=&bus_no=&sear=2
no <- 1:3
sear <- str_c('&sear=', no)

final_url <- outer(page_url, sear, str_c)
final_url <- sort(final_url)
