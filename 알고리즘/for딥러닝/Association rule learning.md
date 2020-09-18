# Association rule learning

연관 규칙



**Association rule learning** is a [rule-based machine learning](https://en.wikipedia.org/wiki/Rule-based_machine_learning) method for discovering interesting relations between variables in large databases. It is intended to identify strong rules discovered in databases using some measures of interestingness.

Based on the concept of strong rules, [Rakesh Agrawal](https://en.wikipedia.org/wiki/Rakesh_Agrawal_(computer_scientist)), [Tomasz Imieliński](https://en.wikipedia.org/wiki/Tomasz_Imieliński) and Arun Swami[[2\]](https://en.wikipedia.org/wiki/Association_rule_learning#cite_note-mining-2) introduced association rules for discovering regularities between products in large-scale transaction data recorded by [point-of-sale](https://en.wikipedia.org/wiki/Point-of-sale) (POS) systems in supermarkets. For example, the rule ![\{{\mathrm  {onions,potatoes}}\}\Rightarrow \{{\mathrm  {burger}}\}](https://wikimedia.org/api/rest_v1/media/math/render/svg/2e6daa2c8e553e87e411d6e0ec66ae596c3c9381) found in the sales data of a supermarket would indicate that if a customer buys onions and potatoes together, they are likely to also buy hamburger meat. Such information can be used as the basis for decisions about marketing activities such as, e.g., promotional [pricing](https://en.wikipedia.org/wiki/Pricing) or [product placements](https://en.wikipedia.org/wiki/Product_placement).

In addition to the above example from [market basket analysis](https://en.wikipedia.org/wiki/Market_basket_analysis) association rules are employed today in many application areas including [Web usage mining](https://en.wikipedia.org/wiki/Web_usage_mining), [intrusion detection](https://en.wikipedia.org/wiki/Intrusion_detection), [continuous production](https://en.wikipedia.org/wiki/Continuous_production), and [bioinformatics](https://en.wikipedia.org/wiki/Bioinformatics). In contrast with [sequence mining](https://en.wikipedia.org/wiki/Sequence_mining), association rule learning typically does not consider the order of items either within a transaction or across transactions.



## Definition

Following the original definition by Agrawal, Imieliński, Swami. the problem of association rule mining is defined as:

Let let i ={i1,i2,,,,in} be a set of ![n](https://wikimedia.org/api/rest_v1/media/math/render/svg/a601995d55609f2d9f5e233e36fbe9ea26011b3b) **binary** attributes called *items*.

Let D = {t1,t2,,,,tn} be a set of transactions called the *database*.

Each *transaction* in ![D](https://wikimedia.org/api/rest_v1/media/math/render/svg/f34a0c600395e5d4345287e21fb26efd386990e6) has a unique transaction ID and contains a subset of the items in ![I](https://wikimedia.org/api/rest_v1/media/math/render/svg/535ea7fc4134a31cbe2251d9d3511374bc41be9f).

A *rule* is defined as an implication of the form:

![X\Rightarrow Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/59d16d722c8c8fe129384ebc3687884c0b348eef), where ![X,Y\subseteq I](https://wikimedia.org/api/rest_v1/media/math/render/svg/0f5aabe40ab2b554c2f23eda221556db5868959f).

In Agrawal, Imieliński, Swami a *rule* is defined only between a set and a single item,  X -> i_j for  .

Every rule is composed by two different sets of items, also known as *itemsets*,  and ![Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/961d67d6b454b4df2301ac571808a3538b3a6d3f), where ![X](https://wikimedia.org/api/rest_v1/media/math/render/svg/68baa052181f707c662844a465bfeeb135e82bab) is called *antecedent* or left-hand-side (LHS) and ![Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/961d67d6b454b4df2301ac571808a3538b3a6d3f) consequent or right-hand-side (RHS).

To illustrate the concepts, we use a small example from the supermarket domain. The set of items is ![I=\{{\mathrm  {milk,bread,butter,beer,diapers}}\}](https://wikimedia.org/api/rest_v1/media/math/render/svg/debe2b7bb5feb6413f25afaf2816e4dad7763c96) and in the table is shown a small database containing the items, where, in each entry, the value 1 means the presence of the item in the corresponding transaction, and the value 0 represents the absence of an item in that transaction.

An example rule for the supermarket could be ![\{{\mathrm  {butter,bread}}\}\Rightarrow \{{\mathrm  {milk}}\}](https://wikimedia.org/api/rest_v1/media/math/render/svg/3141048979b977982202dbf7a80596f8a6b1177e) meaning that if butter and bread are bought, customers also buy milk.

Note: this example is extremely small. In practical applications, a rule needs a support of several hundred transactions before it can be considered statistically significant, and datasets often contain thousands or millions of transactions.



## Useful Concepts

In order to select interesting rules from the set of all possible rules, constraints on various measures of significance and interest are used. The best-known constraints are minimum thresholds on support and confidence.

Let ![X,Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/b8705438171d938b7f59cd1bfa5b7d99b6afa5cd) be itemsets, ![X\Rightarrow Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/59d16d722c8c8fe129384ebc3687884c0b348eef) an association rule and ![T](https://wikimedia.org/api/rest_v1/media/math/render/svg/ec7200acd984a1d3a3d7dc455e262fbe54f7f6e0) a set of transactions of a given database.

### Support

Support is an indication of how **frequently** the itemset appears in the dataset.

The support of![X](https://wikimedia.org/api/rest_v1/media/math/render/svg/68baa052181f707c662844a465bfeeb135e82bab) with respect to![T](https://wikimedia.org/api/rest_v1/media/math/render/svg/ec7200acd984a1d3a3d7dc455e262fbe54f7f6e0) is defined as the proportion of transactions ![t](https://wikimedia.org/api/rest_v1/media/math/render/svg/65658b7b223af9e1acc877d848888ecdb4466560) in the dataset which contains the itemset ![X](https://wikimedia.org/api/rest_v1/media/math/render/svg/68baa052181f707c662844a465bfeeb135e82bab).

![{\displaystyle \mathrm {supp} (X)={\frac {|\{t\in T;X\subseteq t\}|}{|T|}}}](https://wikimedia.org/api/rest_v1/media/math/render/svg/1c6acacd3b17051205704b5d323c83fc737e5db1)

In the example dataset, the itemset ![{\displaystyle X=\{\mathrm {beer,diapers} \}}](https://wikimedia.org/api/rest_v1/media/math/render/svg/f4c941b0d077814c5dbfa51c38700d741bebb959) has a support of ![1/5=0.2](https://wikimedia.org/api/rest_v1/media/math/render/svg/0fee425897cc5292ea3b319aeb3b63b2115634c7) since it occurs in 20% of all transactions (1 out of 5 transactions). The argument of ![{\mathrm  {supp}}()](https://wikimedia.org/api/rest_v1/media/math/render/svg/9147d24c9d6cf8ee4f1cf23eb7af2237bd3bb4fe) is a set of preconditions, and thus becomes more restrictive as it grows (instead of more inclusive).



### Confidence

Confidence is an indication of how often the rule has been **found to be true.**

The *confidence* value of a rule, ![X\Rightarrow Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/59d16d722c8c8fe129384ebc3687884c0b348eef) , with respect to a set of transactions ![T](https://wikimedia.org/api/rest_v1/media/math/render/svg/ec7200acd984a1d3a3d7dc455e262fbe54f7f6e0), is the proportion of the transactions that contains ![X](https://wikimedia.org/api/rest_v1/media/math/render/svg/68baa052181f707c662844a465bfeeb135e82bab) which also contains ![Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/961d67d6b454b4df2301ac571808a3538b3a6d3f).

Confidence is defined as:

![{\mathrm  {conf}}(X\Rightarrow Y)={\mathrm  {supp}}(X\cup Y)/{\mathrm  {supp}}(X)](https://wikimedia.org/api/rest_v1/media/math/render/svg/90324dedc399441696116eed3658fd17c5da4329)

For example, the rule ![\{{\mathrm  {butter,bread}}\}\Rightarrow \{{\mathrm  {milk}}\}](https://wikimedia.org/api/rest_v1/media/math/render/svg/3141048979b977982202dbf7a80596f8a6b1177e) has a confidence of ![0.2/0.2=1.0](https://wikimedia.org/api/rest_v1/media/math/render/svg/d176ea6bb6bc037b9b55fa5ac46b0c0240cebd94) in the database, which means that for 100% of the transactions containing butter and bread the rule is correct (100% of the times a customer buys butter and bread, milk is bought as well).

Note that ![{\displaystyle \mathrm {supp} (X\cup Y)}](https://wikimedia.org/api/rest_v1/media/math/render/svg/43b22370df4bcc1c2514f712bbf11de7ed5fc5da) means the support of the union of the items in X and Y. This is somewhat confusing since we normally think in terms of probabilities of [events](https://en.wikipedia.org/wiki/Event_(probability_theory)) and not sets of items. We can rewrite ![{\displaystyle \mathrm {supp} (X\cup Y)}](https://wikimedia.org/api/rest_v1/media/math/render/svg/43b22370df4bcc1c2514f712bbf11de7ed5fc5da) as the probability ![P(E_{X}\cap E_{Y})](https://wikimedia.org/api/rest_v1/media/math/render/svg/4befac89fb56ce378b423348af9e12d467be749f), where  E{X} and E{Y} are the events that a transaction contains itemset [X](https://wikimedia.org/api/rest_v1/media/math/render/svg/68baa052181f707c662844a465bfeeb135e82bab) and [Y](https://wikimedia.org/api/rest_v1/media/math/render/svg/961d67d6b454b4df2301ac571808a3538b3a6d3f), respectively.

Thus confidence can be interpreted as an estimate of the [conditional probability](https://en.wikipedia.org/wiki/Conditional_probability) ![P(E_{Y}|E_{X})](https://wikimedia.org/api/rest_v1/media/math/render/svg/3aae051d1da108c5db58a297bae8cd96d3de675c), the probability of finding the RHS of the rule in transactions under the condition that these transactions also contain the LHS.



### Lift

The *[lift](https://en.wikipedia.org/wiki/Lift_(data_mining))* of a rule is defined as:

![{\mathrm  {lift}}(X\Rightarrow Y)={\frac  {{\mathrm  {supp}}(X\cup Y)}{{\mathrm  {supp}}(X)\times {\mathrm  {supp}}(Y)}}](https://wikimedia.org/api/rest_v1/media/math/render/svg/b6bfa25f817a13d911d1705766a5490d60d4f598)

or the ratio of the observed support to that expected if X and Y were [independent](https://en.wikipedia.org/wiki/Independence_(probability_theory)).

For example, the rule![\{{\mathrm  {milk,bread}}\}\Rightarrow \{{\mathrm  {butter}}\}](https://wikimedia.org/api/rest_v1/media/math/render/svg/31ebb0498a18c22794582ddd8c23e2e6394d6e45) has a lift of ![{\frac  {0.2}{0.4\times 0.4}}=1.25](https://wikimedia.org/api/rest_v1/media/math/render/svg/cc9a265b53d6b8b5328d1a2b9e7cd7742348d14a).

If the rule had a **lift of 1**, it would imply that the probability of occurrence of the antecedent and that of the consequent are **independent** of each other. When two events are independent of each other, no rule can be drawn involving those two events.

If the **lift is > 1, **that lets us know the degree to which **those two occurrences are dependent **on one another, and makes those rules potentially useful for predicting the consequent in future data sets.

If the **lift is < 1**, that lets us know the items are **substitute** to each other. This means that **presence of one item has negative effect** on presence of other item and vice versa.

The value of lift is that it considers both the support of the rule and the overall data set.



### Conviction

The *conviction* of a rule is defined as ![{\mathrm  {conv}}(X\Rightarrow Y)={\frac  {1-{\mathrm  {supp}}(Y)}{1-{\mathrm  {conf}}(X\Rightarrow Y)}}](https://wikimedia.org/api/rest_v1/media/math/render/svg/4c2228820d6a8cb5a84bd059d53764a6b9280386).

For example, the rule ![\{{\mathrm  {milk,bread}}\}\Rightarrow \{{\mathrm  {butter}}\}](https://wikimedia.org/api/rest_v1/media/math/render/svg/31ebb0498a18c22794582ddd8c23e2e6394d6e45) has a conviction of ![\frac{1 - 0.4}{1 - 0.5} = 1.2 ](https://wikimedia.org/api/rest_v1/media/math/render/svg/bff27f4903bd267d0f956a631980450f49cd4d73), and can be interpreted as the ratio of the expected frequency that X occurs without Y (that is to say, the frequency that the rule makes an incorrect prediction) if X and Y were independent divided by the observed frequency of incorrect predictions. In this example, the conviction value of 1.2 shows that the rule ![\{{\mathrm  {milk,bread}}\}\Rightarrow \{{\mathrm  {butter}}\}](https://wikimedia.org/api/rest_v1/media/math/render/svg/31ebb0498a18c22794582ddd8c23e2e6394d6e45) would be incorrect 20% more often (1.2 times as often) if the association between X and Y was purely random chance.





### Alternative measures of interestingness

In addition to confidence, other measures of *interestingness* for rules have been proposed. Some popular measures are:

- All-confidence
- Collective strength
- Leverage

Several more measures are presented and compared by Tan et al. and by Hahsler.Looking for techniques that can model what the user has known (and using these models as interestingness measures) is currently an active research trend under the name of "Subjective Interestingness."



## Process

Association rules are usually required to satisfy a user-specified minimum support and a user-specified minimum confidence at the same time. Association rule generation is usually split up into two separate steps:

1. A minimum support threshold is applied to find all *frequent itemsets* in a database.
2. A minimum confidence constraint is applied to these frequent itemsets in order to form rules.

While the second step is straightforward, the first step needs more attention.

Finding all frequent itemsets in a database is difficult since it involves searching all possible itemsets (item combinations). The set of possible itemsets is the [power set](https://en.wikipedia.org/wiki/Power_set) over ![I](https://wikimedia.org/api/rest_v1/media/math/render/svg/535ea7fc4134a31cbe2251d9d3511374bc41be9f) and has size ![2^{n}-1](https://wikimedia.org/api/rest_v1/media/math/render/svg/51e4bd4ef2f9549d026cbf643a91c0d12a8c6794) (excluding the empty set which is not a valid itemset). Although the size of the power-set grows exponentially in the number of items ![n](https://wikimedia.org/api/rest_v1/media/math/render/svg/a601995d55609f2d9f5e233e36fbe9ea26011b3b) in ![I](https://wikimedia.org/api/rest_v1/media/math/render/svg/535ea7fc4134a31cbe2251d9d3511374bc41be9f), efficient search is possible using the ***downward-closure property*** of support (also called *anti-monotonicity*) which guarantees that for a frequent itemset, all its subsets are also frequent and thus no infrequent itemset can be a subset of a frequent itemset. Exploiting this property, efficient algorithms (e.g., Apriori and Eclat) can find all frequent itemsets.





## Algorithms

Many algorithms for generating association rules have been proposed.

Some well-known algorithms are [Apriori](https://en.wikipedia.org/wiki/Apriori_algorithm), Eclat and FP-Growth, but they only do half the job, since they are algorithms for mining frequent itemsets. Another step needs to be done after to generate rules from frequent itemsets found in a database.



### Apriori algorithm

Main article: [Apriori algorithm](https://en.wikipedia.org/wiki/Apriori_algorithm)

Apriori uses a breadth-first search strategy to count the support of itemsets and uses a candidate generation function which exploits the downward closure property of support.

### Eclat algorithm

Eclat (alt. ECLAT, stands for Equivalence Class Transformation) is a [depth-first search](https://en.wikipedia.org/wiki/Depth-first_search) algorithm based on set intersection. It is suitable for both sequential as well as parallel execution with locality-enhancing properties.

### FP-growth algorithm

FP stands for frequent pattern.

In the first pass, the algorithm counts the occurrences of items (attribute-value pairs) in the dataset of transactions, and stores these counts in a 'header table'. In the second pass, it builds the FP-tree structure by inserting transactions into a [trie](https://en.wikipedia.org/wiki/Trie).

Items in each transaction have to be sorted by descending order of their frequency in the dataset before being inserted so that the tree can be processed quickly. Items in each transaction that do not meet the minimum support requirement are discarded. If many transactions share most frequent items, the FP-tree provides high compression close to tree root.

Recursive processing of this compressed version of the main dataset grows frequent item sets directly, instead of generating candidate items and testing them against the entire database (as in the apriori algorithm).

Growth begins from the bottom of the header table i.e. the item with the smallest support by finding all sorted transactions that end in that item. Call this item ![I](https://wikimedia.org/api/rest_v1/media/math/render/svg/535ea7fc4134a31cbe2251d9d3511374bc41be9f).

A new conditional tree is created which is the original FP-tree projected onto ![I](https://wikimedia.org/api/rest_v1/media/math/render/svg/535ea7fc4134a31cbe2251d9d3511374bc41be9f). The supports of all nodes in the projected tree are re-counted with each node getting the sum of its children counts. Nodes (and hence subtrees) that do not meet the minimum support are pruned. Recursive growth ends when no individual items conditional on ![I](https://wikimedia.org/api/rest_v1/media/math/render/svg/535ea7fc4134a31cbe2251d9d3511374bc41be9f) meet the minimum support threshold. The resulting paths from root to ![I](https://wikimedia.org/api/rest_v1/media/math/render/svg/535ea7fc4134a31cbe2251d9d3511374bc41be9f) will be frequent itemsets. After this step, processing continues with the next least-supported header item of the original FP-tree.

Once the recursive process has completed, all frequent item sets will have been found, and association rule creation begins.

### Others



#### ASSOC

The ASSOC procedure is a GUHA method which mines for generalized association rules using fast [bitstrings](https://en.wikipedia.org/wiki/Bitstring) operations. The association rules mined by this method are more general than those output by apriori, for example "items" can be connected both with conjunction and disjunctions and the relation between antecedent and consequent of the rule is not restricted to setting minimum support and confidence as in apriori: an arbitrary combination of supported interest measures can be used.

#### OPUS search

OPUS is an efficient algorithm for rule discovery that, in contrast to most alternatives, does not require either monotone or anti-monotone constraints such as minimum support. Initially used to find rules for a fixed consequent  it has subsequently been extended to find rules with any item as a consequent. OPUS search is the core technology in the popular Magnum Opus association discovery system.



< 출처 : 위키피디아 >

------------------------



# 연관 규칙 ( 비지도 학습 )

규칙? (rule) : if 조건식 then 결과 

연관 규칙 : 특정 사건 발생 -> 함께 발생하는 또 다른 사건 간의 규칙

항목 집합( item set ) : 전체 항목 집합으로부터 만들어 질 수 있는 모든 각각의 부분 집합

x = { a,b,c } => 2^3

x의 부분집합?

공집합  a, b, c, ab, bc, ca, abc 

....

이마트 : item이 1만가지 => 이마트 전체 상품 = {a1, a2, a3 ,,,,, a10000} => 2^10000

====> 돈 워리 ==> 연관 규칙( aprori ) => pruning ( prune : 가지치기 )

연관 규칙 ? 특정 항목 집합이 발생했을 때 또 다른 항목 집합이 발생하는 규칙

연관 규칙의 예 : {채소} -> { 마요네즈 }, { 채소, 음료 } -> { 마요네즈 },,,,, { 채소 } -> { 시럽, 식초 }



의미 있는 연관 규칙을 발견 -> 기존 ( support(지지도), confidence(신뢰도), lift(향상도) )에 부합되는 연관 규칙을 필터링

=> 특히 향상도가 중요함



X, Y : 공통 원소가 없는 항목 집합

ex) x -> y : {건전지} -> {컵라면}

x -> y : if x then y 라는 연관 규칙

N : 전체 거래 건수

n(x) : 항목 집합 x의 거래 건수

n(y) : 항목 집합 y의 거래 건수



1) 지지도? 

두 항목 집합 x와 y의 지지도? 전체 거래 건수 중에서 항목 집합 x와 y를 모두 포함하는 거래건수의 비율

s( x-> y ) : x와 y를 모두 포함하는 거래 건수 / 전체 거래 건수



2) 신뢰도?

항목 집합 x를 포함하는 거래( n(x) ) 중에서, 항목 집합 y를 포함하고 있는 거래의 비율 ( 조건부 확률 )

c( x-> y ) : x와 y를 모두 포함하는 거래 건수 / 항목 집합 x가 포함된 거래 건수



3) 향상도?

항목 집합 x가 주어지지 않았을 때의 항목집합 y의 확률 대비

항목 집합 x가 주어졌을 때의 항목 집합 y의 확률 증가 비율

=> 향상도가 1보다 크거나 (+관계) 작다면(-관계) 우연적 기회보다 우수함을 의미, (x와 y가 서로 독립이면 lift = 1)

Lift ( x-> y) : 신뢰도 / 지지도 = c ( x-> y ) / s(y)







