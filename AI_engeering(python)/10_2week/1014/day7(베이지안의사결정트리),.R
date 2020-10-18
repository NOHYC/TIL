raw_data<-read.csv("햄스팸테스트.txt",header = FALSE,col.names = c('type','text'))
raw_data
str(raw_data)
raw_data$type <- factor(raw_data$type)
library(tm)
sum(is.na(raw_data$text))

corpus_data <- VCorpus(VectorSource(raw_data$text))
inspect(corpus_data)
lapply(corpus_data, as.character)

corpus_tm <- tm_map(corpus_data,content_transformer(tolower))
corpus_tm <- tm_map(corpus_tm,removeWords,stopwords())
corpus_tm <- tm_map(corpus_tm,removePunctuation)
corpus_tm <- tm_map(corpus_tm,removeNumbers)

lapply(corpus_tm,as.character)

dtm_data <- DocumentTermMatrix(corpus_tm)
dtm_data

data_type <- raw_data$type


library(e1071)

convertCounts <-function(x){
  x<-ifelse(x>0,'yes','no')
}

data_train <- apply(dtm_data,MARGIN = 2,convertCounts) # MARGIN = 1 : 행 , MARGIN = 2 : 열 단위로 적용 

test_pred <- predict(smsClassifier,data_train) # day 6에서 만든 스팸 분류모델 사용 (약 4천여개 데이터로 모델 생성 )
library(gmodels)
CrossTable(test_pred,data_type,dnn = c('predicted','actual'))



#===================================



credit <- read.csv('credit.csv')
str(credit)

table(credit$checking_balance) #  계좌 잔고 
table(credit$savings_balance) # 저축 계좌 잔고 

summary(credit$months_loan_duration) # 대출금 기간  4개월 ~ 72 개월 
summary(credit$amount) # 대출금 250 ~ 18424 중앙값 2320 평균값 3271 

table(credit$default) # 30% 채무 붛이행 

# 훈련 90% 테스트 10%
set.seed(123)
trainsample <- sample(1000,900) # 랜덤 샘플링을 할 때 사용하는 함수 
str(trainsample)

credit_trains<-credit[trainsample,] # 900
credit_tests<-credit[trainsample,] # 900

table(credit_trains$default)
table(credit_tests$default)



# 의사결정 트리 
install.packages('C50')
library(C50)

str(credit_trains)
credit_trains$default<- factor(credit_trains$default) # 분류는 factor
str(credit_trains$default)

model <-C5.0(credit_trains[-17],credit_trains$default,trials = 50)
model

creditpred <- predict(model, credit_tests[-17])
CrossTable(credit_tests$default,creditpred,dnn = c('act default','pred default'))
