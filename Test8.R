#################################
## <제8장 연습문제>
################################# 

#01. 다음 조건에 맞게 airquality 데이터 셋의 Ozone과 Wind 변수를 대상으로  
# 다음과 같이 산점도로 시각화 하시오.

#조건1) y축 : Ozone 변수, x축 : Wind 변수 
#조건2) Month 변수를 factor형으로 변경  
#조건3) Month 변수를 이용하여 5개 격자를 갖는 산점도 그래프 그리기

head(airquality)
str(airquality)

dotplot(Ozone ~ Wind | factor(Month), data = airquality)
air_df <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = air_df)

# 02. 서울지역 4년제 대학교 위치 정보(Part-II/university.csv) 파일을 이용하여 레이어 형식으로 시각화 하시오.

# 조건1) 지도 중심 지역 SEOUL, zoom=11
# 조건2) 위도(LAT), 경도(LON)를 이용하여 학교의 포인트 표시
# 조건3) 각 학교명으로 텍스트 표시
# 조건4) 완성된 지도를 "university.png"로 저장하기(width=10.24,height=7.68) 

library(ggmap)
university <- read.csv("c:/itwill/2_rwork/part-ii/university.csv")
university # 학교명, LAT, LON

# 지도정보 생성
seoul <- c(left = 126.85, bottom = 37.35,
           right = 127.25, top = 37.65)
map <- get_stamenmap(seoul, zoom = 11, maptype = 'watercolor')

# (1)레이어1 : 정적 지도 생성
layer1 <- ggmap(map)

# (2)레이어2 : 지도 위에 포인트
layer2 <- layer1 + geom_point(data = university,
                              aes(x = LON,
                                  y = LAT))
layer3 <- layer2 + geom_text(data = university,
                             aes(x = LON + 0.01,
                                 y = LAT - 0.003,
                                 label = 학교명),
                             size = 2.8)
ggsave("c:/itwill/2_rwork/output/university.png", scale = 1, width = 10.24, height = 7.68)
