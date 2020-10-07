# 1006

## R 언어

>install.packages('패키지 이름'), library('패키지 이름') , left_join 
>
>변수명 <- c( 숫자 (문자), 숫자(문자) ), data.frame(배열,배열 .... ) , df$columns 
>
>read_excel('경로',col_names = T/F , sheet = n), str(df), write.csv(data , 'data.csv')
>
>head(df),tail(df) , dim(df) , surmmary(df), rename(data, 변경 후column 이름 = 변경 전 column 이름) , qplot(데이터)
>
>ifelse(조건식, 참, 거짓 ) ,  table(데이터 프레임$ 컬럼명) , %>% , filter(참인 조건식)
>
>select(컬럼 명) ,  arrange(컬럼명),  mutate(생성컬럼 = data) 
>
>summarise(생성 컬럼명 = 컬럼에 함수 적용 ) , group_by(컬럼명)
>
>ggplot2::mpg,  bind_rows(df1,df2) , left_join(df1,df2,by= 컬럼명) 

### R 기본 사용법 

- 코드 실행 방법
  - 스크립트창에 코드 입력 후 ctrl + Enter
  - 콘솔창에 코드  입력 후 ctrl + Enter
- 기존에 실행했던 코드 재사용
  - history 창 코드 더블  클릭 -> 콘솔창에 history에서 더블클릭한 코드 생성 
- 모르는 함수, 라이브러리 검색 
  - 스크립트에 함수(라이브러리) 이름 넣고 F1 누르면 사용 방법 나옴 

### R 기본 문법 

install.packages('패키지 이름') : 패키지 다운로드

- \[p\] : pip install  패키지이름



library('패키지 이름') : 패키지 사용 선언 

- \[p\] : import 패키지 이름 



변수명 <- c( 숫자 (문자), 숫자(문자) ) : 변수에 배열을 대입해준다. 

- [numpy] : 변수명 = np.array( 숫자(문자), 숫자(문자) )



data.frame(배열,배열 .... ) : 데이터 프레임 생성 

- [p] : pd.DataFrame( 배열, 배열,...)



df$columns : df의 하위 객체에 접근한다.  ( $ == . )

- [p] : df.columns 



read_excel('경로',col_names = T/F , sheet = n) : 엑셀 데이터 파일 불러오기 / col_names : columns 비워서 데이터 프레임 출력   sheet = n : n번째 sheet 가져오기  

- [p] : pd.read_csv(' 파일명 ',header = None )



str(df) : structure자료구조가 나온다. 

- \[p\]: df.info()



write.csv(data , 'data.csv') : 데이터 프레임 csv 파일로 저장

- [p] : data.to_csv('data.csv')



head(df),tail(df) == 파이썬 head, tail 과 같다 . 다른점은 출력되는 개수 R : 6개  python: 5개 



dim(df) : 파이썬에서 shape와 같다. 

- [p] : df.shape



surmmary(df) : 파이썬에서 describe와 같다. 

- [p] : df.describe() 



rename(data, 변경 후column 이름 = 변경 전 column 이름) : 데이터 프레임의 컬럼 이름 변경 

- [p] : df.rename( {'바뀌기 전 컬럼명':' 바뀐 후 컬럼명'},inplace = True)



ifelse(조건식, 참, 거짓 ) 

- [p] : np.where(조건식, 참, 거짓)



qplot(데이터) : 데이터 빈도 그래프 == 히스토그램 ( 세로축: 빈도, 가로축 : 변수명 )

- [p] : plt.hist(데이터프레임 ) 



table(데이터 프레임$ 컬럼명)  : 데이터 개수를  세준다.

- [p] : df.value_counts()

%>% : 파이프 라인 역할  ctrl + shift + m 

- 파이썬에서 함수접근할 때 쓰는 .과 같다고 보면됨 
- exam %>% filter(class == 1) ==> exam 데이터 프레임에 필터 함수를 적용한다. 조건은 class컬럼이 1인 것들이다. 파이썬에서 쓰면 exam[exam.class == 1] 이런 느낌일듯

filter(참인 조건식)  : 필터 역할이라고 보면된다. 조건이 참인 것만 걸러낸다.

select(컬럼 명) : 해당 컬럼만 선택해 출력 , - 컬럼명일 경우 해당 컬럼만 제외하고 모두 출력 



arrange(컬럼명) : 컬럼명 기준 오름차순 정렬한다.  desc(컬럼명) : 내림차순

- [p] : sort_values(by = 컬럼명)

응용 

> exam %>% filter(class == 1 | class == 3 |  class == 5)
>
> exam %>% filter(class %in% c(1,3,5)) # 위 아래가 같다! 



mutate(생성컬럼 = data) : 파생변수 추가 

- [p] : df['생성컬럼'] =data 



summarise(생성 컬럼명 = 컬럼에 함수 적용 ) : 집계 함수 

- ex)

```
# 집계
exam %>% 
  summarise(mean_math = mean(math))
```

```
  mean_math
1     57.45
```



group_by(컬럼명) : 집계함수 groupby 

- df.groupby('컬럼').적용함수()

```
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math),n=n()) # n() 빈도 
```

```
# A tibble: 5 x 3
  class mean_math     n
  <int>     <dbl> <int>
1     1      46.2     4
2     2      61.2     4
3     3      45       4
4     4      56.8     4
5     5      78       4
```



ggplot2::mpg : ggplot 내에 있는 mpg데이터를 불러온다.



bind_rows(df1,df2) : 아래로 데이터 프레임을 붙인다. 

- [p] :  pd.concat([a,b],axis = 0)



left_join(df1,df2,by= 컬럼명) : class 기준 exam과 name을 결합 // 두 데이터 프레임에 같은 컬럼이 있어야한다. 

- pd.merge(df1,df2,on = 컬럼명)



