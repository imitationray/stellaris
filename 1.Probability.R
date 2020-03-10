##### 1. Probability and Counting




#### 1. 확률의 응용 분야


# 물리학 - Boltzmann's Entropy Formula, 'S = K log W'
# 유전학 - Mendelian inheritance
# 역사학 - 미국 헌법 인준에 관한 내용을 담은'연방주의자 문건'의 저자들을 추론하기 위한 Mosteller & Wallace의 베이즈 확률 규칙 적용 연구 사례.
#        [Mosteller, F. and D. L. Wallace. Inference and Disputed Authorship: The Federalist. Reading, MA., 1964]
# 경영학 - 그리고 얘네들은
# 경제학 - 확률과 통계적인
# 심리학 - 부분을 배제하면
# 금융공학 - 이론 자체를
# 산업공학 - 설명할 수 없음
# 게임이론
# Gambling
# ......
# "LIFE : The logic of uncertainty."




#### 2. Sample space


# 표본공간은 어떤 실험에서 가능한 모든 경우의 집합을 의미
# 여기서 말하는 '어떤 실험', -> 굉장히 폭넓고 포괄적인 함의
# Do anything -> Certain possible outcome
# "A sample space is the set of all possible outcomes of an experiment."




#### 3. Event


# 사건은 표본공간의 부분집합을 의미
# 집합 개념의 발견 -> 확률이 하나의 수학적 개념으로 인정
# "An event is a subset of the sample space."
# 확률에서는 직관적이라고 생각한 것들이 완전히 틀리는 경우가 많기 때문에 보다 수학적으로 접근해야 한다.
# 수학적 관점 -> 사건을 부분집합으로 도식화 -> 확률의 수학적 진전



### Naive def.
#
# P(A) = (favorable outcomes)/(possible outcomes) -> 사건 'A'에 대한 확률'P'
#        분자는 사건 'A'가 일어날 가능이 있는 경우의 수
#        분모는 곧 표본공간의 크기 = 발생 가능한 모든 경우의 수
#
# 예를 들어, 한 개의 동전을 두 번 튕기는 실험을 한다면 총 네 가지의 발생 가능한 경우의 수를 예상할 수 있을 것이다.
# 첫 번째 시행에서 앞 면이 나오는 경우, = f1
# 첫 번째 시행에서 뒷 면이 나오는 경우, = b1
# 두 번째 시행에서 앞 면이 나오는 경우, = f2
# 두 번째 시행에서 뒷 면이 나오는 경우, = b2

# 이때, 두 번 모두 뒷면이 나오는 경우의 확률은 어떻게 될 것인가.

1/2 # 0.5, 동전의 뒷면이 나올 확률

Fst <- 1/2 # 첫 번째 시행값 입력, b1/(f1+b1)

Snd <- 1/2 # 두 번째 시행값 입력, b2/(f2+b2)

Fst # 첫 번째 시행 = 0.5

Fst * Snd # 두 번째 시행 = 0.25

#   b1/(f1+b1) * b2/(f2+b2)
# = (b1+b2)/(f1+f2+b1+b2)

# 6개의 면을 가진 주사위 두 개(x, y)를 굴리는 실험과 가능한 모든 경우의 수.

x <- c(1:6) # 1 2 3 4 5 6의 눈을 가진 주사위 'x' 설정

y <- c(1:6) # 1 2 3 4 5 6의 눈을 가진 주사위 'y' 설정

xeve <- length(x) # 주사위 x가 일으킬 수 있는 모든 경우의 수 'xeve' 설정

yeve <- length(y) # 주사위 y가 일으킬 수 있는 모든 경우의 수 'yeve' 설정

eve <- xeve * yeve # 주사위 x, y를 굴리는 실험으로 일어날 수 있는 모든 경우의 수 eve

eve # = 36
  

# e.g.1. 주사위 한 개를 천 번 던진다면 어느 숫자에 수렴하겠는가? R프로그램을 이용하여 증명하시오.
# [1] 주사위는 1에서 6까지의 눈을 갖는 정육면체의 형태를 갖는다.

# (1) 주사위 설정

dice <- c("1", "2", "3", "4", "5", "6")

prob <- c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6)

# (2) 주사위 던지기
## 한 번 던지기

sample(dice, 1, prob = prob)

# (3) 천 번 던지기

hund_draw <- vector(mode = "character", length = 1000)

hund_draw # 주사위를 1000번 던질 벡터 공간 작성

for(i in 1:1000){
  hund_draw[i] <- sample(dice, 1, prob = prob) # 한 번 던져서 결과를 벡터 공간에 저장
}

mean(as.integer(hund_draw))
# 3.495, 3.537, 3.523

# (4) 사실 그냥 이렇게 해도...

dice <- sample(dice, 1000, prob = prob, replace = TRUE)

mean(as.integer(dice))

# e.g.2. 주사위 두 개를 동시에 던졌을 때, 두 주사위의 눈이 같으면 승리, 그렇지 않을 경우 패배가 되는 게임을 작성하고 1000회 시행했을 경우의 승률을 구하시오.
# [1] 두 주사위의 조건은 위의 문제와 동일하다.

# (1) 주사위 설정

dice <- c("1", "2", "3", "4", "5", "6")

prob <- c(1/6, 1/6, 1/6, 1/6, 1/6, 1/6)

# (2) 주사위 던지기

dice_a <- sample(dice, 1, prob = prob)

dice_b <- sample(dice, 1, prob = prob)

ifelse(dice_a == dice_b, "Win", "Lose")
#Lose

# (3) 모의실험 1000회 시행

game_v <- vector(mode = "integer", length = 1000) # 게임 결과를 넣을 벡터 공간 작성

game <- function(r = 1000) {
  for(i in 1:r) {
    dice_a <- sample(dice, 1, prob = prob)
    dice_b <- sample(dice, 1, prob = prob)
    
    game_v[i] <- ifelse(dice_a == dice_b, 1, 0)
  }
  return(game_v)
}

game(1000) # 1000번 시행

# (4) 평균 구하기

library(dplyr)

game(1000) %>% mean
# 0.162


  
### Very Strong Assumption
#
#  - All outcomes equally likely
#  - Finite sample space
  
# 다른 전제 조건이나 실험의 환경, 시행 과정과 같은 요소를 배제하고
# 확률을 단순히 True or False라는 이분법적 관점에서 설명하고자 한다면,
# "태양에는 1/2 확률로 생명체가 존재할 수 있다."는 터무니없는 주장도 가능하게 된다.
# 따라서, 모든 경우가 동일한 확률을 가져야 한다는 가정이 엄격히 지켜져야 확률 실험으로부터 합리적인 결론을 도출할 수 있다.
# 그렇다면, "태양에는 1/2 확률로 지적 생명체가 존재할 수 있다."는 주장은 어떠한가?
# 마찬가지로 True or False라는 1/2 확률로 말할 수 있겠지만 무엇인가 이상하다.
# 지적생명체는 일반 생명체의 존재가능성보다도 확률이 더 낮아야 하지 않을까?
# 그렇기 때문에 유한 표본 공간이라는 전제가 중요하고 그 가정에 대해 확실한 이유를 설명할 수 있어야 하는 것이다.
# 그리고 그것이 수식(=셈법)이다.




#### 4. Counting


### 4-1) Multiplication Rule

# 발생 가능한 경우의 수가 n1, n2, ... , nr가지인 1, 2, ... , r번의 시행에서 발생 가능한 모든 경우의 수는 n1 * n2 * ... * nr 이다.


### 4-2) Binomial Coefficient

# {n-(n-1)(n-2)...(n-k+1)/k!} = n!/(n-k)!k! -> "n에서 k만큼 고른다.", if k > n == 0
# == (n, k)

# 크기 n의 집합에서 만들 수 있는 크기 k인 부분집합의 수
# 순서는 무관하다.


# e.g.3. 실험 'expt'

# 첫 번째 실험, n1개의 가능한 결과
# = n1

# 두 번째 실험, 첫 번째 실험의 각 결과에 대하여 n2개의 가능한 결과 
# = n1 * n2

# r번 시행
# = (n1 * n2) * r

# nr개의 r-1번째 실험에서 나온 결과와는 무관하게 r번째 실험에서는 nr개의 결과가 존재. (!) nr != n * r, nr == r번 시행한 n
# ==> "직전의 시행이 이후 영향을 미치지 않는다." (복원추출)

# e.g.4. 실험 'Pick of Fullhouse in poker, 5 card hand.'
# [1] '세 장의 숫자 일치, 나머지 두 장의 또다른 숫자 일치' == 'Fullhouse'
# [2] 카드는 완전히 섞였다고 가정

# 분모는 52장 중 5장을 고르는 경우의 수
# 분자 Fullhouse
# 즉,            [{13(4, 3)*12(4, 2)}/(52, 5)]
#                = [13{4!/(4-3)!3!}*12{4!/(4-2)!2!}]/{52!/(52-5)!5!}

FULLHOUSE <- (13*choose(4, 3)*12*choose(4, 2))/choose(52, 5)

FULLHOUSE



### Sampling table


# Choose 'k' objects out of 'n'

# 복원 추출과 비복원 추출 & 추출 순서 고려 여부

# 순서를 고려하는 복원 추출 : n^k, 별다른 계산의 어려움이 없음
# 순서를 고려하는 비복원 추출 : n(n-1)...(n-k+1)
# 순서가 중요하지 않은 비복원 추출 : (n, k)
# 순서가 중요하지 않은 복원 추출 : (n+k-1, k) 매우 어려움


# e.g.5. 여덟 장의 하얀 카드와 다섯 장의 검은 카드가 있다. 주머니에서 한 장씩 다섯 장을 뽑는 게임을 작성하라.
# [1] 처음 세 번 연속해서 하얀색 카드, 마지막으로 두 번 연속해서 검은색 카드가 나오는 경우를 승리조건으로 한다.
# [2] 게임을 백만 번 시행했을 때, 위의 승리 조건을 만족하는 승률은 얼마인가?

# (1) 카드와 주머니'deck' 작성

deck <- c(rep("WhiteCard", 8), rep("BlackCard", 5))

deck

# (2) 카드 다섯 장 '비복원' 추출 = n(n-1)...(n-k+1) : (replace = FALSE)

drawcard <- sample(deck, 5, replace = FALSE)

drawcard

# (3) 결과 확인

result <- ifelse(drawcard[1] == "WhiteCard" & drawcard[2] == "WhiteCard" & drawcard[3] == "WhiteCard" & drawcard[4] == "BlackCard" & drawcard[5] == "BlackCard", "Win", "Lose")

cat("Game result : ", result)

# (4) 백만 번 시행
# 함수 작성

draw_function <- function(){
  drawcard <- sample(deck, 5, replace = FALSE)
  
  result <- ifelse(drawcard[1] == "WhiteCard" & drawcard[2] == "WhiteCard" & drawcard[3] == "WhiteCard" & drawcard[4] == "BlackCard" & drawcard[5] == "BlackCard", "Win", "Lose")
  return(result)
}

# 결과 테이블 벡터 공간 작성

result_table <- vector(mode = "character", length = 1000000)

for(i in 1:10000000){ 
  result_table[i] <- draw_function()
} # 실행시 시간이 꽤 걸리니 기다려야 함

result_table %>% tbl_df() %>% # 여기서 '%>%'와 같은 기호와 tbl_df, count, mutate와 같은 함수는 전부 dplyr 패키지의 기능인데, 자세한 사항은 개인적으로 공부하라.
  count(value) %>%
  mutate(pcnt = scales::percent(n/sum(n)))

#  A tibble: 2 x 3
#   value       n  pcnt 
#   <chr>   <int> <chr>
# 1 Lose  9564511 95.6%
# 2 Win    435489 4.4% 

# 그렇다면, 복원 추출로 이를 시행할 경우에는 어떻게 되겠는가?

# (1) 카드와 주머니'deck' 작성

deck <- c(rep("WhiteCard", 8), rep("BlackCard", 5))

deck

# (2) 카드 다섯 장 '복원' 추출 = n^k : (replace = TRUE)

drawcard <- sample(deck, 5, replace = TRUE)

drawcard

# (3) 결과 확인

result <- ifelse(drawcard[1] == "WhiteCard" & drawcard[2] == "WhiteCard" & drawcard[3] == "WhiteCard" & drawcard[4] == "BlackCard" & drawcard[5] == "BlackCard", "Win", "Lose")

cat("Game result : ", result)

# (4) 백만 번 시행
# 함수 작성

draw_function <- function(){
  drawcard <- sample(deck, 5, replace = TRUE)
  
  result <- ifelse(drawcard[1] == "WhiteCard" & drawcard[2] == "WhiteCard" & drawcard[3] == "WhiteCard" & drawcard[4] == "BlackCard" & drawcard[5] == "BlackCard", "Win", "Lose")
  return(result)
}

# 결과 테이블 벡터 공간 작성

result_table <- vector(mode = "character", length = 1000000)

for(i in 1:10000000){ 
  result_table[i] <- draw_function()
} # 실행시 시간이 꽤 걸리니 기다려야 함

result_table %>% tbl_df() %>% # 여기서 '%>%'와 같은 기호와 tbl_df, count, mutate와 같은 함수는 전부 dplyr 패키지의 기능인데, 자세한 사항은 개인적으로 공부하라.
  count(value) %>%
  mutate(pcnt = scales::percent(n/sum(n)))

#  A tibble: 2 x 3
#   value       n  pcnt 
#  <chr>    <int> <chr>
# 1 Lose  9655220 96.6%
# 2 Win    344780 3.4%

# 복원 추출의 경우 승률이 더욱 낮아지는 것을 알 수 있다.
# 그 이유에 대하여 고민해보는 것을 권장한다.



# "Don't lose common sense."
# "Do check answers."
# "Label peaple, objects, etc.If have n people, then label them 1, 2, ... , n"

# e.g.6. 10 people, split into team of 6, team of 4.
#      => (10, 4) == (10, 6) : 10!/4!6! = 10!/6!4! "Must be the same"

# e.g.6-1. 2 team of 5
#      => (10, 5)/2 

# 상황에 맞게 이해하고 그에 맞게 생각해라.
# naive한 정의에는 각 결과가 equally likely를 따른다고 가정한다.
# 그러나 결과가 equally likely를 따르지 않는다면 naive한 정의는 사용할 수 없다.
# 따라서 naive한 확률의 정의를 사용하고자 한다면 확률 문제를 올바르게 구조화해야 할 필요가 있다.


# e.g.7. Pick k times from set of n objects, where order doesn't matter,
#        (n+k-1, k) ways.

# Extreme cases : k = o
#                 (n-1, 0) == 1
#                 k = 1
#                 (n, 1) == n
#                 n = 2
#                 (k+1, k) == (k+1, 1) == k+1
#                 => box1 <- c(1, 2, ... , k or ' '); box2 <- c(1, 2, ... , k or ' ')


# e.g.8. How many ways are there to put k indistinct particles into n distinguishable boxes?
#        box1 <- c(1, 2, 3)
#        box2 <- c()
#        box3 <- c(4, 5)
#        box4 <- c(6)
#        => n == 4, k == 6
#        box1,box2,box3,box4 
#        1,2,3| |4,5|6 
#        k i's, n-1 |'s   "'i'는 입자 1:6가 들어올 자리"
#        => (n+k-1, k)
#        즉, n+k-1개 중에서 k를 고르는 경우의 수가 된다.




#### 5. Story Proofs and Axioms of Probability


## (1) 일반적으로 n개 중 k개를 고르는 것은 n-k개를 고르는 경우와 같다.
#      (n, k) == (n, n-k) : n개 중에서 k개를 고르라.

## (2) n명 중에서 k명 뽑기, k명 중에서 한 명 뽑기 
#      n(n-1, k-1) == k(n, k) 

## (3) m+n개 중에서 k개를 고를 때, 중복으로 세지 않으며 모두 다른 경우로 더한다.
#      (m+n, k) == sum j=0 to k (m, j)(n, k-j) 'Vandermonde'



### non-naive definition

# 표본공간 S, 어떤 실험에서 가능한 모든 경우의 집합
# 사건 A, S의 부분집합
# 함수 P, A를 입력으로 가지며 P(A)는 0과 1 사이의 수

# Rule 1. 공집합의 확률은 0이며 전체의 확률은 1이다. 
#         P() == 0, P(S) == 1
# Rule 2. 사건들이 모두 서로 중복되지 않는 서로소라면, 무한 합사건의 확률은 모든 확률의 합과 같다.
#         P(union(n=1, union(inf)==sum n=1 to inf P(An)))

## Birthday Problem 

# k명 중 2명 이상이 같은 생일을 가질 확률
# 출생 확률에 관한 다른 외부 간섭 요인은 배제(결혼 시즌 등)
# 각각의 사건은 독립적으로 발생한다고 가정
# k가 몇 명 이상이어야 같은 생일을 가진 사람들이 있을 확률이 절반에 이를 수 있겠는가?
# k =< 365 라고 할 때, P(k) == {365*364*363*...*(365-k+1)}/365^k
# => k = 23일 때

k <- 23 # 방 안의 사람들

prob <- numeric(k) # 확률 변수 벡터 생성

for (i in 1:k){
  j <- 1 - (0:(i - 1))/365 # 1 - 불일치 확률
  prob[i] <- 1 - prod(j) # 불일치 확률 prod(j)을 제외한 확률 저장
}

result <- prob[k]
result # 0.5072972 == 50.7%

# => k = 100일 때

k <- 100

prob <- numeric(k)

for(i in 1:k){
  j <- 1 - (0:(i - 1))/365
  prob[i] <- 1 - prod(j)
}

result <- prob[k]
result # 0.9999997 == 99.7%

plot(prob, main = "Birthday Ploblem", xlab = "NOP", ylab = "Probability", col = "black")

choose(23,2) # 253


## 포함배제의 원리(Inclusion-Exclusion Principle) 

# e.g.9. 1부터 13까지 레이블이 되어있는 카드 13장을 순서대로 뽑았을 때, 카드의 번호와 순서를 일치시키는 게임을 작성하라. - deMontmort's Problem(1713)
# [1] 모든 카드의 숫자는 고유하며 중복되지 않는다.
# [2] 백만 번 시행하고 승률 계산하라

# (1) 카드 설정

card <- seq(from = 1, to = 13, by = 1) # seq(1:13)의 경우 num이 아닌 int의 형식으로 입력되어 레이블 조건(character or num)을 충족하지 못한다.
card

# (2) 한 번의 게임 실행

shuffled_deck <- sample(card, 13, replace = FALSE) # 비복원추출
shuffled_deck
result_table <- vector(mode = "integer", length = 13) # 결과 테이블 작성
result_table

for(i in 1:13){ # 게임을 위한 for문 작성, 1부터 13까지라는 조건을 지정하여 가상 변수 i에 지정.
  result_table[i] <- ifelse(shuffled_deck[i] == i, 1, 0) # 만일(ifelse), 내가 뽑은 카드들의 번호(shuffled_deck)가 순서와 일치하면([i] == i) 반영하고(1, 0) 변환 값을 결과 테이블에 입력하라(result_table[i] <- )
  result <- ifelse(sum(result_table) == 0, "WIN", "LOSE") # 최종 결과를 새로운 변수 result에 저장하라
}

cat("Result : ", result)

# (3) 백 만번의 게임 실행

single_game <- function(){ # 한 번 실행한 게임의 함수화
  shuffled_deck <- sample(card, 13, replace = FALSE)
  
  result_table <- vector(mode = "integer", length = 13)
  
  
  for(i in 1:13){ 
    result_table[i] <- ifelse(shuffled_deck[i] == i, 1, 0)
    result <- ifelse(sum(result_table) == 0, "WIN", "LOSE")
  }
  return(result) # 결과값 반환
}

million_table <- vector(mode = "character", length = 1000000)

for(i in 1:1000000){
  million_table[i] <- single_game()
}

table(million_table) %>% tbl_df() %>%
  mutate(prob = scales::percent(n/sum(n)))

# A tibble: 2 x 3
# million_table        n prob 
# <chr>           <int>  <chr>
# 1 LOSE          631560 63.2%
# 2 WIN           368440 36.8%
