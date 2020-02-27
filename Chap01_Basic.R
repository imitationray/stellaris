# Chap01_Basic

# 수업내용
# 1. 패키지와 세션
# 2. 패키지와 사용법
# 3. 변수와 자료형
# 4. 기본함수와 작업공간

# 1. 패키지와 세션
dim(available.packages())
# [1] 15297(패키지의 수)    17(패키지의 정보)
# [1] 15305(패키지의 수)    17
15305 - 15297 # 8
15305 - 15247 # 58
getOption("max.print") # 1000
58 * 17 # 986

# session
sessionInfo() # 세션 정보 제공
# R 환경, OS 환경, 다국어(Locale) 정보, 기본 7 패키지

search()

# 주요 단축키
# script 실행 : Ctrl + Enter
# Sava : Ctrl + S
# 자동완성 : Ctrl + Space bar
# 여러글 주석 Ctrl + Shift
a <- 10
b <- 20
c <- a + b
print(c)

# 2. 패키지 사용법 : package = function + dataset

# 1) 패키지 설치
install.packages('ggplot2')
library(ggplot2)
# 패키지(1) + 의존성 패키지(3)
# 패키지 설치 경로 확인
.libPaths()
# [1] "C:/Program Files/R/R-3.6.2/library"

# 3) in memory : 패키지 -> upload
library(stringr)

str_extract('홍길동35이순신45', '[가-힣]{3}')
# [1] "홍길동"

# 4) 패키지 삭제
remove.packages('stringr')

########################################
## 패키지 설치 Error 해결법
########################################

# 1, Google에 에러 코드 검색

# 2. 최초 패키지 설치
# - RStudio 관리자 모드 실행

# 3. 기존 패키지 설치
# 1) remove.package('패키지')
# 2) rebooting
# 3) install.packages('패키지')

# 4. 변수와 자료
# 1) 변수 : 메모리 이름
# 2) 변수 작성 규칙
# - 첫자는 영문, 두번째는 숫자, 특수문자(_, .)
#   i.g.) score2020 score_2020, score.2020
# - 예약어, 함수명 사용 불가
# - 대소문자 구분
#   i.g.) (NUM = 100) != (nun = 10)
# - 변수 선언시 type 선언 없음
# - score = 90(r) vs int score = 90(c)
# - 가장 최근에 입력한 값으로 변경됨
# - R의 모든 변수는 객체(object)

# 할당 연산자
var1 <- 0 # var1 = 0 : 변수 선언은 '<-' 형식을 권장한다. 선언문 형식과 혼동할 수 있기 떄문이다.
var2 <- 10
var3 <- 20

var1; var2; var3
# [1] 0
# [1] 10
# [1] 20

# 색인(INDEX) : 저장 위치
var3 <- c(10, 20, 30, 40, 50) # "c." = "combine"
var3

# 대소문자
NUM = 100
num = 200
print(NUM == num) # 관계식 -> T/F
# [1] FALSE

# object.member
member.id <- 'Hong'
member.name <- "홍 길 동"
member.age <- 35

member.id
member.name; member.age

# scala(0) vs vector(1)
score <- 95 # scala
scores <- c(85, 75, 95, 100) # vector
score # 95
scores # [1]  85  75  95  100

# 3) 자료형(DATA Type) : 숫자형, 문자형, 논리형

int <- 100
float <- 125.23
string <- "대한민국"
bool <- TRUE

# 자료형 반환 함수
mode(int) # [1] "numeric"
mode(float) # [1] "numeric"
mode(string) # [1] "character"
mode(bool) # [1] "logical"

# in.xxxx
is.numeric(int) # TRUE
is.character(string) # TRUE
is.logical(bool) # TRUE
is.numeric(string) # FALSE

datas <- c(84, 85, 62, NA, 45)
datas # 84 85 62 NA 45

is.na(datas) # 결측치 -> TRUE
# FAUSE FALSE FALSE TRUE FAUSE

# 4) 자료형 변환 함수

# (1) 문자형 -> 숫자형 변환
x <- c(10, 20, 30, '40') # vector(단일 자료형)
x
mode(x) # "numeric" -> "character"
x^2 # Error

x <- as.numeric(x) # "numeric" <- "character"
x*2
x**2
x
plot(x) # 그래프 생성

# (2) 요인형(FACTOR)
# 범주형 변수(집단변수) 생성
# 독립변수(x변수) : 더미변수 생성

gender <- c('남', '여', '남', '여', '여')
mode(gender) # "character"
plot(gender) # Error

# 문자형 -> 요인형 변환
fgender <- as.factor(gender)
mode(fgender) # "numeric"
plot(fgender)

fgender
# [1] 남 여 남 여 여
# Levels : 남 여

str(fgender)
# Factor w/ 2 levels "남","여": 1 2 1 2 2

# moder vs class
mode(fgender) # "numeric" -> 자료형 확인
class(fgender) # "factor" -> 자료구조 확인

# 숫자형 변수
x <- c(4, 2, 4, 2)
mode(x) # "numeric"

# 숫자형 -> 요인형
f <- as.factor(x)
f # [1] 4 2 4 2 
#   Levels: 2 4 -> 2 1 2 1

# 요인형 -> 숫자형
x2 <- as.numeric(f)
x2 # 2 1 2 1

# 요인형 -> 문자형
c <- as.character(f)
c # 4 2 4 2

# 문자형 -> 요인형
x2 <- as.numeric(c)
x2

# 4. 기본 함수와 작업 공간

# 1) 기본 함수 : 기본적인 기능을 위하여 최초로 주어지는 7개의 패키지
sessionInfo() # attached base packages

# 패키지 도움말
library(help ='stats')

# 함수 도움말
help(sum)
x <- c(10, 20, 30, NA)
sum(x, na.rm = TRUE) # 60
sum(1:5) # 15
sum(1, 2, 3, 4, 5) # 15

?mean 
mean(10, 20, 30, NA, na.rm = TRUE) # 10
mean(x, na.rm = TRUE) # 20

# 2) 기본 데이터 셋
library(help = 'datasets')
data() # 데이터셋 확인
data(Nile) # in memory

Nile
length(Nile) # 100
mode(Nile) # "numeric"
plot(Nile)

# 3) 작업공간
getwd() # "C:/ITWILL/2_Rwork"
setwd("c:/itwill/2_rwork/part-i")
getwd() # "C:/itwill/2_rwork/part-i"

emp <- read.csv("emp.csv", header = F)

emp
data()

data(mpg)
mpg
UN
