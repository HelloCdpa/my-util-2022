## c사용
```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```
### c:if 사용
```html
<c:if test="${sessionScope.loginId eq 'admin'}">
<a href="/member/admin"> 관리자 페이지 이동 </a>
</c:if>

<c:if test="${sessionScope.loginId == null}">	
</c:if> 

<c:if test="${sessionScope.loginId != null}">
</c:if>

${sessionScope.loginId}
```


### 반복문
```html

```
