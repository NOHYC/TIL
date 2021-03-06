# 0925

## 데이터 전처리

### sklearn.preprocessing 

#### LabelEncoder, OneHotEncoder

데이터 유형이 문자면 숫자로 바꿔주어 모델을 만들어야함

숫자는 **레이블 인코딩**, **원핫 인코딩**으로 바꿔줄 수 있다.



문자열 데이터는 **카테고리형(학점, 도시 등.... )**과 **텍스트형 ( 일반적인 문장에 포함된 단어들 ...)**로 구성되어 있다. 

EX) 학점 ( 카테고리형 )

A : 1 , B : 2 .... C ... F ... 레이블 인코딩 : 숫자가 커질 수록 학점이 나쁘다. (A < B < C < D < F)

도시 ( 카테고리형 )

서울 -> 1 대전 -> 2 부산-> 3 제주 -> 4 (레이블 인코딩?  x  :  1 + 2 = 3 == 서울 + 대전 = 부산? 아니다.)

원핫 인코딩 

서울 : 10000 대전 : 01000 부산 : 00100 제주 : 000010 ...



## 전처리 과정에서 표준화, 정규화를 하지 않아도 될 ML : Decision Tree, RandomForest

> 분류 규칙을 정해 놓기 때문에 Decision Tree와 RandomForest에서는 데이터 간 얼마나 뭉쳐져 있는가. 즉, 데이터가 뭉쳐져 있어 분류하기 쉽고 데이터가 분산되어있어 분류하기 어려운가를 따진다.



## confusion matrix ( 정오 행렬 )



```
from sklearn.metrics import confusion_matrix, accuracy_score
```

==> 정오행렬과 정확도 함수



```
confusion_matrix(ytest,ypred)
```

```
array([[89,  1],
       [ 1, 52]], dtype=int64)
```



암을 검진할 때 암에 걸린 것을 양성(P) 걸리지 않은 것을 음성(N)

종양 (tumar) 양성 (benign) 악성 (malignat)



|          | 예측 암0 | 예측 암x |
| -------- | -------- | -------- |
| 실제 암0 | 89(TP)   | 1(FN)    |
| 실제 암x | 1(FP)    | 52(TN)   |



TP: 암을 암이라고 예측

TN : 암이 아닌 것을 암이라고 정확하게 예측

FP : 암을 암이 아니라고 잘못 예측

FN : 암이 아닌 것을 암이라고 잘못 예측



