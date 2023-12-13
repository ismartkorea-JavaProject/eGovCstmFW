<%-- 
  Class Name : SysCcmCmmnCodeDetail.jsp 
  Description : 공통 코드 상세 화면
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
 
<title>내부업무 사이트 > 내부시스템관리 > 우편번호관리</title>
 
<link type="text/css" rel="stylesheet" href="/css_old/com.css">
<link href="<c:url value='/css_old/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
    location.href = "<c:url value='/mng/cmm/zip/SysCcmZipList.do'/>";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fn_egov_modify_Zip(){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/mng/cmm/zip/SysCcmZipModify.do'/>";
    varForm.zip.value        = "${result.zip}";
    varForm.sn.value         = "${result.sn}";
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fn_egov_delete_Zip(){
    if (confirm("<spring:message code='common.delete.msg'/>")) {
        var varForm              = document.all["Form"];
        varForm.action           = "<c:url value='/mng/cmm/zip/SysCcmZipRemove.do'/>";
        varForm.zip.value        = "${result.zip}";
        varForm.sn.value         = "${result.sn}";
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
                                        <li><a href="">코드관리</a></li>
                                        <li>우편번호관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="Form" method="post" action="<c:url value='/mng/cmm/zip/SysCcmZipModify.do'/>">
								
								<input type="hidden" name="zip">
								<input type="hidden" name="sn">

                                <h2 class="tit_2">우편번호관리</h2>

                                <div class="board_view2">
                                    <table summary="우편번호, 시도명, 시군구명, 읍면동명, 리건물명, 번지동호를 가지고 있는 우편번호 상세조회 테이블이다.">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">우편번호</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value='${fn:substring(result.zip, 0,3)}'/>-<c:out value='${fn:substring(result.zip, 3,6)}'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">시도명</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.ctprvnNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">시군구명</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.signguNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">읍면동명</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.emdNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">리건물명</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.liBuldNm}"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">번지동호</span>
                                            </td>
                                            <td>
                                            	<c:out value="${result.lnbrDongHo}"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="fn_egov_delete_Zip(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_modify_Zip(); return false;"><spring:message code="button.update" /></a><!-- 수정 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_list_Zip(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input name="codeId" type="hidden">
                                
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
