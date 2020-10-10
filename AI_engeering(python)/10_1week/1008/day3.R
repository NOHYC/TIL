install.packages("foreign")
library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)
raw_welfare<-read.spss(file="data/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
#복사본

raw_welfare

welfare<-raw_welfare
head(welfare)
tail(welfare)

dim(welfare)
str(welfare)
summary(welfare)

welfare <-rename(welfare,
                 sex = h10_g3,
                 birth = h10_g4,
                 marriage =h10_g10,
                 religion = h10_g11,
                 income = p1002_8aq1,
                 code_job = h10_eco9,
                 code_region = h10_reg7)
#성별에 따른 월급 차이?

table(welfare$sex)

table(is.na(welfare$sex)) #결측치 없음

#ifelse사용 sex=1 => male, sex=2 => female 값 변경
welfare$sex<-ifelse(welfare$sex==1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

summary(welfare$income)
#na 대체값, na 제외

qplot(welfare$income)

qplot(welfare$income)+xlim(0,1000)


welfare$income<-ifelse(welfare$income %in% c(0, 5000), NA, welfare$income)
table(is.na(welfare$income))

#na가 아닌 데이터에 대해 성별에 따른 급여 평균 조사
#퀴즈2
welfare %>% group_by(sex) %>% filter(!is.na(income)) %>% summarise(mean = mean(income))

welfare %>% 
  group_by(sex) %>% 
  summarise(meani = mean(income, na.rm = T))


sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>%
  summarise(mean_income=mean(income))
sex_income  

ggplot(data=sex_income, aes(x=sex, y=mean_income))+geom_col()

#성별에 따른 급여 차이가 있음


#몇살때 가장 많은 급여를 받을까?
#나이에 따른 평균 월급

welfare$birth
summary(welfare$birth)
qplot(welfare$birth)

table(is.na(welfare$birth))

welfare$birth<-ifelse(welfare$birth==999, NA, welfare$birth)
table(is.na(welfare$birth))

#퀴즈3.
#age 열 추가
#age는 2015-birth+1 값으로 함
#summary, qplot출력

welfare$age<-2015-welfare$birth+1
summary(welfare$age)
qplot(welfare$age)

#나이에 따른 급여 평균
age_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income=mean(income))


ggplot(data=age_income, aes(x=age, y=mean_income))+geom_col()

ggplot(data=age_income, aes(x=age, y=mean_income))+geom_line()

#연령대(young(<30) / middle(<60) / old(>=60))

welfare<-welfare %>% 
  mutate(ageg=ifelse(age<30,"young",
                     ifelse(age<=59,"middle","old")))
welfare

table(welfare$ageg)
qplot(welfare$ageg)

#연령대별 월급 평균 출력
ageg_income<-welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg) %>% 
  summarise(mean_income=mean(income))
ggplot(data=ageg_income, aes(x=ageg, y=mean_income))+geom_col()

#막대 정렬
ggplot(data=ageg_income, aes(x=ageg, y=mean_income))+geom_col()+
  scale_x_discrete(limits=c("young", "middle", "old"))

#성별에 따른 월급 차이가 연령대별로 다를까 비슷할까?

sex_income<-welfare %>% 
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>% 
  summarise(mean_income=mean(income))

ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill=sex))+geom_col()+
  scale_x_discrete(limits=c("young", "middle", "old"))

ggplot(data=sex_income, aes(x=ageg, y=mean_income, fill=sex))+geom_col(position = "dodge")+
  scale_x_discrete(limits=c("young", "middle", "old"))



sex_age<-welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age, sex) %>% 
  summarise(mean_income=mean(income))
sex_age

ggplot(data=sex_age, aes(x=age, y=mean_income, col=sex))+geom_line()

#직업군 <-> 급여 비교

welfare$code_job
table(welfare$code_job)

welfare$code_job


library(readxl)
list_job <-read_excel("data/Koweps_Codebook.xlsx", col_names = T, sheet=2)
list_job
dim(list_job) #직종코드 : 149개


welfare$code_job
welfare<-left_join(welfare, list_job, id="code_job")
#welfare에 list_job을 연결해라(code_job 공통 컬럼 값으로 )

str(welfare)


welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

#퀴즈3.
#직업별 월급 평균 출력

job_income<-welfare %>%  
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>%  #142개 그룹
  summarise(mi=mean(income))

job_income

top20<-job_income %>% 
  arrange(desc(mi)) %>% 
  head(20)

top20

ggplot(data=top20, aes(x=job, y=mi)) + geom_col() +
  coord_flip()


bottom10<-job_income %>% 
  arrange(mi) %>% 
  head(10)

bottom10
ggplot(data=bottom10, aes(x=job, y=mi)) + geom_col() +
  coord_flip()+ylim(0,500)


#퀴즈4
#남성 직업 빈도 상위 10개 출력
job_male<-welfare %>% 
  filter(sex == "male" & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(cnt = n()) %>% 
  arrange(desc(cnt)) %>% 
  head(10)

job_male

job_female<-welfare %>% 
  filter(sex == "female" & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(cnt = n()) %>% 
  arrange(desc(cnt)) %>% 
  head(10)

job_female

#종교가 있는 사람이 이혼을 더/덜할까???
#종교 유/무에 따른 이혼율 조사

table(welfare$religion)

welfare$religion<-ifelse(welfare$religion==1, "yes", "no")
table(welfare$religion)
qplot(welfare$religion)

table(welfare$marriage)

#이혼 여부 변수 생성
welfare$group_marriage<-ifelse(welfare$marriage==1, "marriage", 
                               ifelse(welfare$marriage==3, "divorce", NA))
table(welfare$group_marriage)

table(is.na(welfare$group_marriage))

qplot(welfare$group_marriage)


religion_marriage<-welfare %>% 
  filter(!is.na(group_marriage)) %>% 
  group_by(religion, group_marriage) %>% 
  summarise(cnt=n()) %>% 
  mutate(tot_group=sum(cnt)) %>% 
  mutate(pct=round(cnt/tot_group*100,1))


divorce<-religion_marriage %>% 
  filter(group_marriage =="divorce") %>% 
  select(religion, pct)

divorce


list_region <- data.frame(code_region = c(1:7), region = c('서울','수도권(인천/경기)','부산/경남/울산','대구경북','대전/충남','강원/충북','광주/전남/전북/제주도'))
list_region

table(welfare$code_region)

welfare<-left_join(welfare,list_region,id ='code_region')




y<- rnorm(100)
hist(y)

x <- matrix(rnorm(100),nrow = 5) # 난수 100개 생성 ->5행 20열 
dist(x) # 유클리디안 
# 20차원에 해당되는 데이터에서 1행, 2행 사이 거리  8.121331
#       1        2        3        4
#2 8.121331                           
#3 7.318367 7.545647                  
#4 7.728368 7.063549 7.316630         
#5 6.595705 6.089620 7.428137 3.924267

dist(x,method ='manhattan') # 격자 거리 구하는 방식 

data(iris)

iris[,-5]

# 클러스터링 k개수 ? 1. elbow 2. k = (n/2)^(1/2) => 빅데이터x 
kmeans.iris <- kmeans(iris[,-5],3)
round(sum(kmeans.iris$withinss,2))
kmeans.iris$centers

kmeans.iris$cluster

table(iris[,5],kmeans.iris$cluster)

kmeans.iris <- kmeans(iris[,-5],3,nstart = 50)
table(iris[,5],kmeans.iris$cluster)
round(sum(kmeans.iris$withinss,2))
kmeans.iris

kmeans.iris <- kmeans(iris[,-5],3,nstart = 10)
round(sum(kmeans.iris$withinss,2))
table(iris[,5],kmeans.iris$cluster)
kmeans.iris

set.seed(123)
kmeans.iris <- kmeans(iris[,-5],3)
round(sum(kmeans.iris$withinss,2))
table(iris[,5],kmeans.iris$cluster)
kmeans.iris

ggplot(data = iris,aes=(x = Petal.Length,y =Petal.Width,colors = species)) + geom_point(shape = 19,size = 4)
