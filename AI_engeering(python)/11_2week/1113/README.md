# 1113

## CNN 알고리즘

> cnn => [합성곱계층 + 신경망] ->  (softmax) 분류결과 ex) cat(70) .. dog(20) ... -> 가장 큰값이 분류 결과로 나온다.
>
> 합성곱 계층 : 사진 특징 추출
>
> 합성곱 계층 [fiter -> relu]
>
> 내부			 [filter -> relu]
>
> .... 
>
> ​					 [filter -> relu]
>
> 필터가 특징을 추출한다.
>
> relu 특징값을 비선형값으로 변형하는 함수 ( 활성화 함수) 
>
> CNN => 필터를 공부한다고 봐도 무방
>
> 필터란?
>
> 어떤 특징이 이미지 데이터에 있는지 또는 없는지 검출하는 함수이다.
>
>
> CNN을 쓰는 이유
>
> 신경망이 가지고 있는 문제점을 해결
>
> 이미지 생김새 정보들
>
> 1.  이미지 생김새 정보 사용 // 퍼셉트론이 여러 계층 : 다층 퍼셉트론
> 2. 다층 퍼셉트론은 픽셀값이 매우 민감하게 반응
>
> 숫자 이미지로부터 ' 공통된 생김새 정보들' 추출
>
>
> 이미지와 작은 필터 특징과 합성곱 => 이미지 마지막 부분까지 진행
>
> 필터가 이동하는 것은 스트라이드
>
> 같은 특징이 나타나면 합성곱 값이 크게 나온다.
>
> 다르면 0에 가까운 값이 나온다.
>
> 
>
> 이런 필터가 여러개 있다 -> 여러 계층이 있다.
>
> 선행 차원은 저차원 특징들을 찾는다. ( 직선, 대각선 ) 
>
> 후행 차원은 복잡한 차원의 특징을 찾는다.



신경망 ( 이미지 )

datasets.mnist => 이미 차원 정리되어 있다.

mnist 데이터 정규화는 데이터를 255로 나눠서 계산

신경망 model

```
model = Sequential([
    Flatten(input_shape=(28, 28)), # 데이터 차원 변경 1차원으로 변경 784
    Dense(256, activation='relu'), # 첫번째 히든 레이어 (h1) 784 x 256 +256
    Dense(128, activation='relu'), # 두번째 히든 레이어 (h2) 256 x 128 + 128
    Dropout(0.1), # 두번째 히든 레이어(h2)에 드랍아웃(10%) 적용 128 x 0.1 =약 13개 뺀다.
    # 학습될 때마다 랜덤하게 노드 13개 빠진다. (0.1-> 0.5) 과적합 방지 0.5까지 사용
    Dense(10), # 세번째 히든 레이어 (logit)
    Activation('softmax') # softmax layer
])
# model.add 해도 되고 sequantial안에 리스트로 만들어도 된다. 
# 정확도 97.9 dropout(0.1) 
# 정확도 98.1 dropout(0.5)
```

> 1차원으로 변경되면서 이미지 데이터의 특징을 추출하지 못함
>
> 정확도 높이는데 한계가 있다.



| 문제 유형        | 손실함수명                                      | 활성함수   | 참고                                                         |
| ---------------- | ----------------------------------------------- | ---------- | ------------------------------------------------------------ |
| 다중 클래스 분류 | categorical_crossentropy (범주형 교차 엔트로피) | 소프트맥스 | 10챕터 로이터 뉴스 분류하기 실습 참고                        |
| 다중 클래스 분류 | sparse_categorical_crossentropy                 | 소프트맥스 | 범주형 교차 엔트로피와 동일하지만 이 경우 원-핫 인코딩이 된 상태일 필요없이 정수 인코딩 된 상태에서 수행 가능. |





CNN ( 컨벌루션 )



- 이미지가 흑백일 때 (60000,28,28,1) // 컬러일 때 (60000,28,28,3) // 채널 1 ~ 3 (RGB)

```
train = np.reshape(x_train, (60000,28,28,1))
x_test = np.reshape(x_test, (10000,28,28,1))
```





```
model = Sequential()
model.add(Conv2D(16, kernel_size=(5, 5), # 필터의개수16, 필터의 크기 5x5
                 activation='relu',
                 input_shape=(28,28,1),padding='same')) # 28x28 @ 5x5 = 24x24 
# 차원이 줄어든다. => paddings 를 사용하면 차원 유지
# 출력결과 28,28,16
model.add(MaxPooling2D(pool_size=(2, 2))) # 2x2 -> 1 28x28x16 -> 14x14x16
model.add(Conv2D(32, kernel_size=(5, 5), activation='relu',padding='same'))
# 14,14,32
model.add(MaxPooling2D(pool_size=(2, 2)))
# 7,7,32
model.add(Flatten())
# 7x7x32 차원
model.add(Dense(128, activation='relu'))
# 128개 노드와 7x7x32차원과 fully connected
model.add(Dense(num_classes, activation='softmax'))
# 10개와 128개 fully connected 
# 결과가 확률로 나온다.
```



- 내부 차원 설명

```
# 28,28,1 => 28x28 흑백
# 16가지 필터  == 16가지 패턴 ( 5x5 사이즈)
# 28,28,16  =>
# pooling  
# 14,14,16
# 32가지 필터
# 14,14,32
# pooling 
# 7,7,32
# flatting --7 x 7 x 32 차원
# fully connected 
# 0 ~ 9 
# logit
# softmax
# 0 ~ 9 까지 숫자일 확률 표현
# cost log => 실제값과 예측값 
# back propa~
```

