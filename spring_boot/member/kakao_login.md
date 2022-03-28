## KakaoLogin
회원이 카카오 로그인을 한다 -> 카카오에 있는 이메일을 받아 온다 -> 이메일을 db에서 조회하여 정보가 있다면 로그인을 시켜주고, 없다면 회원가입 페이지로 이동한다.  

https://developers.kakao.com/  
에서 내 애플리케이션 > 애플리케이션 추가 > 제품설정 > 카카오톡 로그인 활성화> Redirect URL 등록  
ex)http://localhost:8094/member/login  
로그인 맵핑 경로를 지정 ex) @GetMapping("/login")  

### login.html
```javascript
<!-- 카카오 로그인 -->
<a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=198b13b4aad42557177244425bb771f9&redirect_uri=http://localhost:8093/member/login&response_type=code">로그인 </a>
```

### controller
```java
@GetMapping("/kakaologin")
    public String KaKaoLogin(@RequestParam(value = "code", required = false) String code, Model model,
                             HttpSession session) throws Exception {
        String access_Token = ms.getKaKaoAccessToken(code);
        String userInfo = ms.getUserInfo(access_Token);
        System.out.println("###access_Token#### : " + access_Token);
        System.out.println("###userInfo#### : " + userInfo);
        System.out.println("#########" + code);

        if(userInfo.equals("no")){
            model.addAttribute("msg","해당 이메일로 회원가입을 먼저 해주세요");
            model.addAttribute("member", new MemberSaveDTO());
            return "/member/save";
        } else {
            session.setAttribute(LOGIN_EMAIL, userInfo);
            Long loginId = ms.findByMemberId(userInfo);
            session.setAttribute("loginId", loginId);
            String redirectURL = (String) session.getAttribute("redirectURL");

            if (redirectURL != null){
                return "redirect:" + redirectURL;
            }else{
                return "redirect:/board/";
            }
        }
    }
```
### service

```java
package com.phl.cocolo.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import com.phl.cocolo.dto.MemberDetailDTO;
import com.phl.cocolo.dto.MemberLoginDTO;
import com.phl.cocolo.dto.MemberSaveDTO;
import com.phl.cocolo.dto.MemberUpdateDTO;
import com.phl.cocolo.entity.MemberEntity;
import com.phl.cocolo.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Override
    public String getKaKaoAccessToken(String code){
        String access_Token="";
        String refresh_Token ="";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try{
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=198b13b4aad42557177244425bb771f9"); // TODO REST_API_KEY 입력
            sb.append("&redirect_uri=http://localhost:8094/member/login"); // TODO 인가코드 받은 redirect_uri 입력
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //Gson 라이브러리에 포함된 클래스로 JSON 파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        }catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
    }
  @Override
    public String getUserInfo(String access_Token) {
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        String userEmail = null;
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            userEmail = kakao_account.getAsJsonObject().get("email").getAsString();

        } catch (IOException e) {
            e.printStackTrace();
        }

        // catch 아래 코드 추가.
        MemberEntity result = mr.findByMemberEmail(userEmail);
        //멤버테이블에서 정보가 있나 조회

        System.out.println("S:" + result);
        if (result == null) {
            //정보가 없으면 회원가입으로 넘어가게 함
            return "no";
        } else {
            return userEmail;
            // 정보가 이미 있으면 사용자의 이메일을 리턴함.
        }

    }
```
