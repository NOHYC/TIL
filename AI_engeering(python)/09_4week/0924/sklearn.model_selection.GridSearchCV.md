과적합

의사결정트리 : 오버 피팅 -> 가지치기 ==> 부족한 알고리즘

랜덤포레스트 : 의사결정 트리의 한계를 극복하기 위한 알고리즘

나무생성? 배깅

ex) 학습데이터 1000개(행) 25개(속성) -> 임의로 100개의 데이터 선택 (31번 반복) => 트리

-> 트리 작성 시 사용될 피처(feature) 들을 제한 -> 나무에 다한 다양성

=> 속성 몇개? '전체 속성 개수 (25개)의 제곱근이 가장 좋다' -> 5개를 속성개수로 사용





AI : 1940년대 ~ (튜링머신)



신경망





**sklearn.ensemble.RandomForestClassifier**

**중요 옵션**

n_estumators : 트리의 개수(기본 100) 크게 할 수록 좋음 (시간은 오래걸림)

min_samples_split : 노드를 분할하기 위한 최소한의 데이터 수 (과적합을 제어), 작게 설정할 수록

분할 노드가 많아지므로 과적합이 증가할 수 있음

max_depth : 트리의 최대 깊이 (기본 : None 완전하게 클래스 값이 결정될 때까지 분할 )

또는 데이터 개수가 min_samples_split보다 작아질때까지 분할

min_samples_leaf : 리프노드(터미널 노드)가 되기 위해 필요로하는 최소한의 샘플데이터수,

일반적으로 작게 설정

=> 최적의 랜덤포레스트 파라미터를 설정하는게 중요!!! (과거(현재)에는 수동)

-> **GridSearchCV**를 사용해서 랜덤포레스트 하이퍼 파라미터를 튜닝

# sklearn.model_selection.GridSearchCV

Exhaustive search over specified parameter values for an estimator.







# sklearn.ensemble.RandomForestClassifier



- **n_estimators***int, default=100*

The number of trees in the forest.

나무의 개수



- **criterion***{“gini”, “entropy”}, default=”gini”*

The function to measure the quality of a split. Supported criteria are “gini” for the Gini impurity and “entropy” for the information gain. Note: this parameter is tree-specific.



- **max_depth***int, default=None*

The maximum depth of the tree. If None, then nodes are expanded until all leaves are pure or until all leaves contain less than min_samples_split samples.

오버 피팅 가능성



- **min_samples_split***int or float, default=2*

  The minimum number of samples required to split an internal node:

  - If int, then consider `min_samples_split` as the minimum number.
  - If float, then `min_samples_split` is a fraction and `ceil(min_samples_split * n_samples)` are the minimum number of samples for each split.

  이 값이 커지면 오버피팅 가능성 높

- **min_samples_leaf***int or float, default=1*

  The minimum number of samples required to be at a leaf node. A split point at any depth will only be considered if it leaves at least `min_samples_leaf` training samples in each of the left and right branches. This may have the effect of smoothing the model, especially in regression.

  - If int, then consider `min_samples_leaf` as the minimum number.
  - If float, then `min_samples_leaf` is a fraction and `ceil(min_samples_leaf * n_samples)` are the minimum number of samples for each node.





## 교차 검증

https://www.researchgate.net/figure/k-fold-cross-validation-scheme-example_fig2_228403467

모델의 일반화 성능을 측정하기 위해

데이터를 여러 겹(fold)으로 나누고 트레이닝, 테스트용 으로 나누어진 폴드를 다양하게 적용하여 모델을 학습하고 평가

100건 데이터, 4겹 (fold, 1겹당 25건 데이터)

첫번째 fold(테스트용 25건) , 두번째 ~ 네번째 fold (트레이닝용 25*3 = 75건) : 정확도

두번째 fold(테스트용 25건) , 첫번째 세~ 네번째 fold (트레이닝용 25*3 = 75건) : 정확도

세번째 fold(테스트용 25건) , 첫번째 ~ 두번째, 네번째 fold (트레이닝용 25*3 = 75건) : 정확도

네번째 fold(테스트용 25건) , 첫번째 ~ 세번째 fold (트레이닝용 25*3 = 75건) : 정확도

정확도의 평균(최종 모델 정확도)