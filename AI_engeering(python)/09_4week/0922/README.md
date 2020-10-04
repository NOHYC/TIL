# 0922

## 타이타닉 생존여부 예측 머신러닝



> 문제 : xTrain, 정답 : yLabel ->모델링(의사결정트리알고리즘) => 모델
>
> 테스트 입력 데이터:xTest -------------------------------------------> 입력 ====> 생존여부 출력(예측결과) => 캐글 서버에 제출 => 점수 및 등수 확인



- 데이터 가져오기

```
train=pd.read_csv("train.csv")
test=pd.read_csv("test.csv")
```

- 데이터 기술 통계치 확인

```
train.describe()
```

```
	PassengerId	Survived	Pclass		Age			SibSp		Parch		Fare
count891.000000	891.000000	891.000000	714.000000	891.000000	891.000000	891.000000
mean446.000000	0.383838	2.308642	29.699118	0.523008	0.381594	32.204208
std	257.353842	0.486592	0.836071	14.526497	1.102743	0.806057	49.693429
min	1.000000	0.000000	1.000000	0.420000	0.000000	0.000000	0.000000
25%	223.500000	0.000000	2.000000	20.125000	0.000000	0.000000	7.910400
50%	446.000000	0.000000	3.000000	28.000000	0.000000	0.000000	14.454200
75%	668.500000	1.000000	3.000000	38.000000	1.000000	0.000000	31.000000
max	891.000000	1.000000	3.000000	80.000000	8.000000	6.000000	512.329200
```

결측값, 평균 중위수 표준편차 확인 후 데이터 전처리 시작

Age 결측값 많음, Fare 평균과 중위수 차가 큼 ( 극단치 )



- Age 결측치 채우기 
  - 나이의 평균값으로 대체

```
train['Age_mean'].fillna(train['Age'].mean(), inplace=True)
test['Age_mean'].fillna(test['Age'].mean(), inplace=True)
```



- 결측치 갯수 확인

```
train['Age_mean'].isnull().sum()
test['Age_mean'].isnull().sum()
```

```
0
```



- 성별에 따라 True / False 값으로 대체 ( True/False == 1 / 0 으로 int 값이라 할 수 있다.)

```
train['Gender']= (train['Sex']=='female') #female => True, male => False 저장
test['Gender']= (test['Sex']=='female')
```

```
train['Gender'].value_counts()
```

```
False    577
True     314
Name: Gender, dtype: int64
```



- 항구에 따른 승선 인원 True / False로 대체 
  - 데이터 형태 확인

```
train['Embarked'].value_counts()
```

```
S    644
C    168
Q     77
Name: Embarked, dtype: int64
```

- Embarked_S,Embarked_C,Embarked_Q 열 생성 후 True / False로 데이터 변환

```
train['Embarked_S']=train['Embarked']=='S'
train['Embarked_C']=train['Embarked']=='C'
train['Embarked_Q']=train['Embarked']=='Q'
```



- Familysize 열을 만들어 SibSp와 Parch 병합 ( 배우자와 자녀 열을 가족 크기로 변환 )
  - SibSp + Parch + 1( 자신 )

```
train['FamilySize']=train['SibSp']+train['Parch']+1
train['FamilySize'].value_counts()
```

```
1     537
2     161
3     102
4      29
6      22
5      15
7      12
11      7
8       6
Name: FamilySize, dtype: int64
```



- 가족 사이즈를 인원에 따라  3종류(S,M,L)로 나눔

```
test['FamilySize']=test['SibSp']+test['Parch']+1
test['Family']=test['FamilySize']
test.loc[test['FamilySize']==1, 'Family']='S'
test.loc[(test['FamilySize']>=2) & (test['FamilySize']<5) , 'Family']='M'
test.loc[test['FamilySize']>=5, 'Family']='L'
```

```
train.loc[train['FamilySize']==1, 'Family']='S'
train.loc[(train['FamilySize']>=2) & (train['FamilySize']<5) , 'Family']='M'
train.loc[train['FamilySize']>=5, 'Family']='L'
```

- 새로운 열을 만들어 True/ False로 저장

```
train['Family_S']=train['Family']=='S'
train['Family_M']=train['Family']=='M'
train['Family_L']=train['Family']=='L'
```

```
test['Family_S']=test['Family']=='S'
test['Family_M']=test['Family']=='M'
test['Family_L']=test['Family']=='L'
```



- Pclass 데이터를 카테고리형으로 변환

```
train['Pclass']=train['Pclass'].astype('category')
train['Pclass']
```

```
0      3
1      1
2      3
3      1
4      3
      ..
886    2
887    1
888    3
889    1
890    3
Name: Pclass, Length: 891, dtype: category
Categories (3, int64): [1, 2, 3]
```



- 전처리한 데이터를 골라낸다. 종속변수와 독립변수로 나누는것

```
fn=['Gender','Age_mean','Embarked_S', 'Embarked_C', 'Embarked_Q',
   'Family_S', 'Family_M', 'Family_L'] 
xTrain=train[fn]
yLabel=train['Survived']
```

```
xTest=test[fn]
```



- DecisionTreeclassfier 모델 생성 후 학습

```
from sklearn.tree import DecisionTreeClassifier

dtc = DecisionTreeClassifier(random_state= 42,max_depth=5)
dtc.fit(xTrain,yLabel)
ypred=dtc.predict(xTest)
```

- 제출

```
test['Survived']=ypred
res=test[['PassengerId', 'Survived']]
res.to_csv('sub.csv',index = False)
```



- 결과

![image-20201004123009168](C:\Users\nyc15\AppData\Roaming\Typora\typora-user-images\image-20201004123009168.png)