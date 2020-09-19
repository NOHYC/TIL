# import sys
# n, ans = int(sys.stdin.readline()),0
# # 직선위 + 대각선, - 대각선
# a,b,c = [False]*n , [False]*(2*n-1),[False]*(2*n-1)
# def sol(i):
#     global ans
#     if i == n:
#         ans+=1
#         return
#     for j in range(n):
#         if (not a[j] and not b[i+j] and not c[i-j+n-1]):
#             a[j] = b[i+j] = c[i-j+n-1] = True
#             sol(i+1)
#             a[j] = b[i+j] = c[i-j+n-1] = False
        
# sol(0)
# print(ans)



def adj(x):
    for i in range(x):
        if row[x] == row[i] or abs(row[x] - row[i] )== x - i:
            return False
    return True

def dfs(x):
    global res
    if x == N:
        res += 1
    else:
        for i in range(N):
            row[x] = i
            if adj(x):
                dfs(x+1)

N= int(input())
row = [0]*N
res = 0
dfs(0)
print(res)