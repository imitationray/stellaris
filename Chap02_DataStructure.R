# Chap02_DataStructure

# 자료구조의 유형(5)

# 1. vector 자료구종
# - 동일한 자료형을 갖는 1차원 배열구조
# - 생성 함수 : c(), seq(), rep()

# (1) c()
x <- c(1, 3, 5, 7)
y <- c(3, 5)
length(x) # 4

# 집합관련 함수
union(x, y) # 1, 3, 5, 7 : x + y
setdiff(x, y) # 1, 7 ; x - y
intersect(x, y) # 3, 5 

# 벡터 변수 유형
num <- 1:5
num
num <- c(-10 : 5)
num
num <- c(1, 2, 3, "4")
num # [1] "1" "2" "3" "4"

# 벡터 원소 이름 지정
names <- c("Hong", "Lee", "Kang")
names # [1] "Hong" "Lee"  "Kang"
age <- c(35, 45, 55)
age # [1] 35 45 55
names(age) <- names
mode(age)
mean(age) # 45
structure(age) # Hong  Lee  Kang
               #   35   45    55
# str(age)
# Named num [1:3] 35 45 55 -> data
# - attr(*, "names") = chr [1:3] "Hong" "Lee", "Kang" -> names
namecard <- data.frame(names, age)

# 2) seq()
help(seq)
num <- seq(1, 10, by = 2)
num # 1 3 5 7 9

num2 <- seq(10, 1, by = -2)
num2

# 3) rep()
help(rep) # rep(x, ...)
rep(1:3, times = 3) # [1] 1 2 3 1 2 3 1 2 3
rep
rep(1:3, each = 3) # [1] 1 1 1 2 2 2 3 3 3

# 색인(INDEX) : 저장 위치
# 형식 - object[n]
a <- 1:50
a # 전체 원소
a[10] # 10 -> 특정 원소 한 개
a[10:20] # 10~20
a[10:20, 30:35] # [행, 열] - Error
a[c(10:20, 30:35)] # # 10~20, 30~35

# 함수 이용
length(a) # 길이 = 원소 개수
a[10:length(a)-5] # 5~45
a[10:(length(a)-5)] # 10~45
a[seq(2, length(a), by = 2)]

# 특정 원소 제외
a[-c(15, 25, 30:35)]

# 조건식(boolean)
a[a >= 10 & a <= 30] # 10~30 : &(and)
a[a >= 10 | a <= 30] # 1~50 : |(or)
a[!(a >= 10)] # !(not)

# 2. Matrix 자료구조
# - 동일한 자료형을 갖는 2차원 배열구조
# - 생성 함수 : matrix(), rbind(), cbind()
# - 처리 함수 : apply()

# (1) matrix
m1 <- matrix(data = c(1:5)) # 1차원 -> 2차원 (행 : n, 열 : 1)
m1
dim(m1) # 5 x 1
mode(m1)
class(m1)

m2 <- matrix(data = c(1:9), nrow = 3, ncol = 3, byrow = TRUE)
m2

dim(m2) # 3 x 3

# (2) rbind
x <- 1:5
y <- 6:10
x
y
m3 <- rbind(x, y)
m3
dim(m3) # 2 x 5 = 10

# (3) cbind()
m4 <- cbind(x, y)
m4
dim(m4) # 5 x 2 = 10

# 색인(Index) : Matrix
# 형식 object[row, column]

m5 <- matrix(data = c(1:9), nrow = 3, ncol = 3)
m5

# 특정 행 색인
m5[1,]
m5[,1]
m5[2:3,1:2]
m5[1,2:3]
m5[2,3]

# - 속성
m5[-2,] # 2행 제외
m5[,-3] # 3열 제외
m5[, -c(1, 3)] # 2개 행 제외

# 열(칼럼 = 변수 = 변인) 이름 지정
colnames(m5) <- c("one", "two", "three")
m5
m5[,'one']
m5[,'one':'two'] # (!)
m5[, 1:2]
m5

# broadcast 연산
# - 작은 차원 -> 큰 차원 늘어나서 연산

x <- matrix(1:12, nrow = 4, ncol = 3, byrow = T)
dim(x)
x

# 1) scala(0) vs matrix(2)
0.5 * x 
x * 0.5
# 2) vactor(1) vs matrix(2)
y <- 10:12
y + x

# 3) 동일한 모양(SHAPE)
x + x
x - x

# 전치행렬 : 행 -> 열, 열 -> 행
x
t(x)

# 처리 함수 : apply()
help(apply)

# apply(x, MARGIN(1/2), FUNC, ...)
x
apply(x, 1, sum) # 행 단위 합계
apply(x, 2, mean) # 열 단위 평균
apply(x, 1, var) # 행 단위 분산
apply(x, 1, sd) # 행 단위 표준편차

# 3. Array 자료구조
# - 동일한 자료형을 갖는 3차원 배열구조
# - 생성 함수 : array()

# 1차원 -> 3차원
arr <- array(data = c(1:12), dim = c(3, 2, 2))
arr
dim(arr) # 3(행) 2(열) 2(면)

# 색인(INDEX)
arr[, , 1] # 1면
arr[, , 2] # 2면

data()
data('iris3')
iris3
dim(iris3) # 50 * 4 * 3
50 * 4 * 3 # 600

# 붓꽃 dataset
iris3[, , 1] # 꽃의 종1
iris3[, , 2] # 꽃의 종2
iris3[, , 3] # 꽃의 종3

iris3[10:20, 1:2, 1] # 꽃의종1

# 4. data frame
# - '열 단위 서로 다른 자료형'을 갖는 2차원(행렬) 배열 구조
# - 생성 함수 : data.frame()
# - 처리 함수 : apply() -> 행렬 처리

# 1) vector 이용
no <- 1:3
name <- c("홍길동", "이순신", "유관순")
pay <- c(250, 350, 200)

emp <- data.frame(NO = no, NAME = name, PAY = pay)
emp
dim(emp) # 3 3
class(emp) # data.frame

# 자료 참조 : 칼럼 참조 or index 참조
pay <- emp$PAY #특성 칼럼 -> vector 추출
pay
mean(pay)
sd(pay)

#형식) object[row.columm]
emp_row <- emp[c(1, 3), ] # emp[-2, ]
emp_row

# 2) csv, test file, DB table
setwd("c:/ITWILL/2_Rwork/Part-I")
getwd()

emp_txt <- read.table("emp.txt", header = T)
emp_txt

emp_csv <- read.csv("emp.csv",header = T)
emp_csv

# [실습]
sid <- 1:3 # 이산형
score <- c(90, 85, 83) # 연속형
gender <- c('M', 'F', 'M') # (문자형)범주형

student <- data.frame(SID = sid, SCORE = score, GENDER = gender)
student

# 자료구조 보기
str(student)
# 'data.frame':	3 obs. of  3 variables:
# $ SID   : int  1 2 3
# $ SCORE : num  90 85 83
# $ GENDER: Factor w/ 2 levels "F","M": 2 1 2

student <- data.frame(SID = sid, SCORE = score, GENDER = gender, stringsAsFactors = F)
student
# stringsAsFactors = (T | F) : 문자형 -> 요인형 변환 여부

str(student)
# 'data.frame':	3 obs. of  3 variables:
# $ SID   : int  1 2 3
# $ SCORE : num  90 85 83
# $ GENDER: chr  "M" "F" "M"

# 특정 컬럼 -> vector
x <- student$SCORE
x
mean(x)
sum(x)
var(x)
student

# 표준편차
sqrt(var(x))
sd(x)

# 산포도 : 분산, 표준편차

# 모집단에 대한 분산, 표준편차
# 분산 = sum((x - 산술평균)^2)/n
# 표준편차 = sqrt(분산)
# 표본에 대한 분산, 표준편차 : R 함수
# 분산 = sum((x-산술평균)^2)/(n-1)
# 표준편차 = sqrt(분산)

avg <- mean(x)
diff <- (x - avg)^2 # (vector -scala)
sum(diff)/(length(x)-1)
VAR <- sum(diff) / (length(x) - 1)
VAR
SD <- sqrt(VAR)
SD
summary(student)

# 5. List 자료구조
# - key와 value 한 쌍으로 자료가 저장된다.
# - key는 중복 불가. value는 중복 가능하다.
# - key를 통해서 값(value)을 참조한다.
# - 다양한 자료구조와 자료형을 갖는다.

# 1) key 생략 : [key1 = value, key2 = value]
lst <- list('Lee', '이순신', 35, 'Hong', '홍길동', 30)
lst
# 첫 번째 원소
# [[1]]           : 기본키(Default key)
# [1] "Lee"       : 값1(value)

# 두 번째 원소
# [[2]]           : 기본키(Default key)
# [1] "이순신"    : 값2(value)

lst[1]          # : 첫 번째 원소 INDEX
lst[6]          # : 마지막 원소 INDEX

# key -> value 참조
lst[[5]]        # : "홍길동

# 2) key = value
lst2 <- list(first = 1:5, second = 6 : 10 )
lst2

# $first
# [1] 1 2 3 4 5

# $second
# [1]  6  7  8  9 10

# key -> value 참조
lst2$first # 2 3 4 4
lst2$second # 6  7  8  9 10
lst2$second[2:4] # 7  8  9

# data.frame($) vs lise($)
# data.frame$칼럼명
# list$키명

# 3) 다양한 자료형 

lst3 <- list(name = c("홍길동", "유관순"),
            age = c(35, 25),
            gender = c('M', 'F'))
lst3
mean(lst3$age) # 30

# 4) 다양한 자료구조(vector, matrix, array)
lst4 <- list(one = c('one', 'two', 'three'),
             two = matrix(1:9, nrow = 3),
             three = array(1:12, c(2, 3, 2)))
lst4
# $one : 1차원
# $two : 2차원
# $three : 3차원

# 5) list 형변환
multi_list <- list(r1 = list(1, 2, 3),
                   r2 = list(10, 20, 30),
                   r3 = list(100, 200, 300))
multi_list

mat <- do.call(rbind, multi_list)
mat

# list 처리 함수
x <- list(1:10) # key 생략 : [[n]]
x

# list -> vector
v <- unlist(x)
v

a <- list(1:5)
b <- list(6:10)

a;b

# list 객체에 함수 적용
lapply(c(a, b), max) # list 반환
sapply(c(a, b), max) # vector 반환

# 6. 서브셋(subset)
# - 특정 행 또는 열 선택 -> 새로운 dataset 생성

x <- 1:5
y <- 6:10
z <- letters[1:5]
df <- data.frame(x, y, z)
df

help("sebset")
# subset(x, subset, select, drop = FALSE, ...)

# 1) 조건식으로 subset 생성
df2 <- subset(df, x >= 2)
df2

# 2) select로 subset 생성 : 칼럼 기준
df3 <- subset(df, select = c(x, z))
df3

# 3) 조건식 & select
df4 <- subset(df, x >= 2 & x <= 4, select = c(x, z))
df4

class(df2)
class(df3)
class(df4)

df

# 4) 특정 칼럼의 특정 값으로 subset 생성
df5 <- subset(df, z %in% c('a', 'c', 'e')) # %in% 연산자
df5

# [실습] iris dataset 이용subset 생성
iris
str(iris)
#'data.frame':	150 obs. of  5 variables:
# $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
# $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
# $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
# $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

iris_df <- subset(iris, Sepal.Length >= mean(Sepal.Length), 
                  select = c(Sepal.Length, Petal.Length, Species))
str(iris_df)
#'data.frame':	70 obs. of  3 variables:
# $ Sepal.Length: num  7 6.4 6.9 6.5 6.3 6.6 5.9 6 6.1 6.7 ...
# $ Petal.Length: num  4.7 4.5 4.9 4.6 4.7 4.6 4.2 4 4.7 4.4 ...
# $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 2 2 2 2 2 2 2 2 2 2 ...


# 7. 문자열 처리와 정규표현식 
install.packages("stringr")
library(stringr)

string = "hong35lee45kang55유관순25이사도시45"
string
# [1] "hong35lee45kang55유관순25"

# 메타문자 : 패턴지정 특수 기호   

# 1. str_extract_all

# 1) 반복관련 메타문자 : [x] : x 1개, {n} : n개 연속   
str_extract_all(string, "[a-z]{3}") # 영문소자 3개 연속 
#[[1]] -> key
#[1] "hon" "lee" "kan" -> value
str_extract_all(string, "[a-z]{3,}") # 3자 이상 연속 
#[[1]]
#[1] "hong" "lee"  "kang"

name <- str_extract_all(string, "[가-힣]{3,}") # 한글 3자 이상 
# list -> vector 
unlist(name)
# [1] "유관순"   "이사도시"

name <- str_extract_all(string, "[가-힣]{3,5}") # 3자~5자 사이 
name

# 숫자(나이) 추출 : 문자형  
ages <- str_extract_all(string, "[0-9]{2,}")
# list -> vector 변경 
ages_vec <- unlist(ages) # "35" "45" "55" "25" "45"
# 문자형 -> 숫자형 변환 
num_ages = as.numeric(ages_vec)

cat('나이 평균=', mean(num_ages)) # 나이 평균= 41

# 2) 단어와 숫자 관련 메타문자 
# 단어 : \\w
# 숫자 : \\d

jumin <- "123456-4234567"

str_extract_all(jumin, "[0-9]{6}-[1-4]\\d{6}")
# "123456-1234567" - 패턴과 일치된 경우 
# character(0) - 일치되지 않은 경우 

email <- "kp1234@naver.com"
str_extract_all(email, "[a-z]{3,}@[a-z]{3,}.[a-z]{2,}")
# character(0)

# \\w : 영,숫,한 -> 특수문자 제외 
str_extract_all(email, "[a-z]\\w{3,}@[a-z]{3,}.[a-z]{2,}")
# [1] "kp1234@naver.com"

email2 <- "kp1$234@naver.com"
str_extract_all(email2, "[a-z]\\w{3,}@[a-z]{3,}.[a-z]{2,}")
# character(0)

# 3. 접두어(^)/접미어($) 메타문자 
email3 <- "1kp1234@naver.com"
str_extract_all(email3, "[a-z]\\w{3,}@[a-z]{3,}.[a-z]{2,}")
# [1] "kp1234@naver.com"

str_extract_all(email3, "^[a-z]\\w{3,}@[a-z]{3,}.[a-z]{2,}")
# character(0)

str_extract_all(email3, "^[a-z]\\w{3,}@[a-z]{3,}.com$")


# 4) 특정 문자 제외 메타문자 
string
# [1] "hong35lee45kang55유관순25이사도시45"

result <- str_extract_all(string, "[^0-9]{3,}") # 숫자 제외, 나머지 반환 
result # [[1]] : 기본키 

# 불용어 제거 : 숫자, 영문자, 특수문자 
name <- str_extract_all(result[[1]], "[가-힣]{3,}")
unlist(name)
# [1] "유관순"   "이사도시"


# 2. str_length : 문자열 길이 반환 
length(string) # 1
str_length(string) # 28

# 3. str_locate/ str_locate_all
str_locate(string, 'g')
str_locate_all(string, 'g')
#      start end
#[1,]     4   4
#[2,]    15  15

# 4. str_replace/str_replace_all
str_replace_all(string, "[0-9]{2}", "") # 숫자제거 
# "hongleekang유관순이사도시"

# 5. str_sub : 부분 문자열 
str_sub(string, start = 3, end = 5)
# "ng3"  

# 6. str_split : 문자열 분리(토큰)
string2 = "홍길동 이순신 강감찬 유관순"
result <- str_split(string2, " ")
result

name <- unlist(result)
name # [1] "홍길동" "이순신" "강감찬" "유관순"

# 7. 문자열 결합(join) : 기본함수 
paste(name, collapse =" " )
# [1] "홍길동,이순신,강감찬,유관순"