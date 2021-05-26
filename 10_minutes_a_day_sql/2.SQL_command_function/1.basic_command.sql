## 1. SELECT 명령은 "SELECT 필드명 FROM 테이블명" 형식으로 필드 전체나 일부를 검색함

SELECT *
FROM TB_CUSTOMER;

SELECT CUSTOMER_CD,
CUSTOMER_NM,
PHONE_NUMBER,
EMAIL
FROM TB_CUSTOMER;

SELECT CUSTOMER_CD AS 고객코드,
CUSTOMER_NM AS 고객명,
PHONE_NUMBER AS 전화번호,
EMAIL AS 이메일
FROM TB_CUSTOMER;

## 2. WHERE 구문은 SELECT 명령을 이용해 지정한 테이블에서 조건에 맞는 데이터 검색 시 사용
## "WHERE KOR=100" 결과는 KOR 필드의 값이 100인 데이터

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG = 'M';

## 3. AND 구문은 지정한 테이블에서 나열한 조건을 모두 만족하는 데이터를 검색하고, 하나라도 만족하지 않으면 검색하지 않음
## "WHERE CLASS_CD='A' AND KOR=100"의 결과는 CLASS_CD 필드 값이 A면서 KOR 항목 값이 100인 데이터

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_CD > '2019000'
AND MW_FLG = 'W';

SELECT *
FROM TB_CUSTOMER
WHERE BIRTH_DAY < '19900101'
AND MW_FLG = 'M';

## 4. OR 구문은 지정한 테이블에서 나열한 조건에 하나라도 만족하는 데이터를 검색하고, 모두 만족하지 않으면 검색하지 않음
## "WHERE CLASS_CD='A' OR KOR=100"의 결과는 CLASS_CD 필드 값이 'A'거나 KOR 필드 값이 100인 데이터
SELECT *
FROM TB_CUSTOMER
WHERE BIRTH_DAY >= '19900101'
OR TOTAL_POINT >= 20000;

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG = 'M'
AND (BIRTH_DAY < '19700101'
OR TOTAL_POINT >= 20000);

## 5. BETWEEN .. AND 구문은 지정한 범위의 데이터를 검색하고, 필드 형식으로 수치, 문자, 날짜 등을 지정할 수 있음
## "WHERE YEAR BETWEEN 10 AND 19"의 결과는 YEAR 필드 값이 10에서 19인 데이터
## BETWEEN 앞에 NOT을 지정하면 특정 범위의 데이터를 제외하고 검색할 수 있음

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG = 'W'
AND TOTAL_POINT BETWEEN 10000 AND 20000;

SELECT *
FROM TB_CUSTOMER
WHERE BIRTH_DAY BETWEEN '19800101' AND '19891231';

SELECT *
FROM TB_CUSTOMER
WHERE TOTAL_POINT NOT BETWEEN 10000 AND 30000;

## 6. 비교 연산자는 두 값이 '같다', '같지 않다', '크다', '작다', '크거나 같다', '작거나 같다'를 나타냄
## '다르다'의 조건으로 '<>', '!=', '^='가 있지만 보통 '<>' 기호가 주로 쓰임

SELECT *
FROM TB_CUSTOMER
WHERE TOTAL_POINT < 10000
OR TOTAL_POINT >= 30000;

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG <> 'W'
AND TOTAL_POINT <= 10000;

## 7. LIKE 구문은 검색값이 필드에 포함된 데이터를 검색하는 데 사용
## 길이에 상관없이 문자열을 대체하는 '%'와 문자 하나를 대체하는 '_' 문자를 조합해서 사용

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_CD LIKE '2018%';

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_CD LIKE '2018%';

SELECT *
FROM TB_CUSTOMER
WHERE (CUSTOMER_CD LIKE '2017%'
OR     CUSTOMER_CD LIKE '2019%')
AND MW_FLG = 'W';

SELECT *
FROM TB_CUSTOMER
WHERE PHONE_NUMBER NOT LIKE '___-____-____';

## 8. IN 구문은 나열한 검색값이 필드에 포함된 데이터를 검색
## 필드 IN '(검색값1, 검색값2, ..., 검색값n)' 형식으로 필드 값이 '검색값1'에서 '검색값n' 중 하나라도 있으면 검색
## IN 앞에 NOT을 지정하면 검색값이 필드에 포함되지 않은 데이터 검색 가능
## IN 구문은 OR 조건과 같은 결과를 보여줌

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_NM IN ('나경숙','이혜옥','김진철','김한길','강수지','이아름');

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_CD IN ('2017108', '2018254', '2019167')
AND MW_FLG = 'M';

## 9. ORDER BY 구문은 나열한 필드 기준으로 데이터를 정렬함, 필드 뒤에 정렬방식이 없으면 오름차순(ASC)으로 기본 정렬 (내림차순의 경우 DESC를 지정)
## 필드 번호는 검색하고자 하는 필드 순서와 동일

SELECT