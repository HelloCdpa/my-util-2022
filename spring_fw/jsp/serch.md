### jsp

```html
<form class="row g-3 container text-center" style="margin-top: 100px;" action="/board/search" method="get">
  <div class="col-auto" >
    <select class="form-select" style="width:100px;height:40px; display:inline;" name="searchtype">
      <option value="b_title">제목</option>
      <option value="m_id">작성자</option>
    </select>
  </div>

  <div class="col-auto">
    <input class="form-control"  type="text" name="keyword">
  </div>

  <div class="col-auto">
    <input class="form-control"  type="submit" value="검색">
  </div>
</form>
```
### controller

```java
@RequestMapping(value="search", method=RequestMethod.GET)
	public String search(@RequestParam("searchtype") String searchtype,
			@RequestParam("keyword") String keyword, Model model) {
		List<BoardDTO> bList = bs.search(searchtype, keyword);
		model.addAttribute("bList", bList);
		
		return "/board/boardFindAll";
	}
```
### serviceImpl 
- 검색종류와 키워드 두 값을 넘겨야 해서 Map으로 담음
```java
@Override
	public List<BoardDTO> search(String searchtype, String keyword) {
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("type", searchtype);
		searchParam.put("word", keyword);
		List<BoardDTO> bList = br.search(searchParam);
		return bList;
	}
```	
	
### repository

```java
public List<BoardDTO> search(Map<String, String> searchParam) {
		return sql.selectList("Board.search", searchParam);
	}
```

###  mapper
- like 연산자 (% 와일드 카드)를 사용 할 때 concat을 붙여줘야 한다!
```xml
<select id="search" parameterType="java.util.HashMap" resultType="board">
		select * from board_table
		<include refid="sear"></include>
	</select>

	<sql id="sear">
		<choose>
			<when test="type=='b_title'">
				where b_title like concat ('%', #{word}, '%')
			</when>

			<when test="type=='m_id'">
				where m_id like concat ('%', #{word}, '%')
			</when>
		</choose>
	</sql>
  ```
