-- 1. SELECT ����� "SELECT �ʵ�� FROM ���̺��" �������� �ʵ� ��ü�� �Ϻθ� �˻���

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

-- 2. WHERE ������ SELECT ����� �̿��� ������ ���̺��� ���ǿ� �´� ������ �˻� �� ���
-- "WHERE KOR=100" ����� KOR �ʵ��� ���� 100�� ������

SELECT *
FROM TB_CUSTOMER
WHERE MW_FLG = 'M';

-- 3. AND ������ ������ ���̺��� ������ ������ ��� �����ϴ� �����͸� �˻��ϰ�, �ϳ��� �������� ������ �˻����� ����
-- "WHERE CLASS_CD='A' AND KOR=100"�� ����� CLASS_CD �ʵ� ���� A�鼭 KOR �׸� ���� 100�� ������

SELECT *
FROM TB_CUSTOMER
WHERE CUSTOMER_CD > '2019000'
AND MW_FLG = 'W';

SELECT *
FROM TB_CUSTOMER
WHERE BIRTH_DAY < '19900101'
AND MW_FLG = 'M';

-- 4. OR ������ ������ ���̺��� ������ ���ǿ� �ϳ��� �����ϴ� �����͸� �˻��ϰ�, ��� �������� ������ �˻����� ����
-- "WHERE CLASS_CD='A' OR KOR=100"�� �����
-- CLASS_CD �ʵ� ���� 'A'�ų� KOR �ʵ� ���� '8'�̸鼭 KOR �ʵ� ���� 100�� �����͵� �˻��ǰ�, CLASS_CD �ʵ� ���� 'A'�鼭 KOR �ʵ� ���� 90�� �����͵� �˻�

SELECT *
FROM TB_CUSTOMER
WHERE BIRTH_DAY >= '19900101'
OR TOTAL_POINT >= 20000;

SELECT * 
FROM TB_CUSTOMER
WHERE MW_FLG = 'M'
AND (BIRTH_DAY < '19700101'
OR TOTAL_POINT >= 20000);

