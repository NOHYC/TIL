# 1102

> 모델링하기 위해서 데이터 분할 방법
>
> 1. 훈련용 : 테스트 = 7 : 3
> 2. 훈련 : 검증 : 테스트 = 3 : 3 : 3
>
> - 모델 평가는 테스트 데이터로 하고 검증용 데이터는 모델의 성능을 조정하기 위해 사용( 과적합, 하이퍼 파라미터)



- 여러 개의 독립변수 x  - > 종속 변수 y를 예측
  - 가중치(w)와 편향(bias)
- 독립 변수 x들은 행렬로 나타낸다.
- m개의 독립변수가 n개 있다.
  - 행렬 x => m x n
  - feature의 개수가 차원의 개수이다.

## 혼동행렬 (confusion matrix)

> 머신러닝 모델에서 실제(actual)와 예측(predict) 사이의 관계를 타나낸다.

- 정확도 : 전체 중에서 몇 개가 맞았는가

- 혼동행렬

|      |      | 예측 | 예측 |
| ---- | ---- | ---- | ---- |
|      |      | 참   | 거짓 |
| 실제 | 참   | TP   | FN   |
| 실제 | 거짓 | FP   | TN   |

- T : 맞춘 것
- N : 틀린 것
- P : 맞다고 예측
- N : 틀렸다고 예측

**정밀도** (precision): TP / ( TP + FP )  => 예측한 것 중 맞춘것

**재현률** ( recall ) : TP / (TP + FN )



## epoch 

> 전체 훈련 data의 훈련 횟수, 많아질 수록 과적합 위험
>
> ex) 5 epoch : 5번 data로 훈련하였다.



가설함수, 비용함수, 경사하강법



단순 선형 회귀

y = wx + b

(d = y - y') 실제와 예측값 차



다중 선형 회귀 ( 독립 변수가 여러 개 )

y = w1x1 + w2x2 + w3x3 + .... + b



cost function : 평균 제곱 오차



*fit() : 모델 학습*

x,y, batch size = 1, epoch

/// 몇 개의 샘플로 가중치 갱신

## keras ( 케라스 )

> Sequential 클래스로 모델 생성 ( 순차적으로 레이어를 쌓아가는 모델링)

1. 데이터 set 생성

- 훈련 / 검증 / 시험 set 생성
- 데이터 형식 변환 ( 모델을 만들기 적절하게 작업 )

ex) mnist 데이터

```
xtrain = xtrain.reshape(60000,28*28).astype('float32')/255.0
xtest = xtest.reshape(10000,28*28).astype('float32')/255.0
```

- 6만개 훈련 데이터와 1만개 테스트 데이터 형식을 변환 
- 왜 255로 나눌까? 
  - 이미지 데이터는 대부분 0으로 구성되어 있다.
  - 나눔으로서 편협한 데이터를 정규화한다.



```
ytrain = np_utils.to_categorical(ytrain)
ytest = np_utils.to_categorical(ytest)
```

- 원핫 인코딩 
- **from keras.utils import np_utils**
  - np_utils.to_categorical()  함수 사용



2. 모델 ( 신경망/ 깊은 신경망 ) 구성

- Sequential 클래스 이용해서 레이어 추가하여 구성
- 복잡한 모델의 경우 : keras 함수 API 사용

3. 모델에 대한 학습 과정 설정

- cost 함수에 대한 정의, 최적화 방법 정의
- compile 함수

4. 모델 학습 

- 훈련 -> 모델 학습
- fit 함수

5. 학습 과정 점검

- 훈련 set, 검증 set cost, accuracy 확인
- 반복 횟수 설정

6. 모델 평가

- 테스트 데이터로 평가
- Evaluate 함수

7. 모델 사용

- 임의 입력 데이터 -> 모델 -> 예측된 출력값
- predict 함수



