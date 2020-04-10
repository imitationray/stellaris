##########################
## 제17-3장 SVM 연습문제 
##########################

# 문1) 기상데이터를 다음과 같이 SVM에 적용하여 분류하시오. 
# 조건1> 포물라 적용 : RainTomorrow ~ .  
# 조건2> kernel='radial', kernel='linear' 각 model 생성 및 평가 비교 

# 1. 파일 가져오기 
weatherAUS <- read.csv(file.choose()) #weatherAUS.csv
weatherAUS <- weatherAUS[ , c(-1, -2, -22, -23)] # 칼럼 제외 
str(weatherAUS)

# 2. 데이터 셋 생성 
set.seed(415)
idx <- sample(1:nrow(weatherAUS),
              0.7*nrow(weatherAUS))
training_w <- weatherAUS[idx, ]
testing_w <- weatherAUS[-idx, ]

dim(training_w)
dim(testing_w)
training_w <- na.omit(training_w)
testing_w <- na.omit(testing_w)

# 3. 분류모델 생성 : kernel='radial'(cost, gamma), kernel='linear'(cost) 
model_w <- svm(RainTomorrow ~ .,
               data = training_w,
               na.action = na.omit)

model_w2 <- svm(RainTomorrow ~ .,
                data = training_w,
                na.action = na.omit,
                kernel = 'linear')

# 4. 분류모델 평가
pred_w <- predict(model_w,
                  testing_w)

pred_w2 <- predict(model_w2,
                   testing_w)

tab <- table(testing_w$RainTomorrow,
             pred_w)
tab
(tab[1,1] + tab[2,2]) / sum(tab)

tab2 <- table(testing_w$RainTomorrow,
              pred_w2)
tab2
(tab2[1,1] + tab2[2,2]) / sum(tab2)

# 문2) 문1에서 생성한 모델을 tuning하여 최적의 모델을 생성하시오.
params <- c(0.001, 0.01, 0.1, 1, 10, 100, 1000)
length(params)
tuning <- tune.svm(RainTomorrow ~ .,
                   data = testing_w,
                   gamma = params,
                   cost = params)

tuning

best_model <- svm(RainTomorrow ~ ., 
                  data = training_w,
                  gamma = 0.001,
                  cost = 100)

pred <- predict(best_model,
                testing_w)

tab <- table(testing_w$RainTomorrow,
             pred)
(tab[1,1] + tab[2,2]) / sum(tab)
