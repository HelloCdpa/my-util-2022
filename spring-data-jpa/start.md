## 🙄 spring-data-jpa란?

**spring framework에서 JPA를 편리하게 사용할 수 있도록 지원하는 프로젝트** 
- CRUD 처리를 위한 공통 인터페이스 제공  
- repository 개발 시 인터페이스만 작성하면 실행 시점에 스프링 데이터 JPA가 구현 객체를 동적으로 생성해서 주입  
- 데이터 접근 계층을 개발할 때 구현 클래스 없이 인터페이스만 작성해도 개발을 완료할 수 있도록 지원  
- 공통 메소드는 스프링 데이터 JPA가 제공하는 org.springframework.date.jpa.repository.JpaRepository 인터페이스에  
  count, delete, deleteAll, deleteAll, deleteById, existsById, findById, save ..  

출처: https://data-make.tistory.com/621 [Data Makes Our Future]







