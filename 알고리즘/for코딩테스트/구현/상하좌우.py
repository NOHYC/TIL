# 여행가 A는  N x N 크기의 정사각형 공간위에 서있다. 이 공간은 1 x 1 크기의 정사각형으로 나누어져있다. 가장 왼쪽 좌표는 1,1이며
# 가장 오른쪽 아래 좌표는 N,N이다. 여행가는 상하좌우 방향으로 이동할 수 있으며 시작 좌표는 항상 1,1이다. 우리 앞에 여행가 A가
# 이동할 계획이 적힌 계획서가 놓여있다. 계획서에는 하나의 줄에 띄어쓰기를 기준으로 하여 L,R, U, D 중 하나의 문자가 반복적으로
# 적혀있다. 이 때 여행가 A가 N x N 크기의 정사각형 공간을 벗어나는 움직임은 무시된다. 예를 들어 1,1 위치에서 L또는 U를 만나면
# 무시된다. 첫번째 줄에는 공간의 크기를 나타내는 N이 주어진다. 두번째 줄에 여행가 A가 이동할 계획서 내용이 주어진다.


#test = [[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]
n =  5
# test = [list(range(1,n+1)) for i in range(n)]
# print(test)
dir_list = ['R','R','R','U','D','D']
now_x , now_y = 0,0

for i in dir_list:
    if i == 'R' :
        now_x+=1
    elif i == 'L':
        now_x -=1
    elif i == 'U':
        now_y -=1
    elif i == 'D':
        now_y +=1

    if now_x < 0:
        now_x = 0
    elif now_y < 0:
        now_y = 0
    elif now_x > n-1:
        now_x = n-1
    elif now_y > n-1:
        now_y = n-1

print(now_x,now_y)
print(now_y+1,now_x+1)
#print(test)
################################ 문제 해설 ############################

n = int(input())
x,y = 1, 1
plans = input().split()

# L, R, U, D에 따른 이동 방향
dx = [0,0,-1,1] # 2차원 행렬에서 열
dy = [-1,1,0,0] # 2차원 행렬에서 행
move_type = ['L','R','U','D'] #dx, dy와 맞추는게 중요!


for plan in plans:
    for i in range(len(move_type)):
        if plan == move_type[i]:
            nx = x + dx[i]
            ny = y + dy[i]
    if nx < 1 or ny <1 or nx > n or ny > n : # 이 조건을 만족시키지 못하면 nx,ny 소멸
        continue
    x,y = nx,ny

print(x,y)

