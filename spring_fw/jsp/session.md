## 로그인 로그아웃 
### member controller
```java
@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(@ModelAttribute MemberDTO member){
		
		String resultpage = ms.login(member);
		return resultpage;
	}
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {	
		session.invalidate();
		return "index";
	}
```

### member serviceImpl
```java
@Autowired
	private HttpSession session;
@Override
	public String login(MemberDTO member) {
		
		MemberDTO loginMember = mr.login(member);
		
		if(loginMember != null) {
			session.setAttribute("loginId", member.getM_id());
			session.setAttribute("loginNumber", member.getM_number());
			return "redirect:/board/paging";
		} else {
			return "/member/login";
		}
		
	}
```    
    
### 세션값 활용
```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${sessionScope.loginId eq 'admin'}">
<a href="/member/admin"> 관리자 페이지 이동 </a>

${sessionScope.loginId}

<c:if test="${sessionScope.loginId == null}">	
<input class="btn btn-outline-success btn-sm" onclick="Login()" value="구매">
</c:if> 
<c:if test="${sessionScope.loginId != null}">
</c:if>

<script>
function Login() {
	alert('로그인이 필요합니다')
	location.href='/member/login';
}
</script>
```
