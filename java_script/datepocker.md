### 데이트 피커를 시작일과 종료일을 비교해서 시작일 > 종료일을 선택하지 않게 막아주는 자바스크립트 

``` javascript
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
//달력을 표시할 startDate, endDate 에 해당하는 inputbox 추가.
<input type="text" id="startDate"/>
<input type="text" id="endDate"/>
//datepicker 적용.
<script type="text/javascript">
$(document).ready(function () {
	$("#startDate").datepicker({
		dateFormat: "yy-mm-dd", // 날짜의 형식
		minDate: 0,
		nextText: ">",
		prevText: "<",
		onSelect: function (date) {
			var endDate = $('#endDate');
			var startDate = $(this).datepicker('getDate');
			var minDate = $(this).datepicker('getDate');
			endDate.datepicker('setDate', minDate);
			startDate.setDate(startDate.getDate() + 30);
			endDate.datepicker('option', 'maxDate', startDate);
			endDate.datepicker('option', 'minDate', minDate);
		}
	});
	$('#endDate').datepicker({
		dateFormat: "yy-mm-dd", // 날짜의 형식
		nextText: ">",
		prevText: "<"
	});
});
</script>
```
