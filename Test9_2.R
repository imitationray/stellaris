#################################
## <제9장-2 연습문제>
################################# 
library(rJava)
library(KoNLP)
library(tm)
library(wordcloud) 
library(Sejong)
library(arules) 
# 01. 트럼프 연설문(trump.txt)과 오바마 연설문(obama.txt)을 대상으로 빈도수가 2회 이상 단어를 대상으로 단어구름 시각화하시오.
trumph <- file(file.choose(), encoding = "UTF-8")
trumph_sp <- readLines(trumph)

obama <- file(file.choose(), encoding = "UTF-8")
obama_sp <- readLines(obama)

str(trumph_sp)
str(obama_sp)

trumphCorups <- Corpus(VectorSource(trumph_sp))
obamaCorups <- Corpus(VectorSource(obama_sp))

inspect(trumphCorups)
inspect(obamaCorups)

trumph_speech <- tm_map(trumphCorups, removePunctuation) # 문장부호 제거
trumph_speech <- tm_map(trumph_speech, removeNumbers) # 수치 제거
trumph_speech <- tm_map(trumph_speech, tolower) # 소문자 변경
trumph_speech <- tm_map(trumph_speech, removeWords, stopwords('english'))
obama_speech <- tm_map(obamaCorups, removePunctuation) # 문장부호 제거
obama_speech <- tm_map(obama_speech, removeNumbers) # 수치 제거
obama_speech <- tm_map(obama_speech, tolower) # 소문자 변경
obama_speech <- tm_map(obama_speech, removeWords, c(stopwords('english'), 'applause'))

inspect(trumph_speech)
inspect(obama_speech)

trumph_term <- TermDocumentMatrix(trumph_speech, 
                                          control=list(wordLengths=c(2,16)))
obama_term <- TermDocumentMatrix(obama_speech, 
                                  control=list(wordLengths=c(2,16)))

inspect(trumph_term)
inspect(obama_term)

trumph_df <- as.data.frame(as.matrix(trumph_term)) 
str(trumph_df)
trumph_df[c(1:5),1]

obama_df <- as.data.frame(as.matrix(obama_term)) 
str(obama_df)
obama_df[,1]

trumphResult <- sort(rowSums(trumph_df), decreasing=TRUE)
obamaResult <- sort(rowSums(obama_df), decreasing=TRUE)

t_name <- names(trumphResult)
t_name[1:10] # 단어이름 
trumphResult[1:10] # 출현빈도 

o_name <- names(obamaResult)
o_name[1:10] # 단어이름 
obamaResult[1:10] # 출현빈도 

trumphName <- names(trumphResult)
obamaname <- names(obamaResult)
trumph.df <- data.frame(word=trumphName, freq=trumphResult) 
head(trumph.df)
str(trumph.df) # word, freq 변수

# (3) 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 색상 pal <- brewer.pal(9,"Set1") # Set1~ Set3
# 폰트 설정세팅 : "맑은 고딕", "서울남산체 B"
windowsFonts(malgun=windowsFont("맑은 고딕"))  #windows

# (4) 단어 구름 시각화 - 별도의 창에 색상, 빈도수, 글꼴, 회전 등의 속성을 적용하여 
wordcloud(trumph.df$word, trumph.df$freq, 
          scale=c(5,1), min.freq=2, random.order=F, 
          rot.per=.1, colors=pal, family="malgun")

obama.df <- data.frame(word=obamaname, freq=obamaResult) 
head(obama.df)
str(obama.df) # word, freq 변수

wordcloud(obama.df$word, obama.df$freq, 
          scale=c(5,1), min.freq=2, random.order=F, 
          rot.per=.1, colors=pal, family="malgun")



# 02. 공공데이터 사이트에서 관심분야 데이터 셋을 다운로드 받아서 빈도수가 5회 이상 단어를 이용하여 
#      단어 구름으로 시각화 하시오.
# 공공데이터 사이트 : www.data.go.kr


speech <- file(file.choose(),
               encoding = "UTF-8")
speech_data <- readLines(speech)

head(speech_data)
str(speech_data)

mydict <- data.frame(term = c("불평등", "평등", "대한민국", "한국", "산업", "북한", "경제", "평화", "전쟁", "남북", "통일", "적폐청산", "일본", "독립", "일제"),
                     tag = 'ncn')

buildDictionary(ext_dic = 'sejong',
                user_dic = mydict)

exNouns <- function(x) { 
  paste(extractNoun(as.character(x)),
        collapse = " ")
}

speech_nouns <- sapply(speech_data,
                       exNouns) 
speech_nouns

str(speech_nouns)
speech_nouns[1]
speech_nouns[1:1000]

myCorpus <- Corpus(VectorSource(speech_nouns))
myCorpus

myCorpusspeech <- tm_map(myCorpus, removePunctuation)
inspect(myCorpusspeech)
myCorpusspeech <- tm_map(myCorpusspeech, removeNumbers)
myCorpusspeech <- tm_map(myCorpusspeech, tolower)
myCorpusspeech <- tm_map(myCorpusspeech, removeWords, c(stopwords('english'), '들이', '그것', '유관', '동안'))

inspect(myCorpusspeech)
inspect(myCorpusspeech[1:1000])

speech_term <- TermDocumentMatrix(myCorpusspeech, 
                                          control = list(wordLengths = c(4, 16)))
speech_term
# <<TermDocumentMatrix (terms: 2004, documents: 1899)>>
# Non-/sparse entries: 5704/3799892
# Sparsity           : 100%
# Maximal term length: 10
# Weighting          : term frequency (tf)

speech_df <- as.data.frame(as.matrix(speech_term))
str(speech_df)

# speech_df <- str_replace_all(speech_df, "임시", "임시정부")

Result <- sort(rowSums(speech_df), decreasing=TRUE) 
Result

sp_name <- names(Result)
sp_name[1:10]
Result[1:10]

speech.df <- data.frame(word = sp_name, freq = Result) 
head(speech.df)
str(speech.df)

pal <- brewer.pal(12, "Paired") 
windowsFonts(malgun = windowsFont("맑은 고딕"))

wordcloud(speech.df$word,
          speech.df$freq, 
          scale = c(3, 1),
          min.freq = 8,
          random.order = F,
          rot.per = .1,
          colors = pal,
          family = "malgun")
