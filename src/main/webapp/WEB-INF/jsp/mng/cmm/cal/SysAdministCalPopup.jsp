<!DOCTYPE html>
<%
 /**
  * @Class Name  : SysAdministCalPopup.jsp
  * @Description : SysAdministCalPopup 화면
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
<title>행정달력</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/sym/cal/cal.css' />" />
<script type="text/javaScript" language="javascript">
<!--
-->
</script>
</head>
<form name="pForm">
<input type="hidden" name="init" value="">
</form>
<!-- IE
<iframe name="ifcal" src="<c:url value='/mng/cmm/cal/SysselectAdministCalendar.do'/>" style="width:252px; height:175px;" frameborder=0></iframe>
-->
<!-- FIREFOX -->
<iframe name="ifcal" src="<c:url value='/mng/cmm/cal/SysselectAdministCalendar.do'/>" style="width:290px; height:191px;" frameborder=0 title="달력팝업창호출"></iframe>
