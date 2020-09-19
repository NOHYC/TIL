# 정수 n이 입력되면 00시 00분 00초 부터 n시 59분 59초까지의 모든 시각중에서 3이 하나라도 포함되는 모든 경우의 수를 구하는 프로그램을 작성하시오
# 예를 들어 1을 입력했을 때 다음은 3이 하나라도 포함되어 있으므로 세어야하는 시각이다. 00시 00분 03초, 00시 13분 30초
# 입력 : 첫째줄에 정수 n이 입력된다.
# 출력 : 00시 00분 00초 부터 n시 59분 59초까지의 모든 시각 중에서 3이 하나라도 포함되는 모든 경우의 수를 출력한다.
n = 5
hours = range(0,n+1)
minus = range(0,60)
seconds = range(0,60)
count=0
for hour in hours:
    for minu in minus:
        for second in seconds:
            time = list(str(hour) + str(minu) + str(second))
            if '3' in time:
                count+=1
print(count)