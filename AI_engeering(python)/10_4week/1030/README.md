# 1030

## 자연어 처리

### TF-IDF

> 문장에서 각 단어의 중요도를 알고 싶을 때

#### 라이브러리 + 함수

- from **sklearn.feature_extraction.text** import TfidfVectorizer

```
from sklearn.feature_extraction.text import TfidfVectorizer
tv = TfidfVectorizer()
tfidf = tv.fit(corpus)
tfidf.transform(corpus).toarray()
```

- 2차원 행렬 형태로 tf-idf 출력

```
array([[0.        , 0.46735098, 0.        , 0.46735098, 0.        ,
        0.46735098, 0.        , 0.35543247, 0.46735098],
       [0.        , 0.        , 0.79596054, 0.        , 0.        ,
        0.        , 0.        , 0.60534851, 0.        ],
       [0.57735027, 0.        , 0.        , 0.        , 0.57735027,
        0.        , 0.57735027, 0.        , 0.        ]])
```

- 각 열은 단어, 행은 문서 순서이다. (딕셔너리 형태로 출력 : value값이 순서이다.)

```
tfidf.vocabulary_
```

```
{'you': 7,
 'know': 1,
 'want': 5,
 'your': 8,
 'love': 3,
 'like': 2,
 'what': 6,
 'should': 4,
 'do': 0}
```



- 옵션 
  -  min_df : 문서에서 단어의 등장 횟수를 최소 n회 이상으로 제한
  - ngram_range : 단어 토큰을 ngram으로 구현할 수 있다. 범위



### 단어 유사도

> 유클리디안, 자카드, 코사인유사도

#### 자카드 유사도 알고리즘

> 교집합 : 두 집합에서 공통으로 가지고 있는 원소 집합
>
> 합집합 : 두 집합이 가지고 있는 원소 집합
>
> 동작 방식 : 합집합에서 교집합의 비율을 구하자
>
> -> 두 문서의 유사도 측정
>
> 한계점 : 단어의 순서를 고려하지 못한다. 유사 단어 처리하지 못했다.
>
> ​	단순한 문장 2개 정도는 비교 가능하지만 문장이 많은 문단 자체를 사용하기 어려워 보인다.
>
> 
>
> 

```
doc1 = "apple banana everyone like likey watch card holder"
doc2 = "apple banana coupon passport love you"
tok1 = doc1.split()
tok2 = doc2.split()
union = set(tok1).union(tok2)
intersection = set(tok1).intersection(tok2)
print(len(intersection)/len(union))
```

```
0.16666666666666666
```



