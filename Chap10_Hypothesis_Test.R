# Chap10_Hypothesis_Test


# 가설(Hypothesis) : 어떤 사건을 설명하기 위한 가정 
# 검정(test) : 표본에 의해서 구해진 통계량으로 가설 채택/기각 과정 
# 추정(estimation) : 표본을 통해서 모집단을 확률적으로 추측   


# 검정통계량 : 표본에 의해서 계산된 통계량(표본평균, 표본표준편차)
# 모수 : 모집단에 의해서 나온 통계량(모평균, 모표준편차)  
# 오차 : 검정통계량과 모수 간의 차이 
# 오차범위 : 오차범위가 벗어나면 모수와 차이가 있다고 본다.
# 유의수준 : 오차 범위의 기준(통상 : 알파=0.05)


# 추정 방법 
# 1) 점 추정 : 제시된 한 개의 값과 검정통계량을 직접 비교하여
#    가설 기각유무를 결정 
# ex) 우리나라 중학교 2학년 남학생 평균키는 165.2cm로 추정

# 2) 구간 추정 : 신뢰구간과 검정통계량을 비교하여 가설 기각유무 결정 
# 신뢰구간 : 오차범위에 의해서 결정된 하한값과 상한값의 범위 
# ex) 우리나라 중학교 2학년 남학생 평균키는 164.5 ~ 165.5cm로 추정


# 가설과 검정

# 귀무가설(H0) : 중학교 2학년 평균키는 165.1 ~ 165.3 추정()

# 모집단 -> 표본(1,000명)
x <- rnorm(1000, mean = 165.2, sd = 0.5)
length(x)
hist(x)
# 정규성검정'Shapiro-Wilk normality test'(H0 : 정규분포와 차이가 없다.)
shapiro.test(x)
# data:  x
# W = 0.99836, p-value = 0.4642
# W : 검정통계량 -> p-value : 유의확률
# 검정 : p-value >= 알파(0.05)
# 귀무가설 채택


# 1. 평균차이 검정
t.test(x, mu = 165.2) # One Sample T-test
# data:  x
# t = 1.2295, df = 999, p-value = 0.2192 => 검정통계량(t, df, p >= 0.05)
# alternative hypothesis: true mean is not equal to 165.2
# 95 percent confidence interval: => 95% 신뢰수준
# 165.1886 165.2497 => 신뢰구간(채택역)
# sample estimates:
# mean of x 
# 165.2191 

# 2. 기각역의 평균검정
t.test(x, mu = 165.1)
# data:  x
# t = 7.6556, df = 999, p-value = 4.527e-14 => 검정통계량(t, df, p < 0.05)
# alternative hypothesis: true mean is not equal to 165.1
# 95 percent confidence interval:
# 165.1886 165.2497
# sample estimates:
# mean of x 
# 165.2191 

# 신뢰수준 : 99%
t.test(x, mu = 165.21, conf.level = 0.99)
# data:  x
# t = 0.58693, df = 999, p-value = 0.5574
# alternative hypothesis: true mean is not equal to 165.21
# 99 percent confidence interval:
# 165.1790 165.2593
# sample estimates:
# mean of x 
# 165.2191 
# [해설] 신뢰수준 향상 -> 채택역 확장