# Chap07_EDA_Preprocessing


# 1. 탐색적 데이터 조회

# 실습 데이터 읽어오기
getwd()
setwd("C:/ITWILL/2_Rwork/Part-II")
dataset <- read.csv("dataset.csv", header=TRUE) # 헤더가 있는 경우
# dataset.csv - 칼럼과 척도 관계 


# 1) 데이터 조회

# - 탐색적 데이터 분석을 위한 데이터 조회 
dataset

# (1) 데이터 셋 구조
names(dataset) # 변수명(컬럼)
attributes(dataset) # names(), class, row.names
str(dataset) # 데이터 구조보기
dim(dataset) # 차원보기 : 300 7
nrow(dataset) # 관측치 수 : 300
length(dataset) # 칼럼수 : 7 
length(dataset$resident) # 300

# (2) 데이터 셋 조회
# 전체 데이터 보기
dataset # print(dataset) 
View(dataset) # 뷰어창 출력

# 칼럼명 포함 간단 보기 
head(dataset)
head(dataset, 10) 
tail(dataset) 
tail(dataset, 10) 

# (3) 칼럼 조회 
# 형식) dataframe$칼럼명   
dataset$resident
length(dataset$age) # data 수-300개 

# 형식) dataframe["칼럼명"] 
dataset["gender"] 
dataset["price"]

# $ vs index
res <- dataset$resident # $
res2 <- dataset['resident'] # index
str(res) # int [1:300]
str(res2) # 'data.frame': 300 obs. of 1 variable:
dim(res2) # 300 1 -> data.frame

# 형식) dataframe[색인] : 색인(index)으로 원소 위치 지정 
dataset[2] # 두번째 컬럼
dataset[6] # 여섯번째 컬럼
dataset[3,] # 세번째 관찰치(행) 전체
dataset[,3] # 세번째 변수(열) 전체
 # 두번째 열을 제외한 전체
str(dataset['resident'])
str(dataset[1])
str(dataset[,1])

# dataset에서 2개 이상 칼럼 조회
dataset[c("job", "price")]
dataset[c("job":"price")] # error 
dataset[c(2,6)] 
dataset[c(1,2,3)] 
dataset[c(1:3)] # == dataset[1:3]
dataset[c(2,4:6,3,1)] 
dataset[-c(2)] # == dataset[c(1,3:7)], dataset[-2]


# 2. 결측치(NA) 발견과 처리
# 9999999 - NA

# 결측치 확인
summary(dataset$price)

table(is.na(dataset$price))
# FALSE  TRUE 
#   270    30 

table(is.na(dataset))
# FALSE  TRUE 
#  1982   118 


# 1) 결측치 제거
price2 <- na.omit(dataset$price) # 특정칼럼
length(price2) # 270

dataset2 <- na.omit(dataset) # 전체 칼럼
dim(dataset2) # 209 7

# 특정 칼럼 기준 결측치 제거 -> subset 생성
stock <- read.csv(file.choose()) # Part-I/stock.scv
names(stock)
str(stock) # 'data.frame':	6706 obs. of  69 variables:
           # Market.Cap 시가총액
dim(stock) # 6706 69

library(dplyr)
stock_df <- stock %>% filter(!is.na(Market.Cap))
dim(stock_df) # 5028 69

stock_df2 <- subset(stock, !is.na(Market.Cap))
dim(stock_df2) # 5028 69


# 2) 결측치 처리(0으로 대체)
x <- dataset$price
dataset$price2 <- ifelse(is.na(x), 0, x)


# 3) 결측치 처리(평균으로 대체)
dataset$price3 <- ifelse(is.na(x), mean(x, na.rm = T), x)

dim(dataset) # 300 9

head(dataset[c('price', 'price2', 'price3')], 30)


# 4) 통계적 방법의 결측치 처리
# ex) 1 ~ 4 : age 결측치 -> 각 학년별 평균으로 대체
age <- round(runif(n = 20, min = 20, max = 50))
grade <- rep(1:5, 4)

age[5] <- NA
age[8] <- NA

DF <- data.frame(age, grade)

for(i in 1:n){
  
}
is.na(DF[12,1])
age2 <- vector(mode = 'integer', 20)
age2 <- 1:20
for(i in 1:20){
  if(!is.na(DF[i,1])){
    age2[i] <- DF$age[i]
  }else{
    for(r in grade[i]){
      ifelse(!is.na(DF[(DF$grade)==r,1]),
             x <- DF[!is.na(DF$age)&(DF$grade)==r,1],
             DF[(DF$grade)==r,1])
      avg <- sum(x)/length(x)
    }
    age2[i] <- avg
  }
}
DF$age2 <- round(age2)

21+43+45
109/3
35+44+24
103/3
ifelse(!is.na(DF[(DF$grade)==5,1]),
       x <- DF[!is.na(DF$age)&(DF$grade)==5,1],
       DF[(DF$grade)==5,1])


DF[1:12,1]

mean(DF[,])
mean(DF[,1])


# 3. 이상치(outlier) 발견과 정제
# - 정상 범주에서 크게 벗어난 값

# 1) 범주형(집단) 변수
gender <- dataset$gender

# 이상치 발견 : table(), 차트
table(gender)
# 0   1   2   5 
# 2 173 124   1 

# 이상치 정제
dataset <- subset(dataset, gender == 1 | gender == 2)
dim(dataset)
pie(table(dataset$gender))


# 2) 연속형 변수
price <- dataset$price
length(price)
plot(price)
summary(price)

# 2-10 정상 범주
dataset2 <- subset(dataset, price >= 2 & price <= 10)
dim(dataset2)
plot(dataset2$price)
boxplot(dataset2$price)

# dataset2 : age(20~69)
dataset3 <- subset(dataset2, age >= 20 & age <= 69)
boxplot(dataset3$age)


# 3) 이상치 발견이 어려운 경우
boxplot(dataset$price)$stats
# 정상범주에서 상하위 0.3%

re <- subset(dataset, price >= 2.1 & price <= 7.9)
boxplot(re$price)

# [실습]
library(ggplot2)
str(mpg)

hwy <- mpg$hwy
length(hwy)

boxplot(hwy)$stats

# 정제 방법 1) 제거
mpg_df <- subset(mpg, hwy >= 12 & hwy <= 37)
boxplot(mpg_df$hwy)
dim(mpg_df) # 231 11

# 정제 방법 2) NA 처리
hwy_tmp <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
mpg_df <- as.data.frame(mpg)
mpg_df[c('hwy', 'hwy2')]


# 4. 코딩 변경
# - 데이터 가독성, 척도 변경, 최초 코딩 내용 변경


# 1) 데이터 가독성(1,2)
# 형식) dataset$새칼럼[조건식] <- '값'
dataset$gender2[dataset$gender==1] <- '남자'
dataset$gender2[dataset$gender==2] <- '여자'
head(dataset)
head(dataset2)

dataset2$resident2[dataset2$resident==1] <- "1.서울특별시"
dataset2$resident2[dataset2$resident==2] <- "2.인천광역시"
dataset2$resident2[dataset2$resident==3] <- "3.대전광역시"
dataset2$resident2[dataset2$resident==4] <- "4.대구광역시"
dataset2$resident2[dataset2$resident==5] <- "5.시구군"


# 2) 척도 변경 : 연속형 -> 범주형
range(dataset3$age)
# 20~30 : 청년층, 31~55 : 중년층, 56 ~ : 장년층
dataset3$age2[dataset3$age <= 30] <- "청년층"
dataset3$age2[dataset3$age > 30 & dataset3$age <= 55] <- "중년층"
dataset3$age2[dataset3$age > 55] <- "장년층"
head(dataset3)


# 3) 역코딩 : 1 -> 5, 5 -> 1
table(dataset3$survey)

survey <- dataset3$survey
csurvey <- 6 - survey
dataset3$survey <- csurvey

table(dataset3$survey)


# 5. 탐색적 분석을 위한 시각화
# - 변수 간의 관계분석

setwd("c:/itwill/2_rwork/part-ii")

new_data <- read.csv("new_data.csv")
dim(new_data) # 231 15
str(new_data)


# 1) 범주형(명목/서열) vs 범주형(명목/서열)
# - 방법 : 교차테이블, barplot

# 거주지역(5) vs 성별(2)
tab1 <- table(new_data$resident2, new_data$gender2)
barplot(tab1, beside = T, horiz = T,
        col = rainbow(5),
        main = '성별에 따른 거주지역 분포 현황',
        legend = row.names(tab1))

tab2 <- table(new_data$gender2, new_data$resident2)
barplot(tab2, beside = T, horiz = T,
        col = rainbow(2),
        main = '거주지역에 따른 성별 분포 현황',
        legend = row.names(tab2))

# 정사각형 기준
mosaicplot(tab1,
           col = rainbow(5),
           main = '성별에 따른 거주지역 분포 현황')

# 고오급 시각화 : 직업 유형(범주형) vs 나이(범주형)
library(ggplot2) # Chap08

obj <- ggplot(data = new_data, aes(x = job2, fill = age2)) # 미적 객체 생성
obj + geom_bar() # 막대차트 추가
obj + geom_bar(position = 'fill') # y축 밀도화

table(new_data$job2, new_data$age2, useNA = 'ifany')


# 2) 숫자형(비율/등간) vs 범주형(명목/서열)
# - 방법 : boxplot, 카테고리별 통계
install.packages('lattice')
library(lattice) # 격자

# 나이(비율) vs 직업유형(명목)
densityplot( ~ age,
            data = new_data)

densityplot( ~ age,
            groups = job2, # groups = 집단변수 : 각 격자 내에 그룹 효과
            data = new_data)

densityplot( ~ age,
             groups = job2,
             data = new_data,
             auto.key = T) # auto.key = T : 범례 추가


# 3) 숫자형(비율) vs 범주형(명목) vs 범주형(명목)

# (1) 구매금액을 성별과 직급으로 분류
densityplot( ~ price | factor(gender2),
             groups = position2,
             data = new_data,
             auto.key = T)

# | factor(집단변수) : 범주의 수 만큼 격자 생성
# group = 집단변수 : 각 격자 내의 그룹 효과

# (2) 구매금액을 직급과 성별로 분류
densityplot( ~ price | factor(position2),
             groups = gender2,
             data = new_data,
             auto.key = T)


# 4) 숫자형 vs 숫자형 or 숫자형 vs 숫자형 vs 범주형
# - 방법 : 상관계수, 산점도, 산점도 행렬


# (1) 숫자형(age) vs 숫자형(price)
cor(new_data$age, new_data$price) # NA

new_data2 <- na.omit(new_data)
cor(new_data2$age, new_data2$price) # 0.0881251 : +-(0.3 ~ 0.4) 이상
plot(new_data2$age, new_data2$price) # 무상관


# (2) 숫자형 vs 숫자형 vs 범주형(gender)
xyplot(price ~ age | factor(gender2),
       data = new_data)


# 6) 파생변수 생성
# - 기존 변수 -> 새로운 변수
# 1. 사칙연산
# 2. 1:1 : 기존칼럼 -> 새로운 칼럼(1)
# 3. 1:n : 기준변수 -> 새로운 칼럼(n)

user_data <- read.csv("user_data.csv")
str(user_data)


# (1) 1:1 : 기존칼럼 -> 새로운 칼럼(1)
# 더미변수 : 1,2 -> 1 | 3,4 -> 2
user_data$house_type2 <- ifelse(user_data$house_type == 1 |
                                  user_data$house_type == 2,
                                1,
                                2)
table(user_data$house_type2) # 79 321


# (2) 1:n : 기준변수 -> 새로운 칼럼(n)
# 지불정보 테이블
pay_data <- read.csv("pay_data.csv")
str(pay_data)
names(pay_data)
# "user_id"      "product_type" "pay_method"   "price"    

library(reshape2)
# dcase(dataset, 행집단변수 ~ 열집단변수, func)
# long -> wide

# 고객별 상품유형에 따른 구매금액 합계
product_price <- dcast(pay_data,
                       user_id ~ product_type,
                       sum)
product_price
dim(product_price)

names(product_price) <- c("user_id",
                          "식료품(1)",
                          "의류(2)",
                          "생필품(3)",
                          "잡화(4)",
                          "기타(5)")
head(product_price)


# (3) 파생변수 추가(join)
library(dplyr)

# 형식) left_join(df1, df2, by = 'column')
user_pay_data <- left_join(user_data, product_price, by = 'user_id')
head(user_pay_data)


# (4) 사칙연산 : 총구매 금액
names(user_pay_data)
user_pay_data$tot_price <- user_pay_data[,7] + user_pay_data[,8] + user_pay_data[,9] + user_pay_data[,10] + user_pay_data[,11]
user_pay_data
head(user_pay_data)
str(user_pay_data)
