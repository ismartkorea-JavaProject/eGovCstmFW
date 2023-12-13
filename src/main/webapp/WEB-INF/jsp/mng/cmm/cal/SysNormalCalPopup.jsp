<!DOCTYPE html>
<%
 /**
  * @Class Name  : SysNormalCalPopup.jsp
  * @Description : SysNormalCalPopup 화면
  * @Modification Information
  *
  * 수정일         수정자                   수정내용
  * -------    --------    ---------------------------
  * 2023.11.16   jeong       경량환경 버전 생성
  * 
  * @author   : s-onsystem
  * @since    : 2023.11.16 
  *
  */
%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html lang="ko">
<head>
<title>일반달력</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<script type="text/javaScript" language="javascript">
</script>
<style TYPE="text/css">
form {
margin :0px 0px 0px 0px;
}
iframe {
margin :0px 0px 0px 0px;
}
</style>
</head>
<body topmargin="0" leftmargin="0" style="margin :0px;">

<iframe name="ifcal" src="<c:url value='/mng/cmm/cal/SysselectNormalCalendar.do'/>" style="width:275px; height:192px;" frameborder="0" scrolling="no" title="달력팝업창호출"></iframe>

</body>
</html>
