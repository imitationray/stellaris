# Chap03_DataID


# 1.data 불러오기(키보기 입력, 파일 가져오기)

# 1) 키보드 입력
x <- scan()
10
20  
30
40
50
60
70
80
90
100
sum(x)
mean(x)
summary(x)

# 문자 입력
string <- scan(what = character())
"홍길동"
"유관순"
"이순신"
string

# 2) 파일 읽기

# (1) read.table() : 칼럼 구분(공백, 특수문자)

setwd("C:/ITWILL/2_Rwork/Part-I")

# txt file 가져오기
student <- read.table("student.txt") # 칼럼명이 없을 경우 기본 제목을 제공한다. V1, V2, V3...

# 칼럼명이 있는 경우
student2 <- read.table("student2.txt", header = TRUE, sep = ";")
student2

# 결측치 처리하기(NULL)
student3 <- read.table("student3.txt", header = TRUE, na.strings = c("-", "&"))
student3

mean(student3$키, na.rm = T) # na.rm 결측치 제외 여부
str(student3)
class(student3)


# (2) read.csv() : 구분자 : 콤마(,)
student4 <- read.csv("student4.txt", na.strings = c("-", "&"))#, header = T, sep = ",")
student4

# 탐색기 이용 : 파일 선택
excel <- read.csv(file.choose()) # excel.csv
excel


# (3) xlx/xlsx : 패키지 설치
install.packages('readxl')
install.packages('xlsx')
library(rJava)
library(xlsx)

kospi <- read.xlsx("sam_kospi.xlsx", sheetIndex = 1)
kospi

# 한글이 포함된 xlsx 파일 읽기
st_excel <- read.xlsx("studentexcel.xlsx", sheetIndex = 1, encoding = "UTF-8")
st_excel

# 인터넷 파일 읽기
titanic <- read.csv("https://vincentarelbundock.github.io/Rdatasets/csv/COUNT/titanic.csv")
titanic
dim(titanic)
head(titanic)

# 생존여부
table(titanic$survived)

# 성별구분
table(titanic$sex)

# class 구분
table(titanic$class)

# 성별 vs 생존여부 : 교차분할표
survivals <- table(titanic$survived, titanic$sex)

titanic

barplot(survivals)

getOption("max.print")
200*5

# 행 제약 풀기
options(max.print = 99999999)

titanic


# 2. 데이터 저장(출력)하기

# 1) 화면 출력
x <- 20

y <- 30

z <- x + y

z

cat('z =',z) # z = 50

print(z) # 함수 내에서 출력
print('z = ', z) # (!)


# 2) 파일 저장(출력)
# read.table -> write.table : 구분자(공백, 특수문자)
# read.csv -> write.csv : 구분자(콤마)
# read.xlsx -> write.xlsx : 엑셀(패키지 필요)

# (1) write.table() : 공백
setwd("c:/ITWILL/2_Rwork/output")

write.table(titanic, "titanic.txt", row.names = FALSE)
write.table(titanic, "titanic2.txt", quote = FALSE, row.names = FALSE)

# (2) write.csv() : 콤마
head(titanic)
titanic_df <- titanic[-1] # x 칼럼 제외
titanic_df
str(titanic_df)

write.csv(titanic_df, "titanic.csv",row.names = F, quote = F)

# (3) write.xlsx : 엑셀 파일
search() # package:xlsx
write.xlsx(titanic, "titanic.xlsx", sheetName = "thitanic")
