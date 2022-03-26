### LoginCheckInterceptor

```java
import com.phl.cocolo.common.SessionConst;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
public class LoginCheckInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        
        String requestURI = request.getRequestURI();
 
        HttpSession session = request.getSession();
       
        if(session.getAttribute(SessionConst.LOGIN_EMAIL) == null){

            session.setAttribute("redirectURL", requestURI);
            response.sendRedirect("/member/login");

            return false;
        } else {
            //로그인 상태
            return true;
        }
    }
}
```
## 🚙 과정 설명

  1. 사용자가 요청한 주소 : requestURI  
  2. session은 request 객체 안에 들어있음 -> 서블릿이 관리해 줌  
  서블릿이 있어야 웹서버 구축 - 스프링부트, 스프링 프레임 워크로 서블릿을 편하게 쓴다!  
  3. 세션을 가져옴 : request.getSession();  
  4. 조건문으로 세션에 로그인 정보가 있는지 확인(세션 로그인 값이 있으면~ 로그인 한 것 없으면 ~안 한 것)
  5. 로그인 하지 않은 경우 바로 로그인 페이지로 보내고 로그인 후 요청 화면을 보여줌.

### webconfig

```java
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry){
        //체인 메서드
        registry.addInterceptor(new LoginCheckInterceptor()) 
                .order(1) 
                .addPathPatterns("/**") 
                .excludePathPatterns("/","/member/save","/member/login","/member/logout","/assets/**","/member/emailDuplication",
                        "/board_upload/**","/member_upload/**","/class_upload/**","/course/","/board/**","/onClass/**","/study/","/mentoring/",
                        "/member/nickNameDuplication","/board/search/**","/board/cateBoard/**","/member/kakaologin",
                        "/member/testLogin","/member/sendEmail"
                        );
    }
}
```
## 설명
로그인 여부에 따른 접속 가능 페이지 구분하는 클래스

**메서드 체이닝(Method Chaining)**  
 : 프로그래밍 패턴. 메서드가 객체를 반환하게 되면, 메서드의 반환 값인 객체를 통해 또 다른 함수를 호출할 수 있다.   

    .addInterceptor(new LoginCheckInterceptor()) : 만든 LoginCheckInterceptor 클래스 내용을 넘김
    .order(1) : 해당 인터셉터가 적용되는 순서 (몇번째로 적용시켜줄까? 스프링이 우선순위를 배정해줌)
    .addPathPatterns("/**") : 해당 프로젝트의 모든 주소에 대해 인터셉터를 적용
    .excludePathPatterns() : 그 중에 이 주소는 제외

### Controller
```java
    @PostMapping("/login")
    public String login(@Validated @ModelAttribute("member") MemberLoginDTO memberLoginDTO,
                         HttpSession session, Model model) {
        if(ms.findByEmail(memberLoginDTO)){
            session.setAttribute(LOGIN_EMAIL, memberLoginDTO.getMemberEmail());

            Long memberId = ms.findByMemberId(memberLoginDTO.getMemberEmail());
            session.setAttribute(LOGIN_ID, memberId);

            String memberNickName = ms.findById(memberId).getMemberNickName();
            session.setAttribute(LOGIN_NICKNAME, memberNickName);

            String redirectURL = (String) session.getAttribute("redirectURL");

            if (redirectURL != null){
                return "redirect:/"+redirectURL;
            }else{
                return "index";
            }
        } else {
            model.addAttribute("msg","로그인 실패");
            return "/member/login";
        }
    }

```
