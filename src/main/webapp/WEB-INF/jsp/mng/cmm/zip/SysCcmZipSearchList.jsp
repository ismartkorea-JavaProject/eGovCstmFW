<%-- 
  Class Name : SysCcmZipSearchList.jsp 
  Description : 공통 코드 관리 리스트 화면
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
 <!-- Header -->
 <c:import url="/mng/main/SysIncHeader.do" />
 <!--// Header -->

	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<title>우편번호 찾기</title>
<script type="text/javaScript" language="JavaScript">
<!--
/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function fn_egov_pageview(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/mng/cmm/zip/SysCcmZipSearchList.do'/>";
   	document.listForm.submit();
}
/* ********************************************************
 * 조회 처리 
 ******************************************************** */
function fn_egov_search_Zip(){
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
/* ********************************************************
 * 결과 우편번호,주소 반환 
 ******************************************************** */
function fn_egov_return_Zip(zip,addr){
	var retVal   = new Object();
	var sZip     = zip;
	var vZip     = zip.substring(0,3)+"-"+zip.substring(3,6);
	var sAddr    = addr.replace("/^\s+|\s+$/g","");
	retVal.sZip  = sZip;
	retVal.vZip  = vZip;
	retVal.sAddr = sAddr;
	
	parent.parent.fn_egov_returnValue(retVal);
}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.parent.fn_egov_modal_remove();
}
//-->
</script>
       
    </head>
    <body class="sb-nav-fixed">
    
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm" action="<c:url value='/mng/cmm/zip/SysCcmZipSearchList.do'/>" method="post">
    
    <input name="searchCondition" type="hidden" size="35" value="4" />

	<!-- 우편번호 찾기 팝업 -->
    <div class="popup POP_POST_SEARCH">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>우편번호 찾기</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition2">
                    <label for="" class="lb mr10">동 명 : </label>
                    <span class="item f_search">
                        <input class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${searchVO.searchKeyword}'/>" maxlength="20" title="동명"/>
                        <button class="btn" type="submit" onclick="javascript:fn_egov_search_Zip();"><spring:message code='button.inquire' /></button><!-- 조회 -->
                    </span>
                </div>
                <!--// 검색조건 -->

                <!-- 게시판 -->
                <div class="board_list">
                    <table summary="우편번호 건색 결과를 알려주는 테이블입니다.우편번호 및 주소 내용을 담고 있습니다">
                        <colgroup>
                            <col style="width: 30%;">
                            <col style="width: auto;">
                            <col style="width: 150px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">우편번호</th>
                                <th scope="col">주소</th>
                                <th scope="col">선택</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                            <tr>
                                <td><c:out value='${fn:substring(resultInfo.zip, 0,3)}'/>-<c:out value='${fn:substring(resultInfo.zip, 3,6)}'/></td>
                                <td class="al_l"><c:out value="${resultInfo.ctprvnNm}"/> <c:out value="${resultInfo.signguNm}"/> <c:out value="${resultInfo.emdNm}"/> <c:out value="${resultInfo.liBuldNm}"/> <c:out value="${resultInfo.lnbrDongHo}"/></td>
                                <td>
                                	<a href="#LINK" class="btn btn_blue_30 w_80" onclick="javascript:fn_egov_return_Zip( '<c:out value="${resultInfo.zip}"/>', '<c:out value="${resultInfo.ctprvnNm}"/> <c:out value="${resultInfo.signguNm}"/> <c:out value="${resultInfo.emdNm}"/> <c:out value="${resultInfo.liBuldNm}"/>');">
                                		선택
                                	</a>
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
                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_pageview" />
                        </ul>
                    </div>
                </div>
                <!-- // 페이지 네비게이션 끝 -->
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!--// 우편번호 찾기 팝업 -->
    
    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
    
	</form>
	
    </body>
</html>
