# 행복 왕국의 왕실 정원은 체스판과 같은 8 x 8 좌표 평면이다. 왕실 정원의 특정한 한 칸에는 나이트가 서있다. 나이트는 매우 충성스런
# 신하로서 매일 무술을 연마한다. 나이트는 말을 타고 있기 때문에 이동할 때는 L 형태로만 이동할 수 있으며 정원 밖으로는 나갈 수 없다.
# 나이트는 특정한 위치에서 다음과 같은 2가지 경우로 이동할 수 있다.
# 1. 수평으로 두 칸 이동한 뒤에 수직으로 한 칸 이동하기
# 2. 수직으로 두 간 이동한 뒤에 수평으로 한 칸 이동하기
# 이 처럼 8 x 8 좌표 평면상에서 나이트의 위치가 주어졌을 때 나이트가 움직일 수 있는 경우의 수를 출력하는 프로그램을 작성하시오. 이 때
# 왕실의 정원에서 행 위치를 표현할 때는 1부터 8로 표현하며 열의 위치는 a부터 h로 표현한다.
# 예를 들어 만약 나이트가 a1에 있을 때 이동할 수 있는 경우의 수는 다음 2가지이다. 
# 또 다른 예로 나이트가 c2에 위치해 있다면 나이트가 이동할 수 있는 경우의 수는 6가지이다.

ins = list(input())
alph =list('abcdefgh')
x = [num for num,i in enumerate(alph) if ins[0] == i][0]
y= int(ins[1])-1
n = 8
dx =[2,2,-2,-2,-1,1,-1,1]
dy =[-1,1,-1,1,2,-2,-2,2]
count = 0
for move in range(8):
    nx = x+dx[move]
    ny = y+dy[move]
    if nx <0 or ny <0 or nx > n-1 or ny > n-1:
        continue
    count+=1
print(count)

############################# 답안 ##################################
input_data= input()
row = int(input_data[1])
columns = ord(input_data[0])-ord('a') # 아스키코드 이용

steps =[(-2,-1),(-1,-2),(1,-2),(2,-1),(2,1),(1,2),(-1,2),(-2,1)]
result =0
for step in steps:
    next_row = row+step[0]
    next_columns = column +step[1]

    if next_row >=1 and next_row <=8 and next_columns >=1 and next_columns <= 8:
        result+=1
print(result)