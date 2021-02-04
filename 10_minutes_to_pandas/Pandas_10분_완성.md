---
title: "Pandas 10분 완성(10 Minutes to Pandas)"
author: "ne-choi"
date: '2020-11-10'
tags:
  - "10 Minutes to Pandas"
  - "python"
  - "pandas"
  - "numpy"
  - "matplotlib"
categories:
  - Study
  - Python
output:
  html_document:
   toc: true
   toc_float:
     collapsed: false
     smooth_scroll: true
   theme: united
   highlight: textmate 
---

# **Pandas 10분 완성(10 Minutes to Pandas) 필사**
- 본 자료의 저작권은 [BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause)에 있으며, [데잇걸즈2가 번역한 Pandas 10분 완성](https://dataitgirls2.github.io/10minutes2pandas/)을 필사한 자료입니다.  

**목차**
1. Object Creation (객체 생성)  
2. Viewing Data (데이터 확인하기)  
3. Selection (선택)  
4. Missing Data (결측치)  
5. Operation (연산)  
6. Merge (병합)
7. Grouping (그룹화)
8. Reshaping (변형)
9. Time Series (시계열)
10. Categoricals (범주화)
11. Plotting (그래프)
12. Getting Data In / Out (데이터 입 / 출력)
13. Gotchas (잡았다!)



```python
# 패키지 불러오기

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
```

## **1. Object Creation**
[- 참고: 데이터 구조 소개 섹션](https://pandas.pydata.org/pandas-docs/stable/user_guide/dsintro.html)

Pansdas는 값을 가지고 있는 리스트를 통해 [Series](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Series.html)를 만들고, 정수로 만들어진 인덱스를 기본값으로 불러온다.


```python
s = pd.Series([1, 3, 5, np.nan, 6, 8])
s
```




    0    1.0
    1    3.0
    2    5.0
    3    NaN
    4    6.0
    5    8.0
    dtype: float64



datetime 인덱스와 레이블이 있는 열을 가진 numpy 배열을 전달하여 데이터프레임을 만든다.


```python
dates = pd.date_range('20130101', periods = 6)
dates
```




    DatetimeIndex(['2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04',
                   '2013-01-05', '2013-01-06'],
                  dtype='datetime64[ns]', freq='D')




```python
df = pd.DataFrame(np.random.randn(6, 4), index = dates, columns = list('ABCD'))
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>-1.612642</td>
      <td>-0.202385</td>
      <td>1.369361</td>
      <td>0.354048</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>-0.740531</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>1.043707</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.021870</td>
      <td>-1.980740</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>-0.582027</td>
      <td>1.053088</td>
      <td>0.574172</td>
    </tr>
  </tbody>
</table>
</div>



Series와 같은 것으로 변환될 수 있는 객체들의 dict로 구성된 데이터프레임을 만든다.


```python
df2 = pd.DataFrame({'A': 1.,
                    'B': pd.Timestamp('20130102'),
                    'C': pd.Series(1, index = list(range(4)), dtype = 'float32'),
                    'D': np.array([3] * 4, dtype = 'int32'),
                    'E': pd.Categorical(["test", "train", "test", "train"]),
                    'F': 'foo'})
df2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>E</th>
      <th>F</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.0</td>
      <td>2013-01-02</td>
      <td>1.0</td>
      <td>3</td>
      <td>test</td>
      <td>foo</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1.0</td>
      <td>2013-01-02</td>
      <td>1.0</td>
      <td>3</td>
      <td>train</td>
      <td>foo</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1.0</td>
      <td>2013-01-02</td>
      <td>1.0</td>
      <td>3</td>
      <td>test</td>
      <td>foo</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1.0</td>
      <td>2013-01-02</td>
      <td>1.0</td>
      <td>3</td>
      <td>train</td>
      <td>foo</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2.dtypes
```




    A           float64
    B    datetime64[ns]
    C           float32
    D             int32
    E          category
    F            object
    dtype: object



## **2. Viewing Data**
[- 참고: Basic Section](https://pandas.pydata.org/pandas-docs/stable/user_guide/basics.html)  

데이터프레임의 가장 윗줄과 마지막 줄을 확인하고 싶을 때 사용하는 방법 알아보기.


```python
# 괄호() 안에 숫자를 넣으면 (숫자)줄을 불러오고 넣지 않으면 기본값인 5개를 불러옴

df.tail(3)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>1.043707</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.021870</td>
      <td>-1.980740</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>-0.582027</td>
      <td>1.053088</td>
      <td>0.574172</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>-1.612642</td>
      <td>-0.202385</td>
      <td>1.369361</td>
      <td>0.354048</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>-0.740531</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>1.043707</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.021870</td>
      <td>-1.980740</td>
    </tr>
  </tbody>
</table>
</div>



index, column, numpy 데이터 세부 정보를 알아보자.


```python
df.index
```




    DatetimeIndex(['2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04',
                   '2013-01-05', '2013-01-06'],
                  dtype='datetime64[ns]', freq='D')




```python
df.columns
```




    Index(['A', 'B', 'C', 'D'], dtype='object')




```python
df.values
```




    array([[-1.61264215, -0.2023848 ,  1.36936106,  0.35404822],
           [-0.41459705,  0.74983681,  0.09588737, -0.74053093],
           [ 0.60731344,  0.78256437,  0.14000027,  0.89485905],
           [-0.74814932,  0.41736876,  0.82389876,  1.04370685],
           [-0.42049172, -0.17500487, -0.02187012, -1.98074049],
           [ 1.49444451, -0.58202719,  1.0530883 ,  0.57417186]])




```python
df.describe() # 데이터의 대략적인 통계적 정보 요약을 보여줌
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>6.000000</td>
      <td>6.000000</td>
      <td>6.000000</td>
      <td>6.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>-0.182354</td>
      <td>0.165059</td>
      <td>0.576728</td>
      <td>0.024252</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1.087357</td>
      <td>0.564931</td>
      <td>0.582501</td>
      <td>1.167331</td>
    </tr>
    <tr>
      <th>min</th>
      <td>-1.612642</td>
      <td>-0.582027</td>
      <td>-0.021870</td>
      <td>-1.980740</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>-0.666235</td>
      <td>-0.195540</td>
      <td>0.106916</td>
      <td>-0.466886</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>-0.417544</td>
      <td>0.121182</td>
      <td>0.481950</td>
      <td>0.464110</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>0.351836</td>
      <td>0.666720</td>
      <td>0.995791</td>
      <td>0.814687</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.494445</td>
      <td>0.782564</td>
      <td>1.369361</td>
      <td>1.043707</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.T # 데이터 전치
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>2013-01-01</th>
      <th>2013-01-02</th>
      <th>2013-01-03</th>
      <th>2013-01-04</th>
      <th>2013-01-05</th>
      <th>2013-01-06</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>A</th>
      <td>-1.612642</td>
      <td>-0.414597</td>
      <td>0.607313</td>
      <td>-0.748149</td>
      <td>-0.420492</td>
      <td>1.494445</td>
    </tr>
    <tr>
      <th>B</th>
      <td>-0.202385</td>
      <td>0.749837</td>
      <td>0.782564</td>
      <td>0.417369</td>
      <td>-0.175005</td>
      <td>-0.582027</td>
    </tr>
    <tr>
      <th>C</th>
      <td>1.369361</td>
      <td>0.095887</td>
      <td>0.140000</td>
      <td>0.823899</td>
      <td>-0.021870</td>
      <td>1.053088</td>
    </tr>
    <tr>
      <th>D</th>
      <td>0.354048</td>
      <td>-0.740531</td>
      <td>0.894859</td>
      <td>1.043707</td>
      <td>-1.980740</td>
      <td>0.574172</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.sort_index(axis = 1, ascending = False) # 축별로 정리
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>D</th>
      <th>C</th>
      <th>B</th>
      <th>A</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>0.354048</td>
      <td>1.369361</td>
      <td>-0.202385</td>
      <td>-1.612642</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.740531</td>
      <td>0.095887</td>
      <td>0.749837</td>
      <td>-0.414597</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.894859</td>
      <td>0.140000</td>
      <td>0.782564</td>
      <td>0.607313</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>1.043707</td>
      <td>0.823899</td>
      <td>0.417369</td>
      <td>-0.748149</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-1.980740</td>
      <td>-0.021870</td>
      <td>-0.175005</td>
      <td>-0.420492</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>0.574172</td>
      <td>1.053088</td>
      <td>-0.582027</td>
      <td>1.494445</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.sort_values(by = 'B') # 값별로 정렬
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>-0.582027</td>
      <td>1.053088</td>
      <td>0.574172</td>
    </tr>
    <tr>
      <th>2013-01-01</th>
      <td>-1.612642</td>
      <td>-0.202385</td>
      <td>1.369361</td>
      <td>0.354048</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.021870</td>
      <td>-1.980740</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>1.043707</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>-0.740531</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
  </tbody>
</table>
</div>



## **3. Selection**  
* 주석: Pandas에 최적화된 데이터 접근 방법인 .at, .iat, .loc, .iloc 사용  

[- 참고: 데이터 인덱싱 및 선택](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html), [다중 인덱싱/심화 인덱싱](https://pandas.pydata.org/pandas-docs/stable/user_guide/advanced.html)

### **- Getting(데이터 얻기)**  
df.A와 동일한 Series를 생성하는 단일 열을 선택한다.


```python
df['A']
```




    2013-01-01   -1.612642
    2013-01-02   -0.414597
    2013-01-03    0.607313
    2013-01-04   -0.748149
    2013-01-05   -0.420492
    2013-01-06    1.494445
    Freq: D, Name: A, dtype: float64




```python
df[0:3]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>-1.612642</td>
      <td>-0.202385</td>
      <td>1.369361</td>
      <td>0.354048</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>-0.740531</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
  </tbody>
</table>
</div>




```python
df['20130102':'20130104']
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>-0.740531</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>1.043707</td>
    </tr>
  </tbody>
</table>
</div>



### **- Selection by Label**  
[- 참고: Label을 통한 선택](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html)


```python
# 라벨을 사용하여 횡단면 얻기
df.loc[dates[0]]
```




    A   -1.612642
    B   -0.202385
    C    1.369361
    D    0.354048
    Name: 2013-01-01 00:00:00, dtype: float64




```python
# 라벨을 사용하여 여러 축(의 데이터) 얻기
df.loc[:, ['A', 'B']]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>-1.612642</td>
      <td>-0.202385</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>-0.582027</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 양쪽 종단점을 포함한 라벨 슬라이싱 보기
df.loc['20130102':'20130104', ['A', 'B']]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 반환되는 객체의 차원 줄이기
df.loc['20130102', ['A', 'B']]
```




    A   -0.414597
    B    0.749837
    Name: 2013-01-02 00:00:00, dtype: float64




```python
# 스킬라 값 얻기
df.loc[dates[0], 'A']
```




    -1.6126421545697252




```python
# cf. 스킬라 값 더 빠르게 구하는 법
df.at[dates[0], 'A']
```




    -1.6126421545697252



### **- Selection by Position**  
[- 참고: 위치로 선택하기](https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html)


```python
# 넘겨 받은 정수 위치를 기준으로 선택
df.iloc[3]
```




    A   -0.748149
    B    0.417369
    C    0.823899
    D    1.043707
    Name: 2013-01-04 00:00:00, dtype: float64




```python
# 정수로 표기된 슬라이스를 통해, numpy / python과 유사하게 작동
df.iloc[3:5, 0:2]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 정수로 표기된 위치값 리스트를 통해, numpy / python 스타일과 유사해짐
df.iloc[[1, 2, 4], [0, 2]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>C</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.095887</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.140000</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.021870</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 명시적으로 행을 나누고자 하는 경우
df.iloc[1:3, :]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>-0.740531</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 명시적으로 열을 나누고자 하는 경우
df.iloc[:, 1:3]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>B</th>
      <th>C</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>-0.202385</td>
      <td>1.369361</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>0.749837</td>
      <td>0.095887</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.782564</td>
      <td>0.140000</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>0.417369</td>
      <td>0.823899</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.175005</td>
      <td>-0.021870</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>-0.582027</td>
      <td>1.053088</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 명시적으로 (특정한) 값을 얻고자 하는 경우
df.iloc[1, 1]
```




    0.7498368136559216




```python
# 스칼라 값을 빠르게 얻는 방법
df.iat[1, 1]
```




    0.7498368136559216



### **- Boolean Indexing**
데이터를 선택하기 위해 단일 열 값을 사용한다.  


```python
df[df.A > 0]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>-0.582027</td>
      <td>1.053088</td>
      <td>0.574172</td>
    </tr>
  </tbody>
</table>
</div>




```python
# Boolean 조건을 충족하는 데이터프레임에서 값 선택
df[df > 0]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>1.369361</td>
      <td>0.354048</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>NaN</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>NaN</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>1.043707</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>NaN</td>
      <td>1.053088</td>
      <td>0.574172</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 필터링을 위한 메소드 isin()을 사용
df2 = df.copy()
df2['E'] = ['one', 'one', 'two', 'three', 'four', 'three']
df2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>-1.612642</td>
      <td>-0.202385</td>
      <td>1.369361</td>
      <td>0.354048</td>
      <td>one</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>-0.740531</td>
      <td>one</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>0.894859</td>
      <td>two</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>1.043707</td>
      <td>three</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.021870</td>
      <td>-1.980740</td>
      <td>four</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>-0.582027</td>
      <td>1.053088</td>
      <td>0.574172</td>
      <td>three</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2[df2['E'].isin(['two', 'four'])]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.14000</td>
      <td>0.894859</td>
      <td>two</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.02187</td>
      <td>-1.980740</td>
      <td>four</td>
    </tr>
  </tbody>
</table>
</div>



### **- Setting**
새 열을 설정하면 데이터가 인덱스별로 자동정렬 된다.


```python
s1 = pd.Series([1, 2, 3, 4, 5, 6], index = pd.date_range('20130102', periods=6))
s1
```




    2013-01-02    1
    2013-01-03    2
    2013-01-04    3
    2013-01-05    4
    2013-01-06    5
    2013-01-07    6
    Freq: D, dtype: int64




```python
df['F'] = s1
```


```python
# 라벨에 의해 값 설정
df.at[dates[0], 'A'] = 0
```


```python
# 위치에 의해 값 설정
df.iat[0, 1] = 0
```


```python
# Numpy 배열을 사용한 할당에 의해 값 설정
df.loc[:, 'D'] = np.array([5] * len(df))
```


```python
# 위 설정대로 작동한 결과
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>1.369361</td>
      <td>5</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>5</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>5</td>
      <td>2.0</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>5</td>
      <td>3.0</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.021870</td>
      <td>5</td>
      <td>4.0</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>1.494445</td>
      <td>-0.582027</td>
      <td>1.053088</td>
      <td>5</td>
      <td>5.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# where 연산 설정
df2 = df.copy()
df2[df2 > 0] = -df2
df2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>-1.369361</td>
      <td>-5</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>-0.749837</td>
      <td>-0.095887</td>
      <td>-5</td>
      <td>-1.0</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>-0.607313</td>
      <td>-0.782564</td>
      <td>-0.140000</td>
      <td>-5</td>
      <td>-2.0</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>-0.417369</td>
      <td>-0.823899</td>
      <td>-5</td>
      <td>-3.0</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.420492</td>
      <td>-0.175005</td>
      <td>-0.021870</td>
      <td>-5</td>
      <td>-4.0</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>-1.494445</td>
      <td>-0.582027</td>
      <td>-1.053088</td>
      <td>-5</td>
      <td>-5.0</td>
    </tr>
  </tbody>
</table>
</div>



## **4. Missing Data**
Pandas는 결측치를 표현하기 위해, 주로 np.nan 값을 사용한다. (기본 설정값이나 계산에는 포함되지 않음)  
[- 참고: Missing data section](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html)  

Reindexing으로 지정된 축 상의 인덱스를 변경/추가/삭제할 수 있다. Reindexing은 데이터의 복사본을 반환한다.


```python
df1 = df.reindex(index = dates[0:4], columns = list(df.columns) + ['E'])
df1.loc[dates[0]:dates[1], 'E'] = 1
df1
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
      <th>E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>1.369361</td>
      <td>5</td>
      <td>NaN</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>5</td>
      <td>1.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>5</td>
      <td>2.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>5</td>
      <td>3.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 결측치를 가지고 있는 행 지우기
df1.dropna(how = 'any')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
      <th>E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>5</td>
      <td>1.0</td>
      <td>1.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 결측치 채워 넣기
df1.fillna(value = 5)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
      <th>E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>1.369361</td>
      <td>5</td>
      <td>5.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>0.095887</td>
      <td>5</td>
      <td>1.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.607313</td>
      <td>0.782564</td>
      <td>0.140000</td>
      <td>5</td>
      <td>2.0</td>
      <td>5.0</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.748149</td>
      <td>0.417369</td>
      <td>0.823899</td>
      <td>5</td>
      <td>3.0</td>
      <td>5.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
# NAN 값에 boolean을 통한 표식
pd.isna(df1) # 데이터프레임의 모든 값이 boolean 형태로 표시되게 하며, nan인 값만 True가 표시되게 하는 함수
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
      <th>E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>False</td>
      <td>True</td>
    </tr>
  </tbody>
</table>
</div>



## **5. Operation (연산)**
[- 참고: 이진(Binary) 연산의 기본 섹션](https://pandas.pydata.org/pandas-docs/stable/user_guide/basics.html)  

### **- Stats**
통계: 일반적으로 결측치를 제외한 후 연산된다.


```python
# 기술통계 수행
df.mean()
```




    A    0.086420
    B    0.198790
    C    0.576728
    D    5.000000
    F    3.000000
    dtype: float64




```python
# 다른 축에서 동일한 연산 수행
df.mean(1)
```




    2013-01-01    1.592340
    2013-01-02    1.286225
    2013-01-03    1.705976
    2013-01-04    1.698624
    2013-01-05    1.676527
    2013-01-06    2.393101
    Freq: D, dtype: float64




```python
# 정렬이 필요하며, 차원이 다른 객체로 연산 (pandas는 지정된 차원을 따라 자동으로 브로드캐스팅됨)
# broadcast: nympy에서 유래, n차원이나 스칼라 값으로 연산 수행 시 도출되는 결과의 규칙을 설명하는 것  
s = pd.Series([1, 3, 5, np.nan, 6, 8], index = dates).shift(2)
s
```




    2013-01-01    NaN
    2013-01-02    NaN
    2013-01-03    1.0
    2013-01-04    3.0
    2013-01-05    5.0
    2013-01-06    NaN
    Freq: D, dtype: float64




```python
df.sub(s, axis = 'index')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>-0.392687</td>
      <td>-0.217436</td>
      <td>-0.860000</td>
      <td>4.0</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-3.748149</td>
      <td>-2.582631</td>
      <td>-2.176101</td>
      <td>2.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-5.420492</td>
      <td>-5.175005</td>
      <td>-5.021870</td>
      <td>0.0</td>
      <td>-1.0</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



### **- Apply**


```python
# 데이터에 함수 적용
df.apply(np.cumsum)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>F</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2013-01-01</th>
      <td>0.000000</td>
      <td>0.000000</td>
      <td>1.369361</td>
      <td>5</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>2013-01-02</th>
      <td>-0.414597</td>
      <td>0.749837</td>
      <td>1.465248</td>
      <td>10</td>
      <td>1.0</td>
    </tr>
    <tr>
      <th>2013-01-03</th>
      <td>0.192716</td>
      <td>1.532401</td>
      <td>1.605249</td>
      <td>15</td>
      <td>3.0</td>
    </tr>
    <tr>
      <th>2013-01-04</th>
      <td>-0.555433</td>
      <td>1.949770</td>
      <td>2.429147</td>
      <td>20</td>
      <td>6.0</td>
    </tr>
    <tr>
      <th>2013-01-05</th>
      <td>-0.975925</td>
      <td>1.774765</td>
      <td>2.407277</td>
      <td>25</td>
      <td>10.0</td>
    </tr>
    <tr>
      <th>2013-01-06</th>
      <td>0.518520</td>
      <td>1.192738</td>
      <td>3.460366</td>
      <td>30</td>
      <td>15.0</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.apply(lambda x: x.max() - x.min())
```




    A    2.242594
    B    1.364592
    C    1.391231
    D    0.000000
    F    4.000000
    dtype: float64



### **- Histogramming**
[- 참고: Histogramming and Discretization(히스토그래밍과 이산화)](https://pandas.pydata.org/pandas-docs/stable/user_guide/basics.html)


```python
s = pd.Series(np.random.randint(0, 7, size = 10))
s
```




    0    6
    1    6
    2    4
    3    3
    4    6
    5    3
    6    0
    7    1
    8    0
    9    4
    dtype: int64




```python
s.value_counts
```




    <bound method IndexOpsMixin.value_counts of 0    6
    1    6
    2    4
    3    3
    4    6
    5    3
    6    0
    7    1
    8    0
    9    4
    dtype: int64>



### **- String Methods**
Series는 문자열 처리 메소드 모음(set)을 가지고 있다.  
이 모음은 배열의 각 요소를 쉽게 조작하도록 만드는 문자열의 속성에 포함되어 있다.  
문자열의 패턴 일치 확인은 기본적으로 정규 표현식을 사용하며, 몇몇 경우에는 항상 정규 표현식을 사용한다.  

[- 참고: 벡터화된 문자열 메소드](https://pandas.pydata.org/pandas-docs/stable/user_guide/text.html)


```python
s = pd.Series(['A', 'B', 'C', 'Aaba', 'Baca', np.nan, 'CABA', 'dog', 'cat'])
s.str.lower()
```




    0       a
    1       b
    2       c
    3    aaba
    4    baca
    5     NaN
    6    caba
    7     dog
    8     cat
    dtype: object



## **6. Merge**  

### **- Concat (연결)**
결합(join)/병합(merge) 형태의 연산에 관한 인덱스, 관계 대수 기능을 위한 다양한 형태의 논리를 포함한 Series, 데이터프레임, Panel 객체를 손쉽게 결합하는 기능이 있다.  

[- 참고: Merging](https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html)


```python
# concat()으로 pandas 객체 연결
df = pd.DataFrame(np.random.randn(10, 4))
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.044225</td>
      <td>0.155778</td>
      <td>0.674068</td>
      <td>-1.489455</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.504468</td>
      <td>-2.412972</td>
      <td>-0.541338</td>
      <td>0.556083</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.849690</td>
      <td>0.618393</td>
      <td>-0.587040</td>
      <td>0.065025</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.112398</td>
      <td>0.415087</td>
      <td>-0.452262</td>
      <td>1.626640</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1.043760</td>
      <td>-1.345565</td>
      <td>-0.534134</td>
      <td>-0.112001</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1.280222</td>
      <td>1.533708</td>
      <td>0.054365</td>
      <td>0.290299</td>
    </tr>
    <tr>
      <th>6</th>
      <td>0.476762</td>
      <td>1.399581</td>
      <td>0.342671</td>
      <td>-0.624159</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0.231877</td>
      <td>0.835411</td>
      <td>-0.527813</td>
      <td>0.502120</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.268321</td>
      <td>-0.991597</td>
      <td>0.900198</td>
      <td>2.113147</td>
    </tr>
    <tr>
      <th>9</th>
      <td>-0.403591</td>
      <td>-0.531963</td>
      <td>-1.762530</td>
      <td>-2.067926</td>
    </tr>
  </tbody>
</table>
</div>




```python
# break it into pieces
pieces = [df[:3], df[3:7], df[7:]]
pd.concat(pieces)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>0</th>
      <th>1</th>
      <th>2</th>
      <th>3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1.044225</td>
      <td>0.155778</td>
      <td>0.674068</td>
      <td>-1.489455</td>
    </tr>
    <tr>
      <th>1</th>
      <td>0.504468</td>
      <td>-2.412972</td>
      <td>-0.541338</td>
      <td>0.556083</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0.849690</td>
      <td>0.618393</td>
      <td>-0.587040</td>
      <td>0.065025</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.112398</td>
      <td>0.415087</td>
      <td>-0.452262</td>
      <td>1.626640</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1.043760</td>
      <td>-1.345565</td>
      <td>-0.534134</td>
      <td>-0.112001</td>
    </tr>
    <tr>
      <th>5</th>
      <td>1.280222</td>
      <td>1.533708</td>
      <td>0.054365</td>
      <td>0.290299</td>
    </tr>
    <tr>
      <th>6</th>
      <td>0.476762</td>
      <td>1.399581</td>
      <td>0.342671</td>
      <td>-0.624159</td>
    </tr>
    <tr>
      <th>7</th>
      <td>0.231877</td>
      <td>0.835411</td>
      <td>-0.527813</td>
      <td>0.502120</td>
    </tr>
    <tr>
      <th>8</th>
      <td>0.268321</td>
      <td>-0.991597</td>
      <td>0.900198</td>
      <td>2.113147</td>
    </tr>
    <tr>
      <th>9</th>
      <td>-0.403591</td>
      <td>-0.531963</td>
      <td>-1.762530</td>
      <td>-2.067926</td>
    </tr>
  </tbody>
</table>
</div>



### **- Join**
SQL 방식으로 병합한다.  
[- 참고: 데이터베이스 스타일 결합](https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html)


```python
left = pd.DataFrame({'key': ['foo', 'foo'], 'lval': [1, 2]})
right = pd.DataFrame({'key': ['foo', 'foo'], 'rval': [4, 5]})
```


```python
left
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>key</th>
      <th>lval</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>foo</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>foo</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>




```python
right
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>key</th>
      <th>rval</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>foo</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>foo</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.merge(left, right, on = 'key')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>key</th>
      <th>lval</th>
      <th>rval</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>foo</td>
      <td>1</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>foo</td>
      <td>1</td>
      <td>5</td>
    </tr>
    <tr>
      <th>2</th>
      <td>foo</td>
      <td>2</td>
      <td>4</td>
    </tr>
    <tr>
      <th>3</th>
      <td>foo</td>
      <td>2</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 다른 예시
left = pd.DataFrame({'key': ['foo', 'bar'], 'lval': [1, 2]})
right = pd.DataFrame({'key': ['foo', 'bar'], 'rval': [4, 5]})
```


```python
left
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>key</th>
      <th>lval</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>foo</td>
      <td>1</td>
    </tr>
    <tr>
      <th>1</th>
      <td>bar</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>




```python
right
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>key</th>
      <th>rval</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>foo</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>bar</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>




```python
pd.merge(left, right, on = 'key')
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>key</th>
      <th>lval</th>
      <th>rval</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>foo</td>
      <td>1</td>
      <td>4</td>
    </tr>
    <tr>
      <th>1</th>
      <td>bar</td>
      <td>2</td>
      <td>5</td>
    </tr>
  </tbody>
</table>
</div>



### **- Append (추가)**
데이터프레임에 행을 추가한다.  
[- 참고: Appending](https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html)


```python
df = pd.DataFrame(np.random.randn(8, 4), columns = ['A', 'B', 'C', 'D'])
df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>-1.293826</td>
      <td>0.735671</td>
      <td>1.108050</td>
      <td>-0.175206</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-1.949366</td>
      <td>1.468593</td>
      <td>1.386484</td>
      <td>0.963284</td>
    </tr>
    <tr>
      <th>2</th>
      <td>-0.423707</td>
      <td>0.157079</td>
      <td>0.185440</td>
      <td>0.435985</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.478659</td>
      <td>1.293856</td>
      <td>-0.515603</td>
      <td>0.200678</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.096275</td>
      <td>1.907146</td>
      <td>-0.771668</td>
      <td>-0.622949</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.557493</td>
      <td>0.096811</td>
      <td>-0.901813</td>
      <td>-0.458602</td>
    </tr>
    <tr>
      <th>6</th>
      <td>-0.072528</td>
      <td>-2.372909</td>
      <td>-1.428934</td>
      <td>1.458320</td>
    </tr>
    <tr>
      <th>7</th>
      <td>-0.199425</td>
      <td>-0.455105</td>
      <td>0.771140</td>
      <td>0.506667</td>
    </tr>
  </tbody>
</table>
</div>




```python
s = df.iloc[3]
df.append(s, ignore_index=True)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>-1.293826</td>
      <td>0.735671</td>
      <td>1.108050</td>
      <td>-0.175206</td>
    </tr>
    <tr>
      <th>1</th>
      <td>-1.949366</td>
      <td>1.468593</td>
      <td>1.386484</td>
      <td>0.963284</td>
    </tr>
    <tr>
      <th>2</th>
      <td>-0.423707</td>
      <td>0.157079</td>
      <td>0.185440</td>
      <td>0.435985</td>
    </tr>
    <tr>
      <th>3</th>
      <td>-0.478659</td>
      <td>1.293856</td>
      <td>-0.515603</td>
      <td>0.200678</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0.096275</td>
      <td>1.907146</td>
      <td>-0.771668</td>
      <td>-0.622949</td>
    </tr>
    <tr>
      <th>5</th>
      <td>0.557493</td>
      <td>0.096811</td>
      <td>-0.901813</td>
      <td>-0.458602</td>
    </tr>
    <tr>
      <th>6</th>
      <td>-0.072528</td>
      <td>-2.372909</td>
      <td>-1.428934</td>
      <td>1.458320</td>
    </tr>
    <tr>
      <th>7</th>
      <td>-0.199425</td>
      <td>-0.455105</td>
      <td>0.771140</td>
      <td>0.506667</td>
    </tr>
    <tr>
      <th>8</th>
      <td>-0.478659</td>
      <td>1.293856</td>
      <td>-0.515603</td>
      <td>0.200678</td>
    </tr>
  </tbody>
</table>
</div>



## **7. Grouping**
그룹화는 다음 단계 중 하나 이상을 포함하는 과정을 말한다.  
- 몇몇 기준에 따라 여러 그룹으로 데이터를 분할(splitting)  
- 각 그룹에 독립적으로 함수를 적용(applying)  
- 결과물을 하나의 데이터 구조로 결합(combining)  

[- 참고: 그룹화](https://pandas.pydata.org/pandas-docs/stable/user_guide/groupby.html)


```python
df = pd.DataFrame(
    {
        'A': ['foo', 'bar', 'foo', 'bar', 'foo', 'bar', 'foo', 'foo'],
        'B': ['one', 'one', 'two', 'three', 'two', 'two', 'one', 'three'],
        'C': np.random.randn(8),
        'D': np.random.randn(8)
    })

df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>foo</td>
      <td>one</td>
      <td>0.024720</td>
      <td>-1.293299</td>
    </tr>
    <tr>
      <th>1</th>
      <td>bar</td>
      <td>one</td>
      <td>1.510969</td>
      <td>0.509977</td>
    </tr>
    <tr>
      <th>2</th>
      <td>foo</td>
      <td>two</td>
      <td>0.342461</td>
      <td>-0.811380</td>
    </tr>
    <tr>
      <th>3</th>
      <td>bar</td>
      <td>three</td>
      <td>0.227221</td>
      <td>0.717127</td>
    </tr>
    <tr>
      <th>4</th>
      <td>foo</td>
      <td>two</td>
      <td>0.089665</td>
      <td>0.040704</td>
    </tr>
    <tr>
      <th>5</th>
      <td>bar</td>
      <td>two</td>
      <td>-0.336139</td>
      <td>1.132600</td>
    </tr>
    <tr>
      <th>6</th>
      <td>foo</td>
      <td>one</td>
      <td>0.301063</td>
      <td>-0.133439</td>
    </tr>
    <tr>
      <th>7</th>
      <td>foo</td>
      <td>three</td>
      <td>0.167332</td>
      <td>0.789836</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 생성된 데이터프레임을 그룹화한 후, 각 그룹에 sum() 함수 적용
df.groupby('A').sum()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>C</th>
      <th>D</th>
    </tr>
    <tr>
      <th>A</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>bar</th>
      <td>1.402051</td>
      <td>2.359705</td>
    </tr>
    <tr>
      <th>foo</th>
      <td>0.925241</td>
      <td>-1.407579</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 여러 열을 기준으로 그룹화하면 계층적 인덱스가 형성, 여기에도 sum 함수 적용 가능
df.groupby(['A', 'B']).sum()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>C</th>
      <th>D</th>
    </tr>
    <tr>
      <th>A</th>
      <th>B</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="3" valign="top">bar</th>
      <th>one</th>
      <td>1.510969</td>
      <td>0.509977</td>
    </tr>
    <tr>
      <th>three</th>
      <td>0.227221</td>
      <td>0.717127</td>
    </tr>
    <tr>
      <th>two</th>
      <td>-0.336139</td>
      <td>1.132600</td>
    </tr>
    <tr>
      <th rowspan="3" valign="top">foo</th>
      <th>one</th>
      <td>0.325783</td>
      <td>-1.426738</td>
    </tr>
    <tr>
      <th>three</th>
      <td>0.167332</td>
      <td>0.789836</td>
    </tr>
    <tr>
      <th>two</th>
      <td>0.432126</td>
      <td>-0.770676</td>
    </tr>
  </tbody>
</table>
</div>



## **8. Reshaping**
[- 참고: 계층적 인덱싱](https://pandas.pydata.org/pandas-docs/stable/user_guide/advanced.html), [변형](https://pandas.pydata.org/pandas-docs/stable/user_guide/reshaping.html)  

### **- Stack**


```python
tuples = list(zip(*[['bar', 'bar', 'baz', 'baz',
                     'foo', 'foo', 'qux', 'qux'],
                    ['one', 'two', 'one', 'two',
                     'one', 'two', 'one', 'two']]))

index = pd.MultiIndex.from_tuples(tuples, names = ['first', 'second'])
df = pd.DataFrame(np.random.randn(8, 2), index=index, columns=['A', 'B'])
df2 = df[:4]
df2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>A</th>
      <th>B</th>
    </tr>
    <tr>
      <th>first</th>
      <th>second</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">bar</th>
      <th>one</th>
      <td>0.164873</td>
      <td>-1.599363</td>
    </tr>
    <tr>
      <th>two</th>
      <td>0.262695</td>
      <td>0.130688</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">baz</th>
      <th>one</th>
      <td>1.062799</td>
      <td>1.995716</td>
    </tr>
    <tr>
      <th>two</th>
      <td>-1.389387</td>
      <td>-1.260636</td>
    </tr>
  </tbody>
</table>
</div>




```python
# stack() 메소드는 데이터프레임 열들의 계층을 압축
stacked = df2.stack()
stacked
```




    first  second   
    bar    one     A    0.164873
                   B   -1.599363
           two     A    0.262695
                   B    0.130688
    baz    one     A    1.062799
                   B    1.995716
           two     A   -1.389387
                   B   -1.260636
    dtype: float64




```python
# Stack된 데이터프레임 또는 MultiIndex를 인덱스로 사용하는 Series인 경우,
# stack()의 역연산은 unstack()이며 기본적으로 마지막 계층을 unstack함
stacked.unstack()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th></th>
      <th>A</th>
      <th>B</th>
    </tr>
    <tr>
      <th>first</th>
      <th>second</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">bar</th>
      <th>one</th>
      <td>0.164873</td>
      <td>-1.599363</td>
    </tr>
    <tr>
      <th>two</th>
      <td>0.262695</td>
      <td>0.130688</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">baz</th>
      <th>one</th>
      <td>1.062799</td>
      <td>1.995716</td>
    </tr>
    <tr>
      <th>two</th>
      <td>-1.389387</td>
      <td>-1.260636</td>
    </tr>
  </tbody>
</table>
</div>




```python
stacked.unstack(1)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>second</th>
      <th>one</th>
      <th>two</th>
    </tr>
    <tr>
      <th>first</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">bar</th>
      <th>A</th>
      <td>0.164873</td>
      <td>0.262695</td>
    </tr>
    <tr>
      <th>B</th>
      <td>-1.599363</td>
      <td>0.130688</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">baz</th>
      <th>A</th>
      <td>1.062799</td>
      <td>-1.389387</td>
    </tr>
    <tr>
      <th>B</th>
      <td>1.995716</td>
      <td>-1.260636</td>
    </tr>
  </tbody>
</table>
</div>




```python
stacked.unstack(0)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>first</th>
      <th>bar</th>
      <th>baz</th>
    </tr>
    <tr>
      <th>second</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="2" valign="top">one</th>
      <th>A</th>
      <td>0.164873</td>
      <td>1.062799</td>
    </tr>
    <tr>
      <th>B</th>
      <td>-1.599363</td>
      <td>1.995716</td>
    </tr>
    <tr>
      <th rowspan="2" valign="top">two</th>
      <th>A</th>
      <td>0.262695</td>
      <td>-1.389387</td>
    </tr>
    <tr>
      <th>B</th>
      <td>0.130688</td>
      <td>-1.260636</td>
    </tr>
  </tbody>
</table>
</div>



### **- Pivot Tables**
[- 참고: 피봇 테이블](https://pandas.pydata.org/pandas-docs/stable/user_guide/reshaping.html)


```python
df = pd.DataFrame({'A': ['one', 'one', 'two', 'three'] * 3,
                   'B': ['A', 'B', 'C'] * 4,
                   'C': ['foo', 'foo', 'foo', 'bar', 'bar', 'bar'] * 2,
                   'D': np.random.randn(12),
                   'E': np.random.randn(12)})

df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>A</th>
      <th>B</th>
      <th>C</th>
      <th>D</th>
      <th>E</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>one</td>
      <td>A</td>
      <td>foo</td>
      <td>-0.335507</td>
      <td>0.728239</td>
    </tr>
    <tr>
      <th>1</th>
      <td>one</td>
      <td>B</td>
      <td>foo</td>
      <td>-0.251893</td>
      <td>1.290054</td>
    </tr>
    <tr>
      <th>2</th>
      <td>two</td>
      <td>C</td>
      <td>foo</td>
      <td>0.590448</td>
      <td>0.226098</td>
    </tr>
    <tr>
      <th>3</th>
      <td>three</td>
      <td>A</td>
      <td>bar</td>
      <td>1.207361</td>
      <td>0.915646</td>
    </tr>
    <tr>
      <th>4</th>
      <td>one</td>
      <td>B</td>
      <td>bar</td>
      <td>0.296306</td>
      <td>-1.981152</td>
    </tr>
    <tr>
      <th>5</th>
      <td>one</td>
      <td>C</td>
      <td>bar</td>
      <td>0.166610</td>
      <td>-0.312002</td>
    </tr>
    <tr>
      <th>6</th>
      <td>two</td>
      <td>A</td>
      <td>foo</td>
      <td>1.505633</td>
      <td>-0.791708</td>
    </tr>
    <tr>
      <th>7</th>
      <td>three</td>
      <td>B</td>
      <td>foo</td>
      <td>-1.978302</td>
      <td>-1.671514</td>
    </tr>
    <tr>
      <th>8</th>
      <td>one</td>
      <td>C</td>
      <td>foo</td>
      <td>1.263163</td>
      <td>-2.340603</td>
    </tr>
    <tr>
      <th>9</th>
      <td>one</td>
      <td>A</td>
      <td>bar</td>
      <td>-0.028701</td>
      <td>-1.374556</td>
    </tr>
    <tr>
      <th>10</th>
      <td>two</td>
      <td>B</td>
      <td>bar</td>
      <td>0.657087</td>
      <td>0.272042</td>
    </tr>
    <tr>
      <th>11</th>
      <td>three</td>
      <td>C</td>
      <td>bar</td>
      <td>0.351417</td>
      <td>1.455815</td>
    </tr>
  </tbody>
</table>
</div>




```python
# 피봇 테이블 생성
pd.pivot_table(df, values='D', index=['A', 'B'], columns=['C'])
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>C</th>
      <th>bar</th>
      <th>foo</th>
    </tr>
    <tr>
      <th>A</th>
      <th>B</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th rowspan="3" valign="top">one</th>
      <th>A</th>
      <td>-0.028701</td>
      <td>-0.335507</td>
    </tr>
    <tr>
      <th>B</th>
      <td>0.296306</td>
      <td>-0.251893</td>
    </tr>
    <tr>
      <th>C</th>
      <td>0.166610</td>
      <td>1.263163</td>
    </tr>
    <tr>
      <th rowspan="3" valign="top">three</th>
      <th>A</th>
      <td>1.207361</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>B</th>
      <td>NaN</td>
      <td>-1.978302</td>
    </tr>
    <tr>
      <th>C</th>
      <td>0.351417</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th rowspan="3" valign="top">two</th>
      <th>A</th>
      <td>NaN</td>
      <td>1.505633</td>
    </tr>
    <tr>
      <th>B</th>
      <td>0.657087</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>C</th>
      <td>NaN</td>
      <td>0.590448</td>
    </tr>
  </tbody>
</table>
</div>



## **9. Time Series**
Pandas는 자주 일어나는 변환(ex. 5분마다 일어나는 데이터의 2차 데이터 변환) 사이에 수행하는 리샘플링 연산을 위해 간단하고 강력하고 효율적인 함수를 제공한다.  
재무(금융) 응용에서 매우 일반적이나 이에 국한되지는 않는다.  
[- 참고: 시계열](https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html)


```python

```


```python
rng = pd.date_range('1/1/2012', periods=100, freq='S')
ts = pd.Series(np.random.randint(0, 500, len(rng)), index=rng)
ts.resample('5Min').sum()
```




    2012-01-01    25049
    Freq: 5T, dtype: int64




```python
# 시간대 표현
rng = pd.date_range('3/6/2012 00:00', periods=5, freq='D')
ts = pd.Series(np.random.randn(len(rng)), rng)
ts
```




    2012-03-06    0.099699
    2012-03-07    0.235671
    2012-03-08    0.636022
    2012-03-09   -1.993396
    2012-03-10   -0.113581
    Freq: D, dtype: float64




```python
ts_utc = ts.tz_localize('UTC')
ts_utc
```




    2012-03-06 00:00:00+00:00    0.099699
    2012-03-07 00:00:00+00:00    0.235671
    2012-03-08 00:00:00+00:00    0.636022
    2012-03-09 00:00:00+00:00   -1.993396
    2012-03-10 00:00:00+00:00   -0.113581
    Freq: D, dtype: float64




```python
# 다른 시간대로 변환
ts_utc.tz_convert('US/Eastern')
```




    2012-03-05 19:00:00-05:00    0.099699
    2012-03-06 19:00:00-05:00    0.235671
    2012-03-07 19:00:00-05:00    0.636022
    2012-03-08 19:00:00-05:00   -1.993396
    2012-03-09 19:00:00-05:00   -0.113581
    Freq: D, dtype: float64




```python
# 시간 표현 ↔ 기간 표현 변환
rng = pd.date_range('1/1/2012', periods=5, freq='M')
ts = pd.Series(np.random.randn(len(rng)), index=rng)
ts
```




    2012-01-31   -1.161855
    2012-02-29    0.262081
    2012-03-31    0.238179
    2012-04-30   -1.160233
    2012-05-31    0.816160
    Freq: M, dtype: float64




```python
ps = ts.to_period()
ps
```




    2012-01   -1.161855
    2012-02    0.262081
    2012-03    0.238179
    2012-04   -1.160233
    2012-05    0.816160
    Freq: M, dtype: float64




```python
ps.to_timestamp()
```




    2012-01-01   -1.161855
    2012-02-01    0.262081
    2012-03-01    0.238179
    2012-04-01   -1.160233
    2012-05-01    0.816160
    Freq: MS, dtype: float64



기간 ↔ 시간 변환은 편리한 산술 기능을 사용할 수 있도록 만든다.  
11월에 끝나는 연말 결산의 분기별 빈도를, 분기말 익월의 월말일 오전 9시로 변환해보자.


```python
prng = pd.period_range('1990Q1', '2000Q4', freq='Q-NOV')
ts = pd.Series(np.random.randn(len(prng)), prng)
ts.index = (prng.asfreq('M', 'e') + 1).asfreq('H', 'S')
ts.head()
```




    1990-03-01 00:00    0.671614
    1990-06-01 00:00   -0.141739
    1990-09-01 00:00    0.070749
    1990-12-01 00:00   -0.769261
    1991-03-01 00:00   -0.432595
    Freq: H, dtype: float64



## **10. Categoricals**
Pandas는 데이터프레임 내에 범주형 데이터를 포함할 수 있다.  
[- 참고: 범주형 소개](https://pandas.pydata.org/pandas-docs/stable/user_guide/categorical.html), [API 문서](https://pandas.pydata.org/pandas-docs/stable/reference/index.html)  


```python
df = pd.DataFrame({"id":[1,2,3,4,5,6], "raw_grade":['a', 'b', 'b', 'a', 'a', 'e']})
```

가공하지 않은 성적을 범주형 데이터로 변환한다.


```python
df["grade"] = df["raw_grade"].astype("category")
df["grade"]
```




    0    a
    1    b
    2    b
    3    a
    4    a
    5    e
    Name: grade, dtype: category
    Categories (3, object): ['a', 'b', 'e']



범주에 더 의미있는 이름을 붙이자. (Series.cat.categories로 할당하는 것이 적합)


```python
df["grade"].cat.categories = ["very good", "good", "very bad"]
```

범주 순서를 바꾸고 동시에 누락된 범주를 추가한다. (Series.cat에 속하는 메소드는 기본적으로 새로운 Series를 반환)


```python
df["grade"] = df["grade"].cat.set_categories(["very bad", "bad", "medium", "good", "very good"])
df["grade"]
```




    0    very good
    1         good
    2         good
    3    very good
    4    very good
    5     very bad
    Name: grade, dtype: category
    Categories (5, object): ['very bad', 'bad', 'medium', 'good', 'very good']



정렬은 사전 순서가 아니라, 해당 범주에서 지정된 순서대로 배열한다.


```python
df.sort_values(by="grade")
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>id</th>
      <th>raw_grade</th>
      <th>grade</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>5</th>
      <td>6</td>
      <td>e</td>
      <td>very bad</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2</td>
      <td>b</td>
      <td>good</td>
    </tr>
    <tr>
      <th>2</th>
      <td>3</td>
      <td>b</td>
      <td>good</td>
    </tr>
    <tr>
      <th>0</th>
      <td>1</td>
      <td>a</td>
      <td>very good</td>
    </tr>
    <tr>
      <th>3</th>
      <td>4</td>
      <td>a</td>
      <td>very good</td>
    </tr>
    <tr>
      <th>4</th>
      <td>5</td>
      <td>a</td>
      <td>very good</td>
    </tr>
  </tbody>
</table>
</div>



범주의 열을 기준으로 그룹화하면 빈 범주도 표시된다.


```python
df.groupby("grade").size()
```




    grade
    very bad     1
    bad          0
    medium       0
    good         2
    very good    3
    dtype: int64



## **11. Plotting**
[- 참고: Plotting](https://pandas.pydata.org/pandas-docs/stable/user_guide/visualization.html)


```python
ts = pd.Series(np.random.randn(1000), index=pd.date_range('1/1/2000', periods=1000))
ts = ts.cumsum()
ts.plot
```




    <pandas.plotting._core.PlotAccessor object at 0x7f4670f2ae80>



데이터프레임에서 plot() 메소드는 라벨이 존재하는 모든 열을 그릴 때 편리하다.


```python
df = pd.DataFrame(np.random.randn(1000, 4), index=ts.index,
                  columns=['A', 'B', 'C', 'D'])  
df = df.cumsum()
plt.figure(); df.plot(); plt.legend(loc='best')
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    <ipython-input-97-bc219ebae1fe> in <module>()
    ----> 1 df = pd.DataFrame(np.random.randn(1000, 4), index=ts.index,
          2                   columns=['A', 'B', 'C', 'D'])  
          3 df = df.cumsum()
          4 plt.figure(); df.plot(); plt.legend(loc='best')
    

    /usr/local/lib/python3.6/dist-packages/pandas/core/generic.py in __getattr__(self, name)
       5137             if self._info_axis._can_hold_identifiers_and_holds_name(name):
       5138                 return self[name]
    -> 5139             return object.__getattribute__(self, name)
       5140 
       5141     def __setattr__(self, name: str, value) -> None:
    

    AttributeError: 'DataFrame' object has no attribute 'DataFrame'


## **12. Getting Data In / Out**

### **CSV**
csv 파일에 쓴다.  
df.to_csv('foo.csv')  

csv 파일을 읽는다.  
pd.read_csv('foo.csv')

### **HDF5**
HDF5 Store에 쓴다.  
df.to_hdf('foo.h5','df')  
HDF5 Store에서 읽는다.  
pd.read_hdf('foo.h5','df')  

### **Excel**
엑셀 파일에 쓴다.  
df.to_excel('foo.xlsx', sheet_name='Sheet1')  
엑셀 파일을 읽는다.  
pd.read_excel('foo.xlsx', 'Sheet1', index_col=None, na_values=['NA'])  

## **13. Gotchas**
연산 수행 시, 다음과 같은 예외 상황이 나타날 수 있다.


```python
if pd.Series([False, True, False]):
  print("I was true")
```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    <ipython-input-104-06fa23a4b3e2> in <module>()
    ----> 1 if pd.Series([False, True, False]):
          2   print("I was true")
    

    /usr/local/lib/python3.6/dist-packages/pandas/core/generic.py in __getattr__(self, name)
       5137             if self._info_axis._can_hold_identifiers_and_holds_name(name):
       5138                 return self[name]
    -> 5139             return object.__getattribute__(self, name)
       5140 
       5141     def __setattr__(self, name: str, value) -> None:
    

    AttributeError: 'DataFrame' object has no attribute 'Series'


이러한 경우에는 any(), all(), empty 등을 사용해서 무엇을 원하는지를 선택해주어야 한다.  
```python
if pd.Series([False, True, False]) is not None:
      print("I was not None")
```
