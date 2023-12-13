<%-- 
  Class Name : SysLogInqire.jsp 
  Description : 로그 정보 상세조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.11.16   jeong       경량환경 버전 생성
 
    author   : s-onsystem
    since    : 2023.11.16 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <!-- Header -->
 <c:import url="/mng/main/SysIncHeader.do" />
 <!--// Header -->
 
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script> 
 
 <title>로그인 로그 상세</title>
 
<script type="text/javascript">

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

</script>
 
    </head>
    <body class="sb-nav-fixed">
    
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<form name="Form" method="post" action="#LINK" >
	
	<!-- 로그인 로그 정보 팝업 -->
    <div class="popup POP_LOGIN_LOG">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>로그인 로그 정보</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <div class="board_view2">
                    <table>
                        <colgroup>
                            <col style="width: 190px;">
                            <col style="width: auto;">
                        </colgroup>
                        <tr>
                            <td class="lb">
                                <span class="min">로그ID</span>
                            </td>
                            <td><c:out value="${result.logId}"/></td>
                        </tr>
                        <tr>
                            <td class="lb">
                                <span class="min">발생일자</span>
                            </td>
                            <td><c:out value="${result.creatDt}"/></td>
                        </tr>
                        <tr>
                            <td class="lb">
                                <span class="min">로그유형</span>
                            </td>
                            <td><c:out value="${result.loginMthd}"/></td>
                        </tr>
                        <tr>
                            <td class="lb">
                                <span class="min">요청자</span>
                            </td>
                            <td><c:out value="${result.loginNm}"/></td>
                        </tr>
                        <tr>
                            <td class="lb">
                                <span class="min">요청자IP</span>
                            </td>
                            <td><c:out value="${result.loginIp}"/></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!--// 로그인 로그 정보 팝업 -->
    
    </form>
    </body>
</html>
