## assert

### import 할 것
```java
import static org.assertj.core.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.*;
```
### 사용예시
1. 같음 비교  
```java
@SpringBootTest
public class MemberTest {
    @Autowired
    private MemberService ms;
    @Test
    @Transactional //테스트 시작할 때 새로운 트랜잭션 시작
    @Rollback //테스트 종료 후 롤백 수행
    @DisplayName("로그인 테스트")
    public void loginTest(){
	 assertThat(loginResult).isEqualTo(true);
    }
	
//	서비스 클래스에서 사용할 때 @Transactional을 반드시 붙여줘야함
```
2. null 비교  
```java
 assertThrows(NoSuchElementException.class, ()->{
 // 삭제회원 id 조회결과가 null 이면 테스트 통과
            assertThat(ms.findById(memberId)).isNull(); 
        });
```
