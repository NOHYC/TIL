# 1027

## 자연어 처리

 ### word 토큰화

> 3 가지 함수가 단어를 토큰화하는 방법이 다르기 때문에 문장에 맞는 적절한 함수를 선택해야 함
>
> 토큰화된 단어들은 리스트 안에 문자열 형태로 저장된다.

#### 라이브러리 + 함수

- from **nltk.tokenize** import **word_tokenize**
  - word_tokenize('string')

```
['Do', "n't", 'After', 'preventing', 'President', 'Obama', "'s", 'from', 'filling', 'a', 'vacancy', 'four', 'years', 'ago', ',', 'Republicans', 'moved', 'swiftly', 'to', 'deliver', 'President', 'Trump', 'a', 'victory', 'days', 'before', 'the', 'election', '.', 'Both', 'presidential', 'candidates', 'campaigned', 'in', 'Pennsylvania', ',', 'where', 'Joe', 'Biden', 'said', 'he', 'would', 'expand', 'his', 'electoral', 'map', 'and', 'Mr.', 'Trump', 'mocked', 'Kamala', 'Harris', '.']
```



- from **nltk.tokenize** import **WordPunctTokenizer**
  - WordPunctTokenizer.tokenize('string')

```
['Don', "'", 't', 'After', 'preventing', 'President', 'Obama', "'", 's', 'from', 'filling', 'a', 'vacancy', 'four', 'years', 'ago', ',', 'Republicans', 'moved', 'swiftly', 'to', 'deliver', 'President', 'Trump', 'a', 'victory', 'days', 'before', 'the', 'election', '.', 'Both', 'presidential', 'candidates', 'campaigned', 'in', 'Pennsylvania', ',', 'where', 'Joe', 'Biden', 'said', 'he', 'would', 'expand', 'his', 'electoral', 'map', 'and', 'Mr', '.', 'Trump', 'mocked', 'Kamala', 'Harris', '.']
```



- from **tensorflow.keras.preprocessing.text** import **text_to_word_sequence**
  - text_to_word_sequences('string')

```
["don't", 'after', 'preventing', 'president', "obama's", 'from', 'filling', 'a', 'vacancy', 'four', 'years', 'ago', 'republicans', 'moved', 'swiftly', 'to', 'deliver', 'president', 'trump', 'a', 'victory', 'days', 'before', 'the', 'election', 'both', 'presidential', 'candidates', 'campaigned', 'in', 'pennsylvania', 'where', 'joe', 'biden', 'said', 'he', 'would', 'expand', 'his', 'electoral', 'map', 'and', 'mr', 'trump', 'mocked', 'kamala', 'harris']
```



### sentence 토큰화

#### 라이브러리 + 함수

- from **nltk.tokenize** import **sent_tokenize**
  - sent_tokenize('text')

```

["Don't After preventing Ph.D. Obama's from filling a vacancy four years ago.", 'Republicans moved swiftly to deliver President Trump a victory days before the election.', 'Both presidential candidates campaigned in Pennsylvania, where Joe Biden said he would expand his electoral map and Mr. Trump mocked Kamala Harris.']
```



### word tag 

> 토큰화된 단어들의 품사를 분류해준다. 
>
> 태그의 의미는 https://www.nltk.org/book/ch05.html

#### 라이브러리 + 함수

- from **nltk.tag** import **pos_tag**
  - pos_tag(**토큰화된 word 리스트**)

```
[('After', 'IN'),
 ('preventing', 'VBG'),
 ('Ph.D.', 'NNP'),
 ('Obama', 'NNP'),
 ("'s", 'POS'),
 ('from', 'IN'),
 ('filling', 'VBG'),
 ('a', 'DT'),
 ('vacancy', 'NN'),
 ('four', 'CD'),
 ('years', 'NNS'),
 ('ago', 'RB'),
 ('.', '.')]
```





> **한국어 형태소** 분석기 형태소 단위로 토큰화한다. 
>
> 형태소 단위로 품사 정보도 출력

- from **konlpy.tag** import **Okt**
  - okt = Okt()
  - okt.morphs('문장문장') 
    - 형태소 단위로 출력

```
['열심히', '공부', '하고', '있는', '우리', '들', '.', '수료', '후', '에는', '취업', '에', '꼭', '성공해요']
```



- okt.pos('문장문장')
  - 형태소 단위로 품사 정보 출력

```
[('열심히', 'Adverb'), ('공부', 'Noun'), ('하고', 'Josa'), ('있는', 'Adjective'), ('우리', 'Noun'), ('들', 'Suffix'), ('.', 'Punctuation'), ('수료', 'Noun'), ('후', 'Noun'), ('에는', 'Josa'), ('취업', 'Noun'), ('에', 'Josa'), ('꼭', 'Noun'), ('성공해요', 'Adjective')]
```



- okt.nouns('문장문장')
  - 명사만 추출

```
['공부', '우리', '수료', '후', '취업', '꼭']
```



- from **konlpy.tag** import Kkma
  - km = Kkma()
  - km.nouns('문장문장')
    - 형태소 단위로 품사 출력

```
['공부', '우리', '수료', '후', '취업', '성공']
```



### 표제어 추출

#### 라이브러리 + 함수

- from **nltk.stem** import **WordNetLemmatizer**
  - wnl = WordNetLemmatizer()
  - wnl.lemmatize('단어','품사') # 품사 : v, n, a...
    - 표제어 추출 

```
['live', 'go', 'do', 'love']
```





### 어간추출

#### 라이브러리 + 함수

- from **nltk.stem** import **PorterStemmer,LancasterStemmer**
- ps = PorterStemmer()
- ls = LancasterStemmer()
- ps.stem('단어')
  - 어간 추출

```
['after', 'prevent', 'presid', 'obama', "'s", 'from', 'fill', 'a', 'vacanc', 'four', 'year', 'ago', ',', 'republican', 'move', 'swiftli', 'to', 'deliv', 'presid', 'trump', 'a', 'victori', 'day', 'befor', 'the', 'elect', '.', 'both', 'presidenti', 'candid', 'campaign', 'in', 'pennsylvania', ',', 'where', 'joe', 'biden', 'said', 'he', 'would', 'expand', 'hi', 'elector', 'map', 'and', 'mr.', 'trump', 'mock', 'kamala', 'harri', '.']
```



- ls.stem('단어')
  - 어간추출

```
['aft', 'prev', 'presid', 'obam', "'s", 'from', 'fil', 'a', 'vac', 'four', 'year', 'ago', ',', 'republ', 'mov', 'swift', 'to', 'del', 'presid', 'trump', 'a', 'vict', 'day', 'bef', 'the', 'elect', '.', 'both', 'presid', 'candid', 'campaign', 'in', 'pennsylvan', ',', 'wher', 'joe', 'bid', 'said', 'he', 'would', 'expand', 'his', 'elect', 'map', 'and', 'mr.', 'trump', 'mock', 'kamal', 'har', '.']
```



### 불용어 

#### 라이브러리 + 함수

- from **nltk.corpus** import stopwords
- stopwords.words('english')

```
['i',
 'me',
 'my',
 'myself',
 'we',
 'our',
 'ours',
 'ourselves',
 'you',
 "you're",
 ...
  'wasn',
 "wasn't",
 'weren',
 "weren't",
 'won',
 "won't",
 'wouldn',
 "wouldn't"]
```



#### 한국어 불용어 사전

- https://www.ranks.nl/stopwords/korean



불용어 처리나 같은 의미 단어 변경 -> **정규표현식**

#### 라이브러리 + 함수

- import re
- re.findall('정규표현식','문장') : 정규 표현식 조건에 맞는 단어 출력 
- re.sub('이 단어를','요 단어로',' 문장') : 문장내에 이 단어를 요단어로 바꾼다



## 코퍼스 ( 말뭉치 )

### corpus

#### 라이브러리 + 함수

- from **tensorflow.keras.preprocessing.text** import **Tokenizer**
- tokenizer = Tokenizer() ## 옵션으로 num_words = num+1 를 넣어주면 빈도수가 높은 num 개 단어만 추출
- tokenizer.fit_on_texts(' 문장 ')

> 코퍼스에 등장하는 단어들에 대한 빈도수를 기준으로 단어 집합 생성
>
> 빈도수가 높은 ~ 낮은 단어 순으로 번호를 부여. 
>
> 확인 방법은 word_index

- tokenizer.word_index # 단어 인덱스 ( 빈도순 )

```
{'barber': 1,
 'secret': 2,
 'huge': 3,
 'kept': 4,
 'person': 5,
 'word': 6,
 'keeping': 7,
 'good': 8,
 'knew': 9,
 'driving': 10,
 'crazy': 11,
 'went': 12,
 'mountain': 13}
```

- tokenizer.word_counts : # 단어 빈도수 

```
OrderedDict([('barber', 8),
             ('person', 3),
             ('good', 1),
             ('huge', 5),
             ('knew', 1),
             ('secret', 6),
             ('kept', 4),
             ('word', 2),
             ('keeping', 2),
             ('driving', 1),
             ('crazy', 1),
             ('went', 1),
             ('mountain', 1)])
```

- tokenizer.text_to_sequencese( 문장 ) # 각 토큰화되어 있는 문장을 인덱스화해준다.

```
[[1, 5],
 [1, 8, 5],
 [1, 3, 5],
 [9, 2],
 [2, 4, 3, 2],
 [3, 2],
 [1, 4, 6],
 [1, 4, 6],
 [1, 4, 2],
 [7, 7, 3, 2, 10, 1, 11],
 [1, 12, 3, 13]]
```



