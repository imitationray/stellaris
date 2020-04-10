#####################################
## 제16-1장 DecisionTress 연습문제 
#####################################

library(rpart) # rpart() : 분류모델 생성
library(rpart.plot) # prp(), rpart.plot() : rpart 시각화
library(rattle) # fancyRpartPlot() : node 번호 시각화 

# 01. Spam 메시지 데이터 셋을 이용하여 DT 분류모델을 생성하고.
# 정분류율, 오분류율, 정확률을 구하시오. 
# 실습 데이터 가져오기
sms_data <- read.csv(file.choose()) # sms_spam_tm.csv
dim(sms_data) # [1] 5558(row) y = (type), x = 6824(word)
sms_data$sms_type
names(sms_data)
str(sms_data)
table(sms_data$sms_type)
sms_data$X

# 1. train과 test 데이터 셋 생성 (7:3)
idx <- sample(nrow(sms_data), nrow(sms_data) * 0.7)

train <- sms_data[idx,]
test <- sms_data[-idx,]
dim(train)
dim(test)

table(train$sms_type)

# 2. model 생성 - train_sms : rpart(sms_type~., data = train)
model <- rpart(sms_type ~ .,
               data = train)
model
prp(model)

# 3. 예측치 생성 - test_sms
pred <- predict(model, test)
mean(pred[,1])
mean(pred[,2])

pred <- predict(model, test, type = 'class')
pred
tab <- table(test$sms_type, pred)


# 4. 분류정확도 : 정분류율, 오분류율, 정확률, 재현율 
tab
(tab[1,1] + tab[2,2]) / nrow(test)
tab[1,1]/(tab[1,1] + tab[1,2])
tab[2,1]/(tab[2,1] + tab[2,2])

(tab[1,2] + tab[2,1]) / nrow(test)

tab[1,1] / (tab[1,1] + tab[1,2])

recall <- tab[2,2] / (tab[2,1] + tab[2,2])
recall
precision <- tab[2,2] / (tab[1,2] + tab[2,2])
precision

F1_score <- 2 * ((recall * precision) / (recall + precision))
F1_score

# 02. weather 데이터를 이용하여 다음과 같은 단계별로 의사결정 트리 방식으로 분류분석을 수행하시오. 

# 조건1) y변수 : RainTomorrow, x변수 : Date와 RainToday 변수 제외한 나머지 변수로 분류모델 생성 
# 조건2) 모델의 시각화를 통해서 y에 가장 영향을 미치는 x변수 확인 
# 조건3) 비가 올 확률이 50% 이상이면 ‘Yes Rain’, 50% 미만이면 ‘No Rain’으로 범주화

# 단계1 : 데이터 가져오기
library(rpart) # model 생성 
library(rpart.plot) # 분류트리 시각화 

weather <- read.csv(file.choose(), header=TRUE) # weather.csv

# 단계2 : 데이터 샘플링
weather.df <- weather[, c(-1,-14)]
idx <- sample(1:nrow(weather.df), nrow(weather.df)*0.7)

weather_train <- weather.df[idx, ]
weather_test <- weather.df[-idx, ]

# 단계3 : 분류모델 생성
model <- rpart(RainTomorrow ~ ., data = weather_train)

# 단계4 : 분류모델 시각화 - 중요변수 확인 
model
rpart.plot(model)

# 단계5 : 예측 확률 범주화('Yes Rain', 'No Rain') 
pred <- predict(model, weather_test)
pred
str(pred)

y_pred <- ifelse(pred[,1] >= 0.5, 'No Rain', 'Yes Rain')
y_pred
y_true <- weather_test$RainTomorrow

# 단계6 : 혼돈 matrix 생성 및 분류 정확도 구하기
tab <- table(y_true, y_pred)

(tab[1,1] + tab[2,2]) / nrow(weather_test)


#########