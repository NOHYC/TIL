# 문제 큰수의 법칙
# 큰수의 법칙은 일반적으로 통계분야에서 다루어지는 내용이지만 동빈이는 본인만의 방식으로 다르게 사용하고 있다. 동빈이의 큰 수의 법칙은 다양한 수로 이루어진 배열이 있을때
# 주어진 수들을 M번 더하여 가장 큰 수를 만드는 법칙이다. 단, 배열의 특정한 인덱스에 해당하는 수가 연속해서 K번 초과하여 더해줄 수 없는 것이 이 법칙의 특징이다.
# 예를 들어 순서대로 2,4,5,6,으로 이루어진 배열이 있을 때  M이 8이고 K가 3이라고 가정하자. 이 경우 특정한 인덱스의 수가 3번까지 더해질 수 있으므로 큰 수의 법칙에 따른 결과는
# 6 + 6 + 6 +5 +6 + 6+ 6 + 5 인 46이 된다.
# 단, 서로 다른 인덱스에 해당하는 수가 같은 경우에도 서로 다른 것으로 간주한다. 예를 들어 순서대로 3,4,3,4,3 으로 이루어진 배열이 있을 때 M이 7이고 K가 2라고 가정하자.
# 이 경우 두 번째 원소에 해당하는 4와 네번째 해당하는 4를 번갈아 두번 더하는 것이 가능하다. 결과적으로 4+4+4+4+4+4+4 인 28이 도출된다.
# 배열의 크기 N, 숫자가 더해지는 횟수 M, 그리고 K가 주어질 때 동빈이의 큰 수의 법칙에 따른 결과를 출력하시오

N , M, K = map(int, input().split())
#print(N,M,K)
list_n = list(map(int,input().split()))
# N ,M ,K = 5,8,3
# list_n = [2,4,5,4,6]

###################################### 내가 적은 답 ##########################
list_n= sorted(list_n)
large_nums = list_n[-2:].copy()
# print(large_nums)

if M % (K+1) == 0:
    x = M // (k+1)
    print(x*(large_nums[-1]*K+large_nums[-2]))
else:
    x = M // (k+1)
    y = M % (k+1)
    print(x*(large_nums[-1]*K+large_nums[-2])+y*large_nums[-1])

###################################### 풀이 1 (단순) ##########################
list_n.sort()
first = list_n[-1]
second = list_n[-2]

result = 0
while True:
    for i in range(K):
        if M == 0:
            break
        result += first
        m -=1
    if m == 0:
        break
    result += second
    m -= 1
print(result)

####################################### 풀이 2 (수열) ############################
list_n.sort()
first = list_n[-1]
second = list_n[-2]

count = int(m/(k+1)+k)
count += m%(k+1)

result = 0
result += (count)*first
result += (m-count)*second

print(result)
