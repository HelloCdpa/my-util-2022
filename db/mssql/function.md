## 💯 숫자함수 
### ROUND(숫자, 자릿수) 
반올림하여 숫자의 자릿수까지 나타낸 값 반환

### SIGN(숫자) 
양수 음수 구분(양수:1 음수 : -1 ,0 : 0)

### ABS(숫자) 
절대값

### CEILING(숫자) 
올림

### FLOOR(숫자) 
버림

## 🆗 문자함수 
### UPPER, LOWER 
문자열 대문자 , 소문자로 바꿈

### LEN 
문자열의 길이(공백 포함)  

### LTRIM, RTRIM, TRIM 
왼쪽, 오른쪽, 양쪽 공백 제거

### CONCAT(문자열1,문자열2,문자열n...) 
두 개 이상의 문자열 합치기

### LEFT, RIGHT(문자열, 글자수) 
왼쪽, 오른쪽부터 글자수만큼 반환

### SUBSTRING(문자열, 시작위치, 글자수) 
시작위치에서 글자수만큼 반환

### REPLACE(문자열, 이전 문자열, 바꿀 문자열) 
문자 바꾸기

### CHARINDEX(찾을 문자열, 문자열,[시작위치])
시작위치부터 찾을 문자열의 위치 반환

https://www.w3schools.com/sql/sql_ref_sqlserver.asp

#### 복습 문제 쿼리
```sql
SELECT FirstName, Photo, CONCAT (FirstName, '[', Photo, ']') AS [Name_Photo]  FROM Employees 
SELECT CONCAT(LEN(REPLACE(Notes,' ','')), '(', LEFT(Notes,10) ,')') AS[info], Notes FROM Employees 
SELECT LastName, CONCAT(UPPER(LastName),'(' ,CHARINDEX('German',Notes),')') AS[German],  Notes FROM Employees 

```
