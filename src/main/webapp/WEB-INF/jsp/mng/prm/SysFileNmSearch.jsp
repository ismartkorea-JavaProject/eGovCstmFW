<%-- 
  Class Name : SysFileNmSearch.jsp 
  Description : 프로그램 입력 화면
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
 <!-- Header -->
 <c:import url="/mng/main/SysIncHeader.do" />
 <!--// Header -->
 
<script type="text/javascript" src="<c:url value="/mng/cmmn/validator.do"/>"></script>
<validator:javascript formName="progrmManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script language="javascript1.2"  type="text/javaScript"> 
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.progrmManageForm.pageIndex.value = pageNo;
	document.progrmManageForm.action = "<c:url value='/mng/prm/SysProgramListSearch.do'/>";
   	document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */ 
function selectProgramListSearch() { 
	document.progrmManageForm.pageIndex.value = 1;
	document.progrmManageForm.action = "<c:url value='/mng/prm/SysProgramListSearch.do'/>";
	document.progrmManageForm.submit();
}

/* ********************************************************
 * 프로그램목록 선택 처리 함수
 ******************************************************** */ 
function choisProgramListSearch(vFileNm) {
    parent.fn_egov_returnValue(vFileNm);
}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}
//-->
</script>
 
    </head>
    <body class="sb-nav-fixed">
    
	<form name="progrmManageForm" action ="<c:url value='/mng/prm/SysProgramListSearch.do'/>" method="post">
	
	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
	
	<!-- 프로그램파일명 검색 팝업 -->
    <div class="popup POP_PRGFILE_SEARCH" style="background-color: white;">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>프로그램파일명 검색</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition2">
                    <label for="searchKeyword" class="lb mr10">프로그램파일명 : </label>
                    <span class="item f_search">
                        <input id="searchKeyword" class="f_input w_500" name="searchKeyword" type="text" value="" maxlength="60" title="검색조건">
                        <button class="btn" type="submit" onclick="javascript:selectProgramListSearch(); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                    </span>
                </div>
                <!--// 검색조건 -->

                <!-- 게시판 -->
                <div class="board_list">
                    <table summary="프로그램파일명 검색목록으로 프로그램파일명 프로그램명으로 구성됨">
                    	<caption>프로그램파일명 검색</caption>
                        <colgroup>
                            <col style="width: 30%;">
                            <col style="width: auto;">
                            <col style="width: 150px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">프로그램파일명</th>
                                <th scope="col">프로그램명</th>
                                <th scope="col">선택</th>
                            </tr>
                        </thead>
                        <tbody>
                        
                        	<c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
                            <tr>
                                <td><c:out value="${result.progrmFileNm}"/></td>
                                <td><c:out value="${result.progrmKoreanNm}"/></td>
                                <td><a href="#LINK" class="btn btn_blue_30 w_80" onclick="choisProgramListSearch('<c:out value="${result.progrmFileNm}"/>'); return false;">선택</a></td>
                            </tr>
                            </c:forEach>
                            
                        </tbody>
                    </table>
                </div>

				<!-- 페이지 네비게이션 시작 -->
                <div class="board_list_bot">
                    <div class="paging" id="paging_div">
                        <ul>
                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
                        </ul>
                    </div>
                </div>
                <!-- // 페이지 네비게이션 끝 -->
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!--// 프로그램파일명 검색 팝업 -->
    
    </form>
    
    </body>
</html>
