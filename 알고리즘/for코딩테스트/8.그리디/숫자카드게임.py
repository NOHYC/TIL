# 숫자 카드 게임은 여러 개의 숫자 카드 중에서 가장 높은 숫자가 쓰인 카드 한장을 뽑는 게임이다. 단, 게임의 룰을 지키며 카드를 뽑아야하며 룰은
# 다음과 같다.
# 1. 숫자가 쓰인 카드들이 N x M 형태로 놓여있다. 이때 N은 행의 개수를 의미하며, M은 열의 개수를 의미한다.
# 2. 먼저 뽑고자 하는 카드가 포함되어 있는 행을 선택한다.
# 3. 그 다음 선택되 행에 호팜된 가드들 중 가장 숫자가 낮은 카드를 뽑아야한다.
# 4. 따라서 처음에 카드를 골라낸 행을 선택할 때, 이후에 해당 행에서 가장 숫자가 낮은 카드를 뽑을 것을 고려하여 최종적으로 가장 높은 숫자의
# 카드를 뽑을 수 있도록 전략을 세워야한다.


########################## 내가 쓴답 ########################33
n,m = map(int,input().split())
max_list = []
for i in range(n):
    list_m = list(map(int,input().split()))
    max_list.append(min(list_m))
print(max(max_list))

###################### 문제해설 ########################3

n,m = map(int, input().split())
result = 0
for i in range(n):
    data = list(map(int,input().split()))
    min_value = min(data)
    result = max(result,min_value)

print(result)
####################### 2중 반복문 구조 ################
n,m = map(int,input().split())

result = 0
for i in range(n):
    data = list(map(int, input().split))
    min_value = 10001
    for a in data:
        min_value = min(min_value,a)
    result = max(result,min_value)

print(result)