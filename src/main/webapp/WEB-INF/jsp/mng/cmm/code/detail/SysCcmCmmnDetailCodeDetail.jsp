<%-- 
  Class Name : SysCcmCmmnDetailCodeDetail.jsp 
  Description : 공통상세코드 상세 화면
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
 
<title>내부업무 사이트 > 내부시스템관리 > 상세코드관리</title>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fnList(){
    location.href = "<c:url value='/mng/cmm/code/SysCcmCmmnDetailCodeList.do'/>";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fnModify(){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/mng/cmm/code/SysCcmCmmnDetailCodeModify.do'/>";
    varForm.codeId.value     = "${result.codeId}";
    varForm.code.value       = "${result.code}";
    varForm.cmd.value        = "Modify";
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    if (confirm("<spring:message code='common.delete.msg'/>")) {
        var varForm              = document.all["Form"];
        varForm.action           = "<c:url value='/mng/cmm/code/SysCcmCmmnDetailCodeRemove.do'/>";
        varForm.codeId.value     = "${result.codeId}";
        varForm.code.value       = "${result.code}";
        varForm.submit();
    }
}
//-->
</script>
 
    </head>
    <body class="sb-nav-fixed">
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>    
    
    
        <!-- Menu Navi -->
        <c:import url="/mng/main/SysIncNavi.do" />
        <!--// Menu Navi -->
        
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
		        <!-- Menu Navi -->
		        <c:import url="/mng/main/SysIncMenuLeft.do" />
		        <!--// Menu Navi -->
            </div>
            <!-- 메인 부분 -->
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                         <!-- Location -->
                        <div class="location">
                            <ul>
                                <li><a class="home" href="">Home</a></li>
                                <li><a href="">내부시스템관리</a></li>
                                <li><a href="">사용자관리</a></li>
                                <li>사용자등록관리</li>
                            </ul>
                        </div>
                        <!--// Location -->                    
                    
							<!--<div style="height: 100vh">-->

								<form name="Form" method="post" action="<c:url value='/mng/cmm/code/SysCcmCmmnDetailCodeList.do'/>">
								
								<input type="hidden" name="codeId">
								<input type="hidden" name="code">

                                <h2 class="tit_2">상세코드관리</h2>
                                
                                <div class="board_view2">
                                    <table summary="코드ID명, 코드, 코드명, 코드설명, 사용여부가 나타나 있는 공통상세코드 상세조회 테이블이다.">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="codeIdNm">코드ID</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.codeIdNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">코드</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.code}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">코드명</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.codeNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="codeDc">코드설명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <textarea class="f_txtar w_full h_80" cols="30" rows="10" id="codeDc"><c:out value="${result.codeDc}"/></textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="useAt">사용여부</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="useAt">
                                                    <select id="useAt" name="useAt">
                                                        <option value="Y" <c:if test="${result.useAt == 'Y'}">selected="selected"</c:if> >Yes</option>
                                                        <option value="N" <c:if test="${result.useAt == 'N'}">selected="selected"</c:if> >No</option>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    	<c:if test="${result.useAt == 'Y'}">
                                        	<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="fnDelete(); return false;"><spring:message code='button.delete' /></a><!-- 삭제 -->
                                        </c:if>
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fnModify(); return false;"><spring:message code='button.update' /></a><!-- 수정 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fnList(); return false;"><spring:message code='button.list' /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input name="cmd" type="hidden" value="<c:out value='save'/>"/>
                                
                                </form>						
							
							<!--</div> -->

                    </div>
                </main>
                <!-- 메인 화면 부분 -->
		        <!-- Footer -->
		        <c:import url="/mng/main/SysIncFooter.do" />
		        <!--// Footer -->
            </div>
        </div>
		        <!-- Scripts -->
		        <c:import url="/mng/main/SysIncScripts.do" />
		        <!--// Scripts -->
    </body>
</html>
