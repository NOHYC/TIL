# 1029

## 자연어 처리

### 정의

- bow : 단어의 순서는 고려하지 않고 단어의 빈도수를 기반으로 만든 행렬

### 과정

1. 단어 추출( 단어 집합 ) 
2. 단어에 대해 정수 인덱스 설정
3. 단어의 등장 회수를 저장한 벡터를 생성



#### 단어 추출

```
from konlpy.tag import Okt
okt = Okt()
token = okt.morphs(token)
token
```

```
['정부', '가', '발표', '하는', '물가상승률', '과', '소비자', '가', '느끼는', '물가상승률', '은', '다르다']
```



#### 단어에 대해 정수 인덱스 설정(word2index)과 단어 등장 횟수를 저장한 벡터 생성(bow)

```
word2index = {} 
bow = [] 
for v in token:
    if v not in word2index.keys():
        word2index[v] = len(word2index) 
        bow.insert(len(word2index)-1,1)
    else:
        idx =word2index[v]
        bow[idx] = bow[idx]+1
print(word2index)
```

```
{'정부': 0, '가': 1, '발표': 2, '하는': 3, '물가상승률': 4, '과': 5, '소비자': 6, '느끼는': 7, '은': 8, '다르다': 9}
```

```
print(bow)
```

```
[1, 2, 1, 1, 2, 1, 1, 1, 1, 1]
```



#### sklearn에 위 과정을 전부 해주는 라이브러리(CountVectorizer)가 있다.

#### 문서 -> 단어 토큰화

```
from sklearn.feature_extraction.text import CountVectorizer
corpus = ['This is the first document.',
    'This is the second second document.',
    'And the third one.',
    'Is this the first document?',
    'The last document?']
```

```
v = CountVectorizer()
v.fit(corpus)
v.vocabulary_
```

```
{'this': 9,
 'is': 3,
 'the': 7,
 'first': 2,
 'document': 1,
 'second': 6,
 'and': 0,
 'third': 8,
 'one': 5,
 'last': 4}
```

#### bow 생성

```
v.transform(corpus).toarray()
```

```
array([[0, 1, 1, 1, 0, 0, 0, 1, 0, 1],
       [0, 1, 0, 1, 0, 0, 2, 1, 0, 1],
       [1, 0, 0, 0, 0, 1, 0, 1, 1, 0],
       [0, 1, 1, 1, 0, 0, 0, 1, 0, 1],
       [0, 1, 0, 0, 1, 0, 0, 1, 0, 0]], dtype=int64)
```



#### 새로운 문서 입력 <- bow

```
v.transform(['this is the second document']).toarray()
```

```
array([[0, 1, 0, 1, 0, 0, 1, 1, 0, 1]], dtype=int64)
```

#### 

#### 새로운 문서가 corpus에 포함되지 않으면 bow가 0 벡터 출력

```
v.transform(['someting new']).toarray()
```

```
array([[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], dtype=int64)
```



#### 불용어 사용하기 stopwords

```
v = CountVectorizer(stop_words=['and','is','the','this'])
v.fit(corpus)
v.vocabulary_
```

```
{'first': 1, 'document': 0, 'second': 4, 'third': 5, 'one': 3, 'last': 2}
```

- stop_words = 'english' 라고 입력하면 기존에 등록된 불용어 리스트 입력



#### 구문 분석기(analyzer)

```
v = CountVectorizer(analyzer='char') 
v.fit(corpus)
v.vocabulary_
```

```
{'t': 16,
 'h': 8,
 'i': 9,
 's': 15,
 ' ': 0,
 'e': 6,
 'f': 7,
 'r': 14,
 'd': 5,
 'o': 13,
 'c': 4,
 'u': 17,
 'm': 11,
 'n': 12,
 '.': 1,
 'a': 3,
 '?': 2,
 'l': 10}
```



#### 토큰 패턴 만들기 token_pattern

- bow 문서를 만들 때 소문자 t로 시작하는 단어를 추출

```
v = CountVectorizer(token_pattern='t\w+') 
v.fit(corpus)
v.vocabulary_
```

```
{'this': 2, 'the': 0, 'third': 1}
```



#### ngram화 하기 

- 최소 2 최대 2인 ngram을 생성한다.ngram_range = 의미? 최소 n개 최대 m개의 단어들을 묶어서 1개의 단어로 취급하여 bow생성
- 두 단어가 1개의 단어로 사용

```
v = CountVectorizer(ngram_range=(2,2)) 
v.fit(corpus)
v.vocabulary_
```

```
{'this is': 12,
 'is the': 2,
 'the first': 7,
 'first document': 1,
 'the second': 9,
 'second second': 6,
 'second document': 5,
 'and the': 0,
 'the third': 10,
 'third one': 11,
 'is this': 3,
 'this the': 13,
 'the last': 8,
 'last document': 4}
```



#### 문서에서 등장 횟수에 따라 토큰 생성 (min_df(최소), max_df(최대))

```
v = CountVectorizer(min_df = 2,max_df = 4) 
v.fit(corpus)
v.vocabulary_ , v.stop_words_
```

```
({'this': 3, 'is': 2, 'first': 1, 'document': 0},
 {'and', 'last', 'one', 'second', 'the', 'third'})
```



# TF-IDF

DTM에 있는 각 단어들 마다 중요도를 계산 

> dtm 각각의 문서마다 단어가 몇번 등장하였나 -> 각 단어의 중요도가 없다.
>
> dtm을 생성 후, tf-idf를 생성 
>
> tf(d,t) : 문서 d에서 단어 t의 등장 회수 // 단어의 출현 빈도수 
>
> df(t) : 단어 t가 등장한 문서의 개수(여러번 단어가 등장한 경우에도 1로 카운트)
>
> idf(d,t) : dt(t)의 반비례수 
>
> idf(d,t) = log( n / ( 1+df(t) )) : n: 전체 문서의 개수 
>
> log를 취하는 이유
> ex) idf(d,t) = 100만 / 1 = 100만
>     idf(d,t) = 100만 / 100 = 1만
>     idf(d,t) = 100만 / 100만 = 1
>     ==> scale이 굉장히 크다
>    
> idf(d,t) = log(100만 / 1) = 6
>     idf(d,t) = log(100만 / 100) = 4
>     idf(d,t) = log(100만 / 100만) = 0
>     ==> scale이 적당해짐
>    
>     로그를 취하지 않으면 희귀한 단어는 엄청난 가중치를 가져옴 -> 로그가 있어 격차가 사라짐
>     1+df(t) : 1이 있는 이유 ==> 단어가 한 번도 나오지 않는 경우 분모가 0이 될 수 있기 때문에 방지를 위해 +1
>    
>     tf-idf 모든 문서에서 자주 등장하는 단어라면 중요도가 낮다고 판단.
>     특정 문서에서만 등장하는 단어라면 중요도가 높다고 판다.
>    
>     tf - idf 값이 낮으면(높으면) -> 단어의 중요도가 낮다(높다)
>    



```
docs =[
    '먹고 싶은 사과','먹고 싶은 바나나','길고 노란 바나나 바나나','저는 과일이 좋아요'
]
cv = CountVectorizer()
cv.fit(docs)
df = pd.DataFrame(cv.transform(docs).toarray(),columns =sorted(cv.vocabulary_))
df*np.log(len(df) / (1+df.apply(lambda x: x>0).sum()))
```

```
	과일이	길고	노란	먹고	바나나	사과	싶은	저는	좋아요
0	0.000000	0.000000	0.000000	0.287682	0.000000	0.693147	0.287682	0.000000	0.000000
1	0.000000	0.000000	0.000000	0.287682	0.287682	0.000000	0.287682	0.000000	0.000000
2	0.000000	0.693147	0.693147	0.000000	0.575364	0.000000	0.000000	0.000000	0.000000
3	0.693147	0.000000	0.000000	0.000000	0.000000	0.000000	0.000000	0.693147	0.693147
```

