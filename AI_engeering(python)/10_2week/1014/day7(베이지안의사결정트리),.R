raw_data<-read.csv("�ܽ����׽�Ʈ.txt",header = FALSE,col.names = c('type','text'))
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

data_train <- apply(dtm_data,MARGIN = 2,convertCounts) # MARGIN = 1 : �� , MARGIN = 2 : �� ������ ���� 

test_pred <- predict(smsClassifier,data_train) # day 6���� ���� ���� �з��� ��� (�� 4õ���� �����ͷ� �� ���� )
library(gmodels)
CrossTable(test_pred,data_type,dnn = c('predicted','actual'))



#===================================



credit <- read.csv('credit.csv')
str(credit)

table(credit$checking_balance) #  ���� �ܰ� 
table(credit$savings_balance) # ���� ���� �ܰ� 

summary(credit$months_loan_duration) # ����� �Ⱓ  4���� ~ 72 ���� 
summary(credit$amount) # ����� 250 ~ 18424 �߾Ӱ� 2320 ��հ� 3271 

table(credit$default) # 30% ä�� ������ 

# �Ʒ� 90% �׽�Ʈ 10%
set.seed(123)
trainsample <- sample(1000,900) # ���� ���ø��� �� �� ����ϴ� �Լ� 
str(trainsample)

credit_trains<-credit[trainsample,] # 900
credit_tests<-credit[trainsample,] # 900

table(credit_trains$default)
table(credit_tests$default)



# �ǻ���� Ʈ�� 
install.packages('C50')
library(C50)

str(credit_trains)
credit_trains$default<- factor(credit_trains$default) # �з��� factor
str(credit_trains$default)

model <-C5.0(credit_trains[-17],credit_trains$default,trials = 50)
model

creditpred <- predict(model, credit_tests[-17])
CrossTable(credit_tests$default,creditpred,dnn = c('act default','pred default'))
