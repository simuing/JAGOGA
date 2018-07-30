<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Cause</title>
</head>
<body>
	
	<span>
		<c:choose>
			<c:when test="${verificationCause==null}"> 사유없음 </c:when>
			<c:otherwise>${verificationCause }</c:otherwise>
		</c:choose>
	</span>

</body>
</html>