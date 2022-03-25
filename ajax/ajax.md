## jquery 
```
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
```

  1. const id = document.getElementById('memberId').value;
  2. const email = document.querySelector('#memberEmail').value;
  3. const password = $('#memberPassword').val();
  4. const name = '[[${member.memberName}]]'; // db에 있는 값 넘길 때
  
  ### 사용예시
  1. json 
  ```javascript
   <script>
        const memberUpdate = () => {
            const id = document.getElementById('memberId').value;
            //쿼리셀렉터는 모든 값에 다 접근하기 때문에 클래스는 . 아이디는 #
            const email = document.querySelector('#memberEmail').value;
            const password = $('#memberPassword').val();
            const name = document.querySelector('#memberName').value;
            console.log(id,email,password,name);
			
            //javascript object(자바스크립트 객체)에 담아서 ajax로 컨트롤러에 보내기 위한 세팅
            const updateData = JSON.stringify({
               memberId : id, /*memberId : document.getElementById('memberId').value;*/
               memberEmail : email,
               memberPassword : password,
               memberName : name
            });
            const reqUrl = "/member/"+id;
            console.log(updateData);
			
            $.ajax({
                type:'put',
                data: updateData,
                url: reqUrl,
                contentType : "application/json", // json 으로 보낼 때는 꼭 써야 함
                success: function (){
                    location.href = "/member/"+id;
                },
                error:function (){
                    alert('실패')
                }
            })
        }
    </script>
  ```
