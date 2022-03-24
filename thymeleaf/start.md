## thymeleaf란?

타임리프는 스프링 부트에서 공식적으로 지원하는 View 템플릿입니다.  
Servlet이 문서를 표현하는 방식인 JSP와 달리 Thymeleaf 문서는 html 확장자를 갖고 있어 서버 없이도 동작이 가능합니다.  

## thymeleaf 라이브러리 추가 후 상단  

\<html lang="en" xmlns:th="http://www.thymeleaf.org">

## 사용

서버에서 받아 온 변수 ${}  
객체 변숫값 *{}  
메시지 #{}  
링크 @{}  

th:text	문자열 생성	th:text="${data}"  
th:each	반복문	th:each="article : ${articleList}"  
th:if	if 조건문	th:if=${data != null}  
th:href	이동 경로	th:href="@{/article/list(id= ${data} )}"  

## 사용 예시 

#### 반복문으로 값 출력하기, 날짜 포맷, unless 조건문, onclick 자바스크립트 함수에 매개변수 넘기기
  
```html
 <tbody th:each="mentor,mentorStat:${mentorList}">
    <tr>
        <th scope="row" th:text="${mentorStat.count}"></th>
        <td th:text="${mentor.menteeCount+'/'+mentor.menteeMax}"></td>
        <td th:text="${mentor.mentoringPrice}"></td>
        <td th:text="*{#temporals.format(mentor.createTime, 'yyyy/MM/dd HH:mm')}"></td>
        <td>
            <button th:unless="${mentor.menteeCount==mentor.menteeMax}" type="button" class="btn btn-danger"
                    th:onclick="mentoringApply([[${mentor.menteeId}]])">
                멘토링 완료
            </button>
        </td>
    </tr>
 </tbody>
```

#### th:if strings.equals 사용
```html
<tbody>
  <tr th:each="room : ${rooms}">
      <form action="/mentoring/room" method="get" name="roomIn">
          <input type="hidden" name="roomId" th:value="${room.roomId}">
          <td><input type="button" class="btn btn-link btn-lg"
                     th:onclick="roomPwCheck([[${room.password}]])" th:value="${room.name}"></td>
      </form>
      <span th:if="(${#strings.equals(session['loginEmail'],'phl1021@naver.com')} or ${session.loginNick}==${room.chatMentor})">
  <td>
      <button type="button" class="btn btn-danger" th:onclick="deleteById([[${room.chatRoomId}]])">
          채팅방 삭제
      </button>
  </td>
  </span>
  </tr>
 </tbody>
```

#### th:field로 name id 생성 th:errors로 서버에서 받아온 에러메시지 출력

```html
 <form action="/member/save" id="contact-form" method="post" th:object="${member}"
      enctype="multipart/form-data" class="needs-validation">
    <div class="card-body p-0 my-3">
        <div class="row">
            <div class="col-md-6">
                <div class="input-group input-group-static mb-4">
                    <label for="memberName">이름</label>
                    <input id="memberName" class="form-control" type="text"
                           th:id="memberName" th:field="*{memberName}" placeholder="이름"
                           required>
                </div>
            </div>
            <div class="col-md-6 ps-md-2">
                <div class="input-group input-group-static mb-4">
                    <label for="memberNickName">닉네임</label>
                    <input class="form-control" type="text" id="memberNickName"
                           th:field="*{memberNickName}" placeholder="닉네임"
                           th:onblur="nickNameCheck()" required>
                    <p id="nickCheckResult"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="input-group input-group-static mb-4">
                    <label for="memberEmail">Email</label>
                    <input class="form-control" type="email" id="memberEmail"
                           th:field="*{memberEmail}" placeholder="hello@naver.com"
                           th:onblur="emailCheck()">
                    <div><p id="checkResult"></p></div>
                </div>
            </div>
        </div>
        <h6 class="text-danger" th:if="${#fields.hasErrors('memberEmail')}"
            th:errors="*{memberEmail}" th:errorclass="field-error"></h6>
        <div class="row">
            <div class="col-md-6">
                <div class="input-group input-group-static mb-4">
                    <label for="memberPassword">비밀번호</label>
                    <input class="form-control" type="password" id="memberPassword"
                           th:field="*{memberPassword}" placeholder="비밀번호">
                    <h6 class="text-danger" th:if="${#fields.hasErrors('memberPassword')}"
                       th:errors="*{memberPassword}" th:errorclass="field-error"></h6>
                </div>
            </div>
            <div class="col-md-6 ps-md-2">
                <div class="input-group input-group-static mb-4">
                    <label for="pwCheck">비밀번호 확인</label>
                    <input class="form-control" type="password" id="pwCheck"
                           placeholder="비밀번호" onblur="passwordCheck()">
                    <span id="pwCheckResult"></span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="input-group input-group-static mb-4">
                <label for="memberPhone">전화번호</label>
                <input class="form-control" type="text" id="memberPhone"
                       th:field="*{memberPhone}" placeholder="010-3333-3333">
                <h6 class="text-danger" th:if="${#fields.hasErrors('memberPhone')}"
                   th:errors="*{memberPhone}" th:errorclass="field-error"></h6>
            </div>
        </div>

        <div class="row">
            <div class="input-group input-group-static mb-4">
                <label for="memberProfile">프로필 사진 선택</label>
                <input class="file-selector-button" type="file" id="memberProfile"
                       th:field="*{memberProfile}">
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <label for="memberInteresting">관심있는 분야</label>
                <div class="input-group input-group-static mb-4">
                    <select class="form-select" id="memberInteresting"
                            th:field="*{memberInteresting}">
                        <option value="앱개발" selected>앱개발</option>
                        <option value="웹개발">웹개발</option>
                        <option value="게임개발">게임개발</option>
                        <option value="보안관련">보안관련</option>
                    </select>

                </div>
            </div>
            <div class="col-md-6 ps-md-2">
                <label for="memberLevel">개발자 레벨</label>
                <div class="input-group input-group-static mb-4">
                    <select class="form-select" id="memberLevel"
                            th:field="*{memberLevel}">
                        <option value="초보 개발자" selected>초보 개발자</option>
                        <option value="중급 개발자">중급 개발자</option>
                        <option value="고급 개발자">고급 개발자</option>
                        <option value="선생님">선생님</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 text-center">
                <input type="submit" class="btn bg-gradient-primary mt-3 mb-0"
                       value="가입하기">
            </div>
        </div>
    </div>
</form>
```




참고 https://developer-rooney.tistory.com/158
