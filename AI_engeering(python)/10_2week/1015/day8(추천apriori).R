# 아프리오 알고리즘이 중요한 이유 
# 동작 : 원인 -> 결과 
# 이론적으로 만들어질수 있는 규칙의 개수
# 상품의 종류가 100개이다 -> 규칙은 1 -> 1 // 1 -> 1,2 // 
# 상품의 종류가 100일 때 부분 집합의 개수는 2^10 이다 ==> 매우 큰 수가 나온다. 
# 아프리오리 알고리즘 => 집합의 개수를 최소화한다. 아주 작은 부분 집합에서 부터 확인 , 가지치기로 검색 회수 줄임
# 지지도(support) : 항목 집합이 나타내는 트랜잭션 비율 
# 신뢰도(confidence) : x와 y를 포함하는 아이템 집합의 지지도를 x의 지지도로 나눈값 
# 향상도(lift) : 신뢰도 / 지지도 // 아이템 x를 구매했을 때 아이템 y구매할 확률 
# groceries.csv 상품 목록 , 행의 길이가 다 다르다. 

tgroceries<-read.csv("groceries.csv",header = FALSE)
dim(tgroceries)
str(tgroceries)
# 이렇게 읽으면 안된다.

install.packages('arules')
library(arules)
groceries<- read.transactions("groceries.csv",sep = ',') # 거래 데이터는 따로 로드해야함 
summary(groceries) # a density of 0.02609146 ==> 백만개(9835x169) 셀 중  2.2% 만 0이 아니다. 나머지는 0이다. 
# 9835 건의 거래 중에서 2513 건을 whole milk 구매 
inspect(groceries[1:5])
groceries # 희소행렬 형태로 나타나있음 

itemFrequency(groceries[,1:169])
# itemFrequency 함수로 거래 비율 확인 : 상품의 지지도(support)를 말하는 것 
itemFrequencyPlot(groceries,support=0.1) # 지지도가 0.1 이상인 상품으로 plot
itemFrequencyPlot(groceries,topN = 20) # 가장 높은 상품부터 내림차순으로 plot 

image(groceries[1:169]) # 상품이 많이 팔린 곳의 위치 파악가능 
# help 0> apriori 
# data : rjfoepdlxj qoduf 
#
groceries_rulse <-  apriori(groceries,parameter = list(support = 0.1))
# support 가 0.1 이상이면서 confidence가 0.8 이상인 조건을 만족하는 연관규칙    
groceries_rulse <-  apriori(groceries,parameter = list(support = 0.005,confidence = 0.25,minlen = 2))
groceries_rulse
# support = 0.005 : 전체 9835 건 거래중에서 약 50건 이상의 거래가 있었던 아이템을 대상
# confidence = 0.25 : 신뢰도 
# confidence (빵 -> 우유 ) : support(빵/우유) / support(빵) 빵 구매시 우유도 구매 규칙 신뢰도 
# minlen = 2 : 2개 미만의 아이템을 갖는 규칙을 제외 
# ex) 공집합이 생성될 수 있음 {} -> {whole milk} 이러한 규칙을 제외
#

summary(groceries_rulse)

# rule length distribution (lhs + rhs):sizes
# 규칙 : 아이템(lhs) -> 아이템(rhs)
# lift가 1보다 커야됨

inspect(groceries_rulse[1:5])
#     lhs                rhs                support     confidence coverage   lift     count
# [1] {cake bar}      => {whole milk}       0.005592272 0.4230769  0.01321810 1.655775 55  
# lift가 1.65577이면 그냥 우유만 사는것 보다 cake bar를 사고 우유를 사는 게 더 강력하다


class(inspect(groceries_rulse[1:5])) # [1] "data.frame" 데이터 프레임 그렇다면 정렬이 된다. 

inspect(sort(groceries_rulse,by = 'lift')[1:30]) # lift 기준 내림차순 정렬 
inspect(sort(groceries_rulse,by = 'lift',decreasing = FALSE)[1:30]) # lift 기준 오름차순 정렬 

# 전략적으로 berries 상품과 함께 향상도가 높은 상품 추출 -> 판매
inspect(subset(groceries_rulse,items %in% 'berries'))
berriesRules<-subset(groceries_rulse,items %in% 'berries')
write(berriesRules,file ='berriesRules.csv', sep=',' , row.names = FALSE  )

berryDf <- as(berriesRules,'data.frame')
str(berryDf)

inspect(subset(groceries_rulse,items %in% c('berries','yogurt')))
