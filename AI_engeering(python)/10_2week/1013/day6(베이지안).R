# day 5에서는 베이지안 필터기 이론설명을 했다. 
sms_raw <- read.csv("sms_spam_ansi.txt",stringsAsFactors = F) # stringAsFactor = F ( default)
str(sms_raw)
# 컬럼1 : 햄/스팸 컬럼2 : 메시지 내용 / 행 : 5559
# 타입 컬럼만 타입 형식으로 바꾸고 싶다. 
sms_raw$type <- factor(sms_raw$type)
str(sms_raw)

table(sms_raw$type) # 타입열 종류별 데이터 건수 

# 우도표 형태===> 열은 단어의 종류와 예 or 아니오,  행은 햄 or 스팸
# 우도표 만드는 라이브러리 tm 패키지 -> 코퍼스( corpus ) 구축 
# 코퍼스 : 특정 도메인에서 통용되는 단어 집합 

install.packages('tm')
# 텍스트 마이닝 툴 
library(tm)
stopwords('en') # 불용어 

removeWords('of the people',stopwords('en'))

IMDB <- read.csv('IMDB-Movie-Data.csv')
str(IMDB) # num(numeric) : 실수 / int(integer) : 정수 
summary(IMDB)

sum(is.na(IMDB$Metascore)) # null 개수 
colSums(is.na(IMDB)) # 데이터의 모든 결측치를 알고 싶을 때 

# 결측치 제거
IMDB2 <- na.omit(IMDB) # 모든 변수에 대해 결측치가 하나라도 있으면 해당 행 제거 
colSums(is.na(IMDB2))

# 특정 변수(12번 열)에 결측값이 있는 경우 해당 행만 삭제 
IMDB3 <- IMDB[complete.cases(IMDB[,12]),]
colSums(is.na(IMDB3)) # 결측치 제거됬는지 확인 

IMDB$Metascore2<-IMDB$Metascore
IMDB$Metascore2[is.na(IMDB$Metascore2)] <-50
mean(IMDB$Revenue..Millions.,na.rm = T)

# 극단치 제거 (IMDB$Revenue..Millions.,Q3+1.5*IQR , Q1-1.5*IQR)

Q1 <- quantile(IMDB$Revenue..Millions.,probs = c(0.25),na.rm = T)
Q3 <- quantile(IMDB$Revenue..Millions.,probs = c(0.75),na.rm = T)

LC = Q1 -1.5*(Q3-Q1)
UC = Q3 + 1.5*(Q3-Q1)

IMDB2<- subset(IMDB, IMDB$Revenue..Millions.>LC & IMDB$Revenue..Millions. < UC )

# 텍스트 마이닝 많이쓰이는 것들
IMDB$Actors[1] # "Chris Pratt, Vin Diesel, Bradley Cooper, Zoe Saldana"
substr(IMDB$Actors[1],1,5)
# 문자열 붙이기 
paste(IMDB$Actors[1],'_','A')
paste(IMDB$Actors[1],'_','A',sep="") # 뒤에 공백 제거 

# 분리 
strsplit(IMDB$Actors[1],split=',')

# 문자열 대체 
# ex) '우리나라 한국 대한민국 남한 코리아' => 대한민국 
IMDB$Genre2 <- gsub(',',' ',IMDB$Genre) # 콤마를 전부 공백 문자로 바꾼다. 

# 텍스트 마이닝 절차 
# 1) 코퍼스 생성 ->2) 단어(T) 문서(D) 행렬 (M):TDM ( 문서(D) 단어(T) 행렬(M) : DTM) -> 3) 문자 전처리(불용어,조사 제거)
#      문서1 문서2 문서3 
#hello
#hi
#sky
#...
#TDM -> transpose -> DTM

CORPUS= Corpus(VectorSource(IMDB$Genre2)) # 1)코퍼스 생성 
CORPUS_TM = tm_map(CORPUS,removePunctuation)# 3)특수문자 제거
CORPUS_TM = tm_map(CORPUS_TM,removeNumbers)#숫자 제거
CORPUS_TM = tm_map(CORPUS_TM,tolower)# 소문자 통일

# 문서행렬 생성 
DTM<- DocumentTermMatrix(CORPUS_TM)
DTM
# DTM (1000 *20 -> 20000개 행렬 요소)
# documents : 1000, terms :20 
# Non-/sparse entries: 2555(0이 아님)/17445(0)
# Sparsity           : 87% ( 0의 비중)
# Dense <-> sparse (희소행렬)


inspect(DTM)

IMDB$Genre2[1]
inspect(DTM)

DTM <- as.data.frame(as.matrix(DTM)) # 문서(영화) : 1000, 단어( 장르 종류 ): 20 코퍼스 생성
head(DTM)

IMDB_GENRE <- cbind(IMDB,DTM)
IMDB$Description # 단어 중복, 조사, 동사, 명사 ....
# 불용어 제거 
CORPUS <- Corpus(VectorSource(IMDB$Description)) # IMDB$Description에등장하는 단어 집합으로 코퍼스를 구성
CORPUS_TM <- tm_map(CORPUS,stripWhitespace) # 공백( 엔터, 탭 문자 ) 제거 
CORPUS_TM <- tm_map(CORPUS_TM,removeNumbers) # 숫자 제거
CORPUS_TM <- tm_map(CORPUS_TM,tolower) # 모두 소문자  
CORPUS_TM <- tm_map(CORPUS_TM,removePunctuation) # 구두점 제거 

DTM <- DocumentTermMatrix(CORPUS_TM)
inspect(DTM)

IMDB$Description[155]

CORPUS_TM<-tm_map(CORPUS_TM,removeWords,c(stopwords('english'),'my','custom','words')) # 불용어 제거 + 추가적 단어 제거 

TDM<-TermDocumentMatrix(CORPUS_TM)
m <- as.matrix(TDM)
rowSums(m)


#IMDB$Description
#       영화1 ... 영화 1000
#control   0         0       ==> 행합계 (rowSums : 9)
#criminals

sort(rowSums(m)) # 오름차순
v<-sort(rowSums(m),decreasing = T) # 내림차순 
names(v) # 이름만 나옴 
d<- data.frame(word = names(v),freq = v)
install.packages('SnowballC') # 어근 추출할 때 많이 쓰는 툴 run, runnung, runs  <=> run
library(SnowballC)
install.packages('wordcloud')
library(wordcloud)
install.packages('RColorBrewer')
library(RColorBrewer)

wordcloud(words = d$word,freq = d$freq,min.freq = 5, max.words = 200,random.order = F,colors = brewer.pal(8,'Dark2'))




sms_corpus <- VCorpus(VectorSource(sms_raw$text)) # 문자에 따라 CORPUS가 문제가 될수 있다.그래서 개선한 VCORPUS
sms_corpus
inspect(sms_corpus)
#[[1000]] 
#<<PlainTextDocument>>
#  Metadata:  7
#Content:  chars: 40 : 40글자

sms_corpus[[1000]]
as.character(sms_corpus[[1000]])
lapply(sms_corpus[1:3],as.character) # sms_corpus[1:3] text 내용확인 

sms_corpus_clean <- tm_map(sms_corpus,removeNumbers)
sms_corpus_clean <- tm_map(sms_corpus_clean,content_transformer(tolower)) # tolower
sms_corpus_clean <- tm_map(sms_corpus_clean,removePunctuation)
sms_corpus_clean <- tm_map(sms_corpus_clean,removeWords,stopwords())

# removePunctuation
removePunctuation("hello....;;; hi haha")

myreplace <- function(x){
  gsub('[[:punct:]]+',' ',x)
  
}

myreplace('hello .... world!')

wordStem(c('learn','learned','learning','learns')) #같은 의미 단어를 일원화

sms_corpus_clean <- tm_map(sms_corpus_clean,stemDocument) # wordStem == stemDocument // sms_corpus_clean에 있는 단어들에 대해 어근 추출 

sms_corpus_clean <- tm_map(sms_corpus_clean,stripWhitespace) # 문자열에 공백문자가 2개 이상일 경우 공백 1개로 바꾼다. 

lapply(sms_corpus[1:3],as.character)
# $`1`
# [1] "Hope you are having a good week. Just checking in"
# $`2`
# [1] "K..give back my thanks."
# $`3`
# [1] "Am also doing in cbe only. But have to pay."

lapply(sms_corpus_clean[1:3], as.character)
# $`1`
# [1] "hope good week just check"
# $`2`
# [1] "kgive back thanks"
# $`3`
# [1] "also cbe  pay"

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
sms_dtm
# <<DocumentTermMatrix (documents: 5559, terms: 6906)>> 6906개 단어 
#   Non-/sparse entries: 43256/38347198 요소의 개수(not zero/zero) 43256+38347198 = 5559*6906
# Sparsity           : 100%
# Maximal term length: 40
# Weighting          : term frequency (tf)

################### 데이터 전처리 끝 ####################33
# 1, 트레이닝 / 테스트 분할 
# 2. 워드클라우드 ( 시각화 , 스팸/햄 )

sms_train_labels<- sms_raw[1:4169,]$type # 트레이닝 데이터 정답
sms_test_labels<- sms_raw[4170:5559,]$type # 테스트 데이터 정답 

sms_dtm_train <- sms_dtm[1:4169,]
sms_dtm_test <- sms_dtm[4170:5559,]

table(sms_train_labels)
table(sms_test_labels) # 1207  183 


# 트레이닝 데이너 -> 베이지안 필터기 -> 테스트 데이터 -> 분류결과(예측)와 실제 결과(정답) 비교 -> 모델 평가 

wordcloud(sms_corpus_clean,min.freq = 50,random.order = FALSE)
spam <- subset(sms_raw,type == 'spam') # 타입이 spam인 것들만 출력 
ham <- subset(sms_raw,type == 'ham')

wordcloud(spam$text,max.words = 50,random.order = FALSE)
wordcloud(ham$text,max.words = 50,random.order = FALSE)

#sms_dtm_train  ->sms_train_labels
#sms_dtm_test  -> sms_test_labels

install.packages('e1071') # 베이지안 필터기 라이브러리리
library(e1071)

sms_dtm_train 

#### Sparsity를 줄이기 워한 방법 2가지 

# Sparsity           : 100% 낭비가 심하다
sms_dtm_freq_train<- removeSparseTerms(sms_dtm_train,0.999)
sms_dtm_freq_train #terms: 1115 //Sparsity           : 99%  : 0이 너무 많은값은 제외시킨다. 

sms_freq_words <-findFreqTerms(sms_dtm_freq_train,5) # 문서에서 5번 이상 언급된 단어들의 목록 
str(sms_freq_words)# 1151개의 단어 벡터 
sms_freq_words
sms_dtm_freq_train<-sms_dtm_train[,sms_freq_words]
sms_dtm_freq_test<-sms_dtm_test[,sms_freq_words]
sms_dtm_freq_train
# 나이브 베이즈 분류기는 범주형 데이터에 대해 훈련 
# 현재 희소행렬로 표현(숫자) -> 범주형 변환 
# 셀의 값이 1이상 -> yes , 아니면 no

inspect(sms_dtm_freq_train) # 데이터가 전부 숫자이다. => 언급되면 yes 아니면 no 

convertCounts <-function(x){
  x<-ifelse(x>0,'yes','no')
}

sms_train <- apply(sms_dtm_freq_train,MARGIN = 2,convertCounts) # MARGIN = 1 : 행 , MARGIN = 2 : 열 단위로 적용 
sms_train
sms_test <- apply(sms_dtm_freq_test,MARGIN = 2,convertCounts)
sms_test[,1]

sms_train[1,] # 첫번째 이멜 단어 유무 출력
sms_train_labels
# 나이브 베이즈 

smsClassifier <- naiveBayes(sms_train,sms_train_labels,raplace = 1)
# 모델 완성~ 
# 단어 1151개 , 이메일 5569 편 
# 1151개 단어로 우두표 생성 !! 

sms_test_pred <- predict(smsClassifier,sms_test)
sms_test_pred
install.packages('gmodels')
library(gmodels)
CrossTable(sms_test_pred,sms_test_labels,dnn = c('predicted','actual'))

# 내일 연습문제 
# 새로운 이메일 제목 -> free cash -> 햄, 스팸


