### 1. gradle 프로젝트 만들기  

### 2. 사용 dependencies : Lombok, Spring Web, Thymeleaf, Spring Data JPA, Validation   

### 3. application.yml 설정하기  

```yml
server:
  port: 8091
#DB접속 정보
spring:
  thymeleaf:
    cache: false
    prefix: classpath:/templates/
    suffix: .html
  devtools:
    livereload:
      enabled: true
    remote:
      restart:
        enabled: true
  mail:
    host: smtp.naver.com
    port: 465
    username: phl1021@naver.com
    password: 보낼 이메일 비번
    properties:
      mail.smtp.auth: true
      mail.smtp.ssl.enable: true
  main:
    allow-circular-references: true
  servlet:
    multipart:
      max-file-size: 20MB
      max-request-size: 20MB
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/cocoloDB?serverTimezone=Asia/Seoul&characterEncoding=UTF-8
    username: coco
    password: 1234
  #JPA관련 설정 datasource와 같은 선에서
  jpa:
    database-platform: org.hibernate.dialect.MySQL5InnoDBDialect
    show-sql: true
    hibernate:
      ddl-auto: create

  #mybatis 관련설정
mybatis:
  #  #resources/mapper/ 에 있는 모든 xml 파일을 내가 매퍼로 쓸거다.
  mapper-locations: mapper/*.xml
  #alias설정
#  type-aliases-package: com.phl.cocolo.dto
```
