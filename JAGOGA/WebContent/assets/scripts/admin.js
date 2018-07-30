/* 현재 시간을 출력해주는 함수 */
function printTime()
{
	// 출력할 장소 선택
	var clock = document.getElementById("clock");
	
	// 현재시간
	var now = new Date();
	var nowTime = now.getFullYear() + "년" + (now.getMonth()+1) + "월" + now.getDate()
			+ "일" + now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
	
	// 현재시간을 출력
	clock.innerHTML = nowTime;           
	
	// setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
	setTimeout("printTime()",1000);         
}
window.onload = function()
{
	// 페이지가 로딩되면 현재시간 출력함수 실행
	printTime();
}



/* 고객센터 FAQ 탭별 조회 함수 */
function openCity(evt, cityName) 
{
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) 
    {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) 
    {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}
// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
