## 1. SELECT ����� "SELECT �ʵ�� FROM ���̺��" �������� �ʵ� ��ü�� �Ϻθ� �˻���

SELECT *
FROM TB_CUSTOMER;

SELECT CUSTOMER_CD,
CUSTOMER_NM,
PHONE_NUMBER,
EMAIL
FROM TB_CUSTOMER;

SELECT CUSTOMER_CD AS ���ڵ�,
CUSTOMER_NM AS ����,
PHONE_NUMBER AS ��ȭ��ȣ,
EMAIL AS �̸���
FROM TB_CUSTOMER;

## 2. WHERE ������ SELECT ����� �̿��� ������ ���̺��� ���ǿ� �´� ������ �˻� �� ���
## "WHERE KOR=100" ����� KOR �ʵ��� ���� 100�� ������

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG = 'M';

## 3. AND ������ ������ ���̺��� ������ ������ ��� �����ϴ� �����͸� �˻��ϰ�, �ϳ��� �������� ������ �˻����� ����
## "WHERE CLASS_CD='A' AND KOR=100"�� ����� CLASS_CD �ʵ� ���� A�鼭 KOR �׸� ���� 100�� ������

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_CD > '2019000'
AND MW_FLG = 'W';

SELECT *
FROM TB_CUSTOMER
WHERE BIRTH_DAY < '19900101'
AND MW_FLG = 'M';

## 4. OR ������ ������ ���̺��� ������ ���ǿ� �ϳ��� �����ϴ� �����͸� �˻��ϰ�, ��� �������� ������ �˻����� ����
## "WHERE CLASS_CD='A' OR KOR=100"�� ����� CLASS_CD �ʵ� ���� 'A'�ų� KOR �ʵ� ���� 100�� ������
SELECT *
FROM TB_CUSTOMER
WHERE BIRTH_DAY >= '19900101'
OR TOTAL_POINT >= 20000;

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG = 'M'
AND (BIRTH_DAY < '19700101'
OR TOTAL_POINT >= 20000);

## 5. BETWEEN .. AND ������ ������ ������ �����͸� �˻��ϰ�, �ʵ� �������� ��ġ, ����, ��¥ ���� ������ �� ����
## "WHERE YEAR BETWEEN 10 AND 19"�� ����� YEAR �ʵ� ���� 10���� 19�� ������
## BETWEEN �տ� NOT�� �����ϸ� Ư�� ������ �����͸� �����ϰ� �˻��� �� ����

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

## 6. �� �����ڴ� �� ���� '����', '���� �ʴ�', 'ũ��', '�۴�', 'ũ�ų� ����', '�۰ų� ����'�� ��Ÿ��
## '�ٸ���'�� �������� '<>', '!=', '^='�� ������ ���� '<>' ��ȣ�� �ַ� ����

SELECT *
FROM TB_CUSTOMER
WHERE TOTAL_POINT < 10000
OR TOTAL_POINT >= 30000;

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG <> 'W'
AND TOTAL_POINT <= 10000;

## 7. LIKE ������ �˻����� �ʵ忡 ���Ե� �����͸� �˻��ϴ� �� ���
## ���̿� ������� ���ڿ��� ��ü�ϴ� '%'�� ���� �ϳ��� ��ü�ϴ� '_' ���ڸ� �����ؼ� ���

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

## 8. IN ������ ������ �˻����� �ʵ忡 ���Ե� �����͸� �˻�
## �ʵ� IN '(�˻���1, �˻���2, ..., �˻���n)' �������� �ʵ� ���� '�˻���1'���� '�˻���n' �� �ϳ��� ������ �˻�
## IN �տ� NOT�� �����ϸ� �˻����� �ʵ忡 ���Ե��� ���� ������ �˻� ����
## IN ������ OR ���ǰ� ���� ����� ������

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_NM IN ('�����','������','����ö','���ѱ�','������','�̾Ƹ�');

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_CD IN ('2017108', '2018254', '2019167')
AND MW_FLG = 'M';

## 9. ORDER BY ������ ������ �ʵ� �������� �����͸� ������, �ʵ� �ڿ� ���Ĺ���� ������ ��������(ASC)���� �⺻ ���� (���������� ��� DESC�� ����)
## �ʵ� ��ȣ�� �˻��ϰ��� �ϴ� �ʵ� ������ ����

SELECT