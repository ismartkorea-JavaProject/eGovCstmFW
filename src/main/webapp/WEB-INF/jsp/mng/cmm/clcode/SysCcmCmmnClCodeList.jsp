<%-- 
  Class Name : SysCcmCmmnClCodeList.jsp 
  Description : 공통분류 코드 관리 리스트 화면
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
	
	<title>내부업무 사이트 > 내부시스템관리 > 분류코드관리</title>
		
	<script type="text/javaScript" language="javascript">
	<!--
	/* ********************************************************
	 * 페이징 처리 함수
	 ******************************************************** */
	function linkPage(pageNo){
	    document.listForm.pageIndex.value = pageNo;
	    document.listForm.action = "<c:url value='/mng/cmm/clcode/SysCcmCmmnClCodeList.do'/>";
	    document.listForm.submit();
	}
	/* ********************************************************
	 * 조회 처리 
	 ******************************************************** */
	function fnSearch(){
	    document.listForm.pageIndex.value = 1;
	    document.listForm.submit();
	}
	/* ********************************************************
	 * 등록 처리 함수 
	 ******************************************************** */
	function fnRegist(){
	    location.href = "<c:url value='/mng/cmm/clcode/SysCcmCmmnClCodeRegist.do'/>";
	}
	/* ********************************************************
	 * 수정 처리 함수
	 ******************************************************** */
	function fnModify(){
	    location.href = "";
	}
	/* ********************************************************
	 * 상세회면 처리 함수
	 ******************************************************** */
	function fnDetail(clCode){
	    var varForm              = document.all["Form"];
	    varForm.action           = "<c:url value='/mng/cmm/clcode/SysCcmCmmnClCodeDetail.do'/>";
	    varForm.clCode.value     = clCode;
	    varForm.submit();
	}
	/* ********************************************************
	 * 삭제 처리 함수
	 ******************************************************** */
	function fnDelete(){
	    // 
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
                                    <li>분류코드관리</li>
                                </ul>
                            </div>
                            <!--// Location -->

					<form name="listForm" action="<c:url value='/mng/cmm/clcode/SysCcmCmmnClCodeList.do'/>" method="post">

                            <h2 class="tit_2">분류코드관리</h2>
                            
                            <!-- 검색조건 -->
                            <div class="condition">
                                <label class="item f_select" for="sel1">
                                    <select id="sel1" name="searchCondition" title="검색조건" class="select">
                                        <option selected="" value="">선택하세요</option>
                                        <option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>분류코드</option>
                                        <option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>분류코드명</option>
                                     </select>
                                </label>
                                <span class="item f_search">
                                    <input class="f_input w_500" name="searchKeyword" title="검색어" type="text" value="<c:out value='${searchVO.searchKeyword}'/>" maxlength="35" id="searchKeyword" >
                                    <button class="btn" type="submit" onclick="fnSearch(); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                </span>

                                <a href="#LINK" class="item btn btn_blue_46 w_100" onclick="fnRegist(); return false;"><spring:message code='button.create' /></a><!-- 등록 -->
                            </div>
                            <!--// 검색조건 -->

                            <!-- 게시판 -->
                            <div class="board_list">
                                <table summary="분류코드, 분류코드명, 사용여부를 조회하는 공통분류코드 목록 테이블이다.">
                                	<caption>공통분류코드 목록</caption>
                                    <colgroup>
                                        <col style="width: 80px;">
                                        <col style="width: auto;">
                                        <col style="width: auto;">
                                        <col style="width: auto;">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">순번</th>
                                            <th scope="col">분류코드</th>
                                            <th scope="col">분류코드명</th>
                                            <th scope="col">사용여부</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	
                                    	<c:if test="${fn:length(resultList) == 0}">
                                    		<tr>
                                    			<td colspan=4><spring:message code="common.nodata.msg" /></td>
                                    		</tr>
                                    	</c:if>
                                    	
                                    	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                                        <tr>
                                            <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
                                            <td><a href="#LINK" class="lnk" onclick="javascript:fnDetail('<c:out value="${resultInfo.clCode}"/>');"><c:out value="${resultInfo.clCode}"/></a></td>
                                            <td><a href="#LINK" class="lnk" onclick="javascript:fnDetail('<c:out value="${resultInfo.clCode}"/>');"><c:out value="${resultInfo.clCodeNm}"/></a></td>
                                            <td>
                                            	<c:if test="${resultInfo.useAt == 'Y'}">사용</c:if>
                                            	<c:if test="${resultInfo.useAt == 'N'}">미사용</c:if>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                        
                                    </tbody>
                                </table>
                            </div>

							<!-- 페이지 네비게이션 시작 -->
                            <div class="board_list_bot">
                                <div class="paging" id="paging_div">
                                    <ul>
                                        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                                    </ul>
                                </div>
                            </div>
                            <!-- //페이지 네비게이션 끝 -->
                            <!--// 게시판 -->
                            
                            <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                            
                            </form>

				<form name="Form" method="post" action="<c:url value='/sym/ccm/ccc/EgovCcmCmmnClCodeDetail.do'/>">
					<input type=hidden name="clCode">
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
