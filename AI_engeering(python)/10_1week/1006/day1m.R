# 스크립트 창  실행 : ctrl Enter 
print('hello')
# 콘솔창 ->> 실행결과 확인 / 간단한 코드 실행 결과 확인 

# saadsd
# asdasd
# asdasd
install.packages('readxl')
library('readxl')

eng <-c(50,60,70) # 벡터 
mat <-c(70,80,90)

df<- data.frame(eng,mat) # 데이터 프레임 
df
class <- c(1,1,2)
dfm <-data.frame(eng,mat,class)
dfm

mean(dfm$eng) # 하위에 접근할 때 $로 접근한다. python 에서는 .역할 

read_excel('data/excel_exam.xlsx')

read_excel('data/excel_exam_novar.xlsx',col_names = F)

read_excel('data/excel_exam_sheet.xlsx') # 디폴트 첫번째 시트 데이터 

read_excel('data/excel_exam_sheet.xlsx',sheet = 3)

data <- read.csv("data/csv_exam.csv")

str(data) # structure : 자료구조가 나온다. python 에서 info

write.csv(data,file = 'savefile.csv') # csv 파일로 저장 

exam<- read.csv('data/csv_exam.csv')

head(exam)

View(exam) # view file

tail(exam)

dim(exam) # shape

summary(exam) # 파이썬 describe

install.packages('dplyr')

library(dplyr)

help(dplyr)

exam

reexam <- rename(exam, eng = english)

reexam

reexam$plus_me<- reexam$math+reexam$eng # mat 컬럼과 eng 컬럼을 더한 결과 /새로운 컬럼 생성 

reexam$result <- ifelse(reexam$math >=70 , 'pass','fail') # np.where


reexam

install.packages('ggplot2')
library(ggplot2)
qplot(reexam$result)

reexam$hakjum<-ifelse(reexam$math < 50 , 'c',ifelse(reexam$math <=80,'B',ifelse(reexam$math<=100,'A','Fail')))

reexam

table(reexam$hakjum) # value_counts

exam <- read.csv('data/csv_exam.csv')
exam

exam %>% filter(class == 1) # ctrl + shift + m 
# pipeline

exam %>% filter(class != 1)

exam %>% filter(math >= 70 & english >= 70)

exam %>% filter(class == 1 | class == 3 |  class == 5)

exam %>% filter(class %in% c(1,3,5)) # 위 아래가 같다! 

exam %>% select(math)

exam %>% select(math,class)

exam %>% select(-math)

exam %>% 
  filter(class == 1) %>% 
  select(english)

exam %>% 
  select(id,math) %>% 
  head

# 정렬 
exam %>% 
  arrange(math) # math를 기준으로 오름차순 정렬 

exam %>% 
  arrange(desc(math))

exam %>% 
  arrange(class,math) # 우선순위 class -> math 

# 파생변수 추가 
exam %>% 
  mutate(total = math + english + science) %>% 
  head

exam %>% 
  mutate(res = ifelse(science>=60,'pass','fail')) %>% 
  head

# 집계
exam %>% 
  summarise(mean_math = mean(math))

# groupby -> 집계
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),sum_math = sum(math),median_math = median(math),n=n()) # n() 빈도 
# max, min, sd, var .... 

# ggplot2::mpg 
# 패키지명 :: 데이터셋 

ggplot2::mpg

mpg <- as.data.frame(ggplot2::mpg) # 데이터 프레임 

str(mpg) # info

mpga<-mpg %>% 
  filter(displ <=4)

mpgb<-mpg %>% 
  filter(displ >5)
mean(mpga$hwy)

a<- data.frame(id = c(1,2),test = c(50,90))
b<- data.frame(id = c(3,4),test = c(30,100))
a

bind_rows(a,b) # pd.concat([a,b],axis = 0)

exam
name <- data.frame(class = c(1,2,3,4,5),tea = c('kim','park','lee','cho','jung'))
name

#class 기준 exam과 name을 결합
left_join(exam, name,by ='class')
