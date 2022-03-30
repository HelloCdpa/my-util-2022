```html
<label for="m_id" class="text-start">아이디</label> 
<input class="form-control" type="text" name="m_id" id="m_id" placeholder="아이디 20자이내" onblur="idDuplicate()"> 
<span id="m_id-dup-check"> </span><br>
ajax는 제이쿼리 사용

<script src="https://code.jquery.com/jquery-3.6.0.js"></script> 
<script>
// 아이디 입력을 하는 동안에 idDuplicate() 함수를 호출하고 입력된 값을 콘솔에 출력
    function idDuplicate() {
        const id = document.getElementById('m_id').value
        const checkResult = document.getElementById('id-dup-check')
$.ajax({
	type : 'post', //(get, post, delet, put)
	url : 'idDuplicate',
	data : {'m_id' : id},
	dataType : 'text',
	success : function(result){
		if(result == "ok") {
			checkResult.style.color = 'green';
			checkResult.innerHTML = '멋진 아이디네요';
		}else {
			checkResult.style.color = 'red';
			checkResult.innerHTML = '이미 사용중인 아이디';
		}
	},
	error : function(){
		console.log('오타 찾으세요')
	}
	
});
</script>
```
serviceImpl
```java
@ResponseBody : jsp가 아닌 실제 값을 리턴시켜줌
@RequestMapping(value = "idDuplicate", method = RequestMethod.POST)
	public @ResponseBody String idDuplicate(@RequestParam ("m_id") String m_id) {
		
		String result = ms.idDuplicate(m_id); 
        
		return result;
	}
repository

public String idDuplicate(String m_id) {
 return sql.selectOne("Member.idDuplicate", m_id);
}
mapper

<select id="idDuplicate" parameterType="String" resultType="String" >

 select m_id from member_table where m_id=#{m_id}
 
 </select>
 ```
