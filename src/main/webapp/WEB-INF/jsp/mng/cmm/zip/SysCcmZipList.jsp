<%-- 
  Class Name : SysCcmZipList.jsp 
  Description : 우편번호 관리 리스트 화면
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
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/mng/cmm/zip/SysCcmZipList.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){
    sC = document.listForm.searchCondition.value;
    sK = document.listForm.searchKeyword.value; 
    if (sC == "1") {
        document.listForm.searchKeyword.value = sK.replace(/\-/, "");
    }
    document.listForm.pageIndex.value = 1;
    document.listForm.submit();
}
/* ********************************************************
 * 등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_Zip(){
    location.href = "<c:url value='/mng/cmm/zip/SysCcmZipRegist.do'/>";
}
/* ********************************************************
 * 엑셀등록 처리 함수 
 ******************************************************** */
function fn_egov_regist_ExcelZip(){
    location.href = "<c:url value='/mng/cmm/zip/SysCcmExcelZipRegist.do'/>";
}
/* ********************************************************
 * 수정 처리 함수
 ******************************************************** */
function fn_egov_modify_Zip(){
    location.href = "";
}
/* ********************************************************
 * 상세회면 처리 함수
 ******************************************************** */
function fn_egov_detail_Zip(zip,sn){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/mng/cmm/zip/SysCcmZipDetail.do'/>";
    varForm.zip.value        = zip;
    varForm.sn.value         = sn;
    varForm.submit();
}
//-->
</script>
       
    </head>
    <body class="sb-nav-fixed">
    
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>    
    
        <!-- Navi -->
        <c:import url="/mng/main/SysIncNavi.do" />
        <!--// Navi -->
        
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">

		        <!-- Menu -->
		        <c:import url="/mng/main/SysIncMenuLeft.do" />
		        <!--// Menu -->
		        
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

								<form name="listForm" action="<c:url value='/mng/cmm/zip/SysCcmZipList.do'/>" method="post">

                                <h2 class="tit_2">우편번호관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition">
                                    <label class="item f_select" for="sel1">
                                        <select id="sel1" name="searchCondition" class="select" title="searchCondition">
                                            <option selected="" value="">선택하세요</option>
                                            <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>우편번호</option>
                                            <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>시도명</option>
                                            <option value='3' <c:if test="${searchVO.searchCondition == '3'}">selected="selected"</c:if>>시군구명</option>
                                            <option value='4' <c:if test="${searchVO.searchCondition == '4'}">selected="selected"</c:if>>읍면동명</option>
                                            <option value='5' <c:if test="${searchVO.searchCondition == '5'}">selected="selected"</c:if>>리건물명</option>
                                        </select>
                                    </label>
                                    <span class="item f_search">
                                        <input class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${searchVO.searchKeyword}'/>" maxlength="35" id="searchKeyword">
                                        <button class="btn" type="submit" onclick="fn_egov_search_Zip(); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <div class="board_list_top">
                                    <div class="left_col">
                                    </div>

                                    <div class="right_col">
                                        <a href="#LINK" class="item btn btn_blue_46 w_100" onclick="fn_egov_regist_Zip(); return false;"><spring:message code='button.create' /></a><!-- 등록 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fn_egov_regist_ExcelZip(); return false;">엑셀등록</a><!-- 엑셀등록 -->
                                    </div>
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="우편번호와 주소를 출력하는 우편번호 목록 테이블이다.">
                                    	<caption>공통코드 목록</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">순번</th>
                                                <th scope="col">우편번호</th>
                                                <th scope="col">주소</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        		<tr>
                                        			<td colspan=3><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                            <tr>
                                                <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
                                                <td><a href="#LINK" class="lnk" onclick="javascript:fn_egov_detail_Zip('${resultInfo.zip}','${resultInfo.sn}');"><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></a></td>
                                                <td><c:out value="${resultInfo.ctprvnNm}"/> <c:out value="${resultInfo.signguNm}"/> <c:out value="${resultInfo.emdNm}"/> <c:out value="${resultInfo.liBuldNm}"/> <c:out value="${resultInfo.lnbrDongHo}"/></td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_pageview" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- // 페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
                                
                                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                                
                                </form>

								<form name="Form" method="post" action="<c:url value='/mng/cmm/zip/SysCcmZipDetail.do'/>">
								    <input type="hidden" name="zip">
								    <input type="hidden" name="sn">
								</form>
						
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
