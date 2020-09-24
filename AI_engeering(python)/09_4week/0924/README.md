# 0924 

## DecisionTree, RandomForest

 ### 0923 수업에서 가공한 데이터를 기반으로 DecisionTree 구현

### KFold, cross_val_score,RandomForestRegressor

Train data 에서 학습에 필요한 데이터 추출

교사학습, 지도학습

입력 데이터 (x train) ------ 모델 ------- 출력 데이터 ( y Train)



```
xTrain=train.drop('Survived', axis=1)
yTrain=train['Survived']
xTest=test.drop('PassengerId', axis=1).copy()
xTrain.shape, yTrain.shape, xTest.shape
```

```
((891, 7), (891,), (418, 7))
```

7개 행( 교육 데이터(891) ) ,1개행( 교육데이터(891 ))

7개 행 (테스트 데이터(418))

===> 결과로 1개행 테스트데이터(418)



###  from sklearn.tree import DecisionTreeClassifier

의사결정트리

Train 데이터로 모델 생성

 ```
model=DecisionTreeClassifier()
model.fit(xTrain, yTrain)
 ```

Train 데이터 평가

```
round(model.score(xTrain, yTrain)*100,2)
```

```
86.76
```

==> Train 데이터에서 86.76 정확도를 보여줌



모델을 test 데이터에 적용 predict

```
y_pred_dt=model.predict(xTest)
y_pred_dt

mysubmit=pd.DataFrame({
    'PassengerId':test['PassengerId'],
    'Survived':y_pred_dt    
})
```



==> 케라스 타이타닉 데이터 제출

![image-20200924192724010](README.assets/image-20200924192724010.png)



==> 정확도59.8 % 

### from sklearn.ensemble import RandomForestClassifier



랜덤 포레스트로 모델 생성



```
randomforest = RandomForestClassifier(n_estimators = 500, max_depth = 5, min_samples_leaf = 3)
```

```
randomforest.fit(xTrain,yTrain) 
```

```
yPred = randomforest.predict(xTest)
randomforest.score(xTrain,yTrain)
```

==> 결과 : 0.8338945005611672 

```
mysubmit_r=pd.DataFrame({
    'PassengerId':test['PassengerId'],
    'Survived':yPred    
})
```



==> 케라스 타이타닉 데이터 제출

![img](README.assets/image.png)

===> 정확도 78.9 % 



### from sklearn.model_selection import GridSearchCV

> 랜덤 포레스트의 인자를 넣는데 어떤 값이 가장 정확한 결과를 도출해내는지 검사하는 라이브러리

```
params = {'n_estimators': [31,51,71],'max_depth':[3,5,7],'min_samples_split':[4,6,8,10]}
```

==> 리스트 안에 정확도가 높을 것 같은 파라미터 숫자를 넣어준다. 

 

```
rfModel = RandomForestClassifier(random_state=924, n_jobs=-1 )
```

```
gridcv = GridSearchCV(rfModel,param_grid = params,cv = 5,n_jobs = -1)
```

```
gridcv.fit(xTrain,yTrain)
```

===> GridSearchCV에서 찾은 최적 파라미터를 이용해 모델을 만든다.



어떤 값이 나왔는지 궁금하면

```
print(gridcv.best_params_)
```

```
{'max_depth': 5, 'min_samples_split': 10, 'n_estimators': 71}
```



모델의 정확도를 알고 싶으면

```
print(gridcv.best_score_)
```

```
0.8148264390182662
```

==> 81.3% 정확도가 추출 



## Bike 데이터에서 windspeed 값 보정 ( 랜덤포레스트 사용)

>Bike 데이터에서 windspeed 열의 데이터는 바람의 세기를 나타낸다. 값을 확인해봤을 때 0이 
>
>1313개나 나오는 것을 확인 => 이상한 값은 다시 만든다.

```
0.0000     1313
8.9981     1120
11.0014    1057
12.9980    1042
7.0015     1034
15.0013     961
6.0032      872
16.9979     824
19.0012     676
19.9995     492
22.0028     372
23.9994     274
26.0027     235
27.9993     187
30.0026     111
31.0009      89
32.9975      80
35.0008      58
39.0007      27
36.9974      22
43.0006      12
40.9973      11
43.9989       8
46.0022       3
56.9969       2
47.9988       2
50.0021       1
51.9987       1
Name: windspeed, dtype: int64
```



먼저 풍속이 0과 그 이외의 값으로 나눈다.

```
trainWind0=train.loc[train.windspeed==0]
trainWindNot0=train.loc[train.windspeed!=0]
```



데이터를 받으면 windspeed column을 변환하여 반환하는 함수 생성

 입력데이터() -> 랜덤포레스트 모델 -> 출력데이터(windspeed)

```
def predictWindSpeed(data):
    #data의 windspeed열 값 0을 랜덤포레스트 기반 예측값으로 대체
    dataWind0=data.loc[data['windspeed']==0]
    dataWindNot0=data.loc[data['windspeed']!=0]
    
    #입력데이터() -> 랜덤포레스트 모델 -> 출력데이터(windspeed)
    #풍속을 예측하는데 사용될 변수(입력)를 선택
    wCol=['season','weather', 'temp', 'atemp','humidity','year','month']
    
    #회귀모델
    #풍속예측함수 = w1*season+w2*weather+...+w7*month+b    
    
    #출력 데이터 타입이 str이어야 함.
    dataWindNot0['windspeed']=dataWindNot0['windspeed'].astype('str')
    
    #랜덤포레스트 분류기
    rfModelWind=RandomForestClassifier()
    
    #wind not 0 데이터로 학습(fit)을 시켜서 모델을 만든 후, wind 0 데이터를 모델에
    #입력하면 예상되는 풍속이 출력된다   
    #모델링(학습데이터)
    rfModelWind.fit(dataWindNot0[wCol], dataWindNot0['windspeed'])
    
    #모델(rfModelWind)을 이용하여 풍속이 0인 데이터에 대한 풍속을 예측(predict)하자.
    wind0Values=rfModelWind.predict(dataWind0[wCol])
    
    predictWind0=dataWind0
    predictWindNot0=dataWindNot0
    
    #풍속 0을 예측된 값으로 변경
    predictWind0['windspeed']=wind0Values
    
    #풍속이 0이 아닌 데이터프레임에 예측된 값이 저장된 데이터프레임을 합침
    data=predictWindNot0.append(predictWind0)
    
    data['windspeed']=data['windspeed'].astype('float')
    
    data.reset_index(inplace=True)
    data.drop('index', inplace=True, axis=1)
    return data
    
```



##### Tip 랜덤 포레스트 출력 데이터는 str이어야 한다.

출력 데이터 타입 변경 -> 모델 생성 -> 입력데이터 대입 -> 결과 데이터 -> 형식 변환(astype('float'))

```
dataWindNot0['windspeed']=dataWindNot0['windspeed'].astype('str')
rfModelWind=RandomForestClassifier()
 rfModelWind.fit(dataWindNot0[wCol], dataWindNot0['windspeed'])
 wind0Values=rfModelWind.predict(dataWind0[wCol])
 predictWind0['windspeed']=wind0Values 
```



windspeed 결과 데이터

```
train.windspeed.isnull().sum()
```

==> 0 

```
count    10886.000000
mean        14.010535
std          7.041554
min          6.003200
25%          8.998100
50%         12.998000
75%         19.001200
max         56.996900
Name: windspeed, dtype: float64
```



### 모델 만들기 위해서 연속형 데이터를 모두 category화

```
category_fn=['season','holiday','workingday','weather',
            'year', 'month', 'hour', 'dayofweek']
            
for v in category_fn:
    train[v]=train[v].astype('category')
    test[v]=test[v].astype('category')
```

==>

```
<class 'pandas.core.frame.DataFrame'>
RangeIndex: 10886 entries, 0 to 10885
Data columns (total 19 columns):
 #   Column      Non-Null Count  Dtype         
---  ------      --------------  -----         
 0   datetime    10886 non-null  datetime64[ns]
 1   season      10886 non-null  category      
 2   holiday     10886 non-null  category      
 3   workingday  10886 non-null  category      
 4   weather     10886 non-null  category      
 5   temp        10886 non-null  float64       
 6   atemp       10886 non-null  float64       
 7   humidity    10886 non-null  int64         
 8   windspeed   10886 non-null  float64       
 9   casual      10886 non-null  int64         
 10  registered  10886 non-null  int64         
 11  count       10886 non-null  int64         
 12  year        10886 non-null  category      
 13  month       10886 non-null  category      
 14  day         10886 non-null  int64         
 15  hour        10886 non-null  category      
 16  minute      10886 non-null  int64         
 17  second      10886 non-null  int64         
 18  dayofweek   10886 non-null  category      
dtypes: category(8), datetime64[ns](1), float64(3), int64(7)
memory usage: 1022.9 KB
```



### 교차 검증 KFold, cross_val_score, RandomForestRegressor

>데이터 100건 -> 70건(트레이닝)=>모델, 30건(테스트)
>
>교차검증? 모델의 일반화 성능을 측정하기 위해, 
>
>데이터를 여러 겹(fold)으로 나누고, 트레이닝/테스트 용으로 나뉘어진 폴드를 
>
>다양하게 적용하여 모델을 학습하고, 평가



####   케라스 점수 산정식

```
from sklearn.metrics import make_scorer
```

```
def rmsle(pv, av): #예측값, 실제값
    #넘파이 배열로 변환
    pv=np.array(pv)
    av=np.array(av)
    
    #예측값과 실제값에 1을 더하고 로그를 씌운다
    log_predict=np.log(pv+1)
    log_actual=np.log(av+1)
    
    res=log_predict-log_actual
    res=np.square(res)
    
    mean_res=res.mean()
    score=np.sqrt(mean_res)
    return score  
    
```

==> 점수가 낮으면 정확도가 높다

```
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.ensemble import RandomForestRegressor
```



```
kfold=KFold(n_splits=10, shuffle=True, random_state=42)
model=RandomForestRegressor(n_estimators=100,n_jobs=-1,random_state=42)
```



모델 생성

```
fn=['season','holiday','workingday','weather','year', 'hour', 'dayofweek', 'temp', 'atemp','humidity', 'windspeed' ]
xTrain=train[fn]
yTrain=train['count']
xTest=test[fn]
model.fit(xTrain, yTrain) ## RandomForestRegressor(n_jobs=-1, random_state=42)
pred=model.predict(xTest) ## 결과 추출
score=cross_val_score(model, xTrain, yTrain, cv=kfold, scoring=rmsle_scorer)
## 점수 산정식 대입
```

score 결과 

```
array([0.29213656, 0.32190952, 0.34583871, 0.33111357, 0.33148822,
       0.32743529, 0.35781392, 0.33394944, 0.31978929, 0.35100647])
```

==> 평균 0.33


