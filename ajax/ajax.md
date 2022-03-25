## jquery 
```
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
```
### 자바스크립트 값

#### getElementById  
const id = document.getElementById('memberId').value;  

#### querySelector
const email = document.querySelector('#memberEmail').value;  

#### jquery  
const password = $('#memberPassword').val();    
const name = '[[${member.memberName}]]'; // db에 있는 값 넘길 때  

#### id 가져오기
let valueById = $('#inputId').val();  

#### class 가져오기
let valueByClass = $('.inputClass').val();  

#### name 가져오기
let valueByName = $('input[name=inputName]').val();  

#### id가 test인 value 속성 값을 가져옴 
$('#test').attr('value');

#### id가 test인 속성의 src를 '/resources/img/img.png'로 바꾸기 
$('#test').attr('src','/resources/img/img.png');

#### id가 test인 disabled 속성을 disabled로 바꾸기
$('#test').attr('disabled','disabled');
  
### 사용예시
 
#### 1. json 
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
