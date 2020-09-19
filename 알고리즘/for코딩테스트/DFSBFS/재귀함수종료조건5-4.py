def recursive_func(i):
    # 100 번째 출력했을 때 종료되도록 종료 조건 명시
    if i == 100:
        return 
    print(i,'번째 재귀함수에서',i+1,'번째 재귀함수를 호출합니다')
    recursive_func(i+1)
    print(i,'번째 재귀함수를 종료합니다.')

recursive_func(1)

## 2가지방식으로 구현한 팩토리얼

def factorial_iter(n):
    result = 1
    for i in range(1,n+1):
        result *= i
    return result

def factorial_recu(n):
    if n <= 1:
        return 1
    return n*factorial_recu(n-1)
print('반복문으로 구현',factorial_iter(5))
print('재귀문으로 구현',factorial_recu(5))