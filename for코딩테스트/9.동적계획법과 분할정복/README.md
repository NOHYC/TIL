# 동적 계획법 (Dynamic Programming) and 분할 정복 (Divide and Conquer)

## 1. 정의

### 동적계획법

- 입력의 크기가 작은 부분 문제들을 해결한 후, 해당 부분 문제의 해를 활용해서, 보다 큰 크기의 부분 문제를 해결, 최종적으로 전체 문제를 해결하는 알고리즘
- 상향식 접근법으로, **가장 최하위 해답**을 구한 후, 이를 저장하고, 해당 결과값을 이용해서 상위 문제를 풀어가는 방식

- Memoization 기법을 사용함
  - Memoization : 프로그램 실행 시 이전에 계산한 값을 저장하여, 다시 계산하지 않도록 하여 전체 실행 속도를 빠르게 하는 기술
  - 문제를 잘게 쪼갤 때 부분 문제는 중복되어 재활용됨

### 분할 정복

- 문제를 나눌 수 없을 때까지 나누어서 각각을 풀면서 다시 합병하여 문제의 답을 얻는 알고리즘
- 하향식 접근법으로, 상위의 해답을 구하기 위해, 아래로 내려가면서 하위의 해답을 구하는 방식
  - 일반적으로 재귀함수
- 문제를 잘게 쪼갤 때, 부분 문제는 서로 중복되지 않음
  - 병합 정렬, 퀵 정렬

## 2. 공통점과 차이점

### 공통점

- 문제를 잘게 쪼개서, 가장 작은 단위로 분할



### 차이점

- 동적 계획법
  - 부분 문제는 중복되어, 상위 문제 해결 시 재활용됨
  - 메모이제이션 기법 사용
- 분할 정복
  - 부분 문제는 서로 중복되지 않음
  - 메모이제이션 사용 안함

## 3. 동적계획법 알고리즘의 이해

피보나치 수열 

![image-20210203224242829](README.assets/image-20210203224242829.png)

![image-20210203225119534](README.assets/image-20210203225119534.png)





### 재귀함수 사용

```python
def fibo(num):
    if num <= 1:
        return num
    return fibo(num-1) + fibo(num -2 )
```

![image-20210203225247825](README.assets/image-20210203225247825.png)

### 동적 계획법

```python
def fibo_dp(num):
    cache = [0 for index in range(num + 1)]
    cache[0] = 0
    cache[1] = 1
    
    for index in range(2,num + 1):
        cache[index] = cache[index - 1] + cache[index - 2]
    return cache[num]
```

![image-20210203224715281](README.assets/image-20210203224715281.png)





또 다른 동적 계획법( 점화식 )

```python
fibo = [] 
for x in range(0,10):
    if x < 2: 
        fibo.append(1) 
    else: fibo.append(fibo[x-2] + fibo[x-1])
```

