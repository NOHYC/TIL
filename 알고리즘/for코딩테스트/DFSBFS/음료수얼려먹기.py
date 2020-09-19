problem = '''
n x m 크기의 얼음 틀이 있다. 구멍이 뚫려있는 부분은 0, 칸막이가 존재하는 부분은 1로 표시된다. 구멍이 똟려 있는 부분끼리
상,하,좌,우로 붙어있는 경우 서로 연결되어 있는 것으로 간주한다. 이때 얼음 틀의 모양이 주어졌을 때 생성되는 총 아이스크림의
개수를 구하는 프로그램을 작성하기오. 다음의 4 x 5 얼음 틀 예시에서는 아이스크림이 총 3개 생성된다.

입력 조건
첫번째 줄에는 얼음 틀의 세로 길이 n과 가로 길이m이 주어진다.(1<m,n< 1000)
두번째 줄부터는 n+1 번째 줄까지 얼음 틀의 형태가 주어진다.
이때 구멍이 뚤려있는 부분은 0, 그렇지 않은 부분은 1이다.

출력 조건
한 번에 만들 수 있는 아이스크림의 개수를 출력한다.

'''
# n,m을 공백으로 구분하여 입력받기
n,m = map(int,input().split())

# # 2차원 리스트의 맵 정보 입력 받기

graph = []
for i in range(n):
    graph.append(list(map(int,input().split())))

# dfs로 특정한 노드를 방문한 뒤에 연결된 모든 노드들도 방문
def dfs(x,y):
    # 주어진 범위를 벗어나는 경우에는 즉시 종료
    if x <= -1 or x >=n or y<-1 or y>=m :
        return False
    
    # 현재 노드를 아직 방문하지 않았다면
    if graph[x][y] == 0:
        # 해당 노드 방문 처리
        graph[x][y] = 1
        # 상하좌우 위치도 모두 재귀적 호출
        dfs(x - 1, y)
        dfs(x, y - 1)
        dfs(x + 1, y)
        dfs(x, y + 1)
        return True
    return False


result = 0

for i in range(n):
    for j in range(m):
        # 현재 위치에서 dfs 수행
        if dfs(i,j) == True:
            result +=1

print(result)

