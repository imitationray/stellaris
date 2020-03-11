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
