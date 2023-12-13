<%-- 
  Class Name : SysBoardUseInfList.jsp 
  Description : 게시판  사용정보  목록화면
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

<title>내부업무 사이트 > 내부서비스관리 > 게시판사용관리</title>

<script type="text/javascript">
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_bbsUseInfs('1');
        }
    }

    function fn_egov_select_bbsUseInfs(pageNo){
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/mng/bbs/com/selectBBSUseInfs.do'/>";
        document.frm.submit();
    }
    function fn_egov_insert_addbbsUseInf(){
        document.frm.action = "<c:url value='/mng/bbs/com/addBBSUseInf.do'/>";
        document.frm.submit();      
    }
    function fn_egov_select_bbsUseInf(bbsId, trgetId){
        document.frm.bbsId.value = bbsId;
        document.frm.trgetId.value = trgetId;
        document.frm.action = "<c:url value='/mng/bbs/com/selectBBSUseInf.do'/>";
        document.frm.submit();
    }

</script>
       
    </head>
    <body class="sb-nav-fixed">
    
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                               <li><a href="">내부서비스관리</a></li>
                               <li><a href="">내부업무게시판관리</a></li>
                               <li>게시판사용관리</li>
                           </ul>
                       </div>
                       <!--// Location -->
                        
                        <div class="card mb-4">

                                <h2 class="tit_2">게시판사용관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition">
                                	
                                	<form name="frm" method="post" action = "<c:url value='/mng/bbs/com/selectBBSUseInf.do'/>">
                                	
									<input type="hidden" name="bbsId" >
									<input type="hidden" name="trgetId" >
			                        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                                	
                                    <label class="item f_select" for="sel1">
                                        <select id="sel1" name="searchCnd" title="검색유형선력">
                                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
                                         </select>
                                    </label>

                                    <span class="item f_search">
                                        <input name="searchWrd" class="f_input w_500" type="text" title="명" value='<c:out value="${searchVO.searchWrd}" />' maxlength="35" onkeypress="press(event);">
                                        <button class="btn" type="submit" onclick="fn_egov_select_bbsUseInfs('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>

                                    <a href="<c:url value='/mng/bbs/com/addBBSUseInf.do'/>" class="item btn btn_blue_46 w_100" onclick="fn_egov_insert_addbbsUseInf(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
                                	
                                	</form>
                                	
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="번호,게시판명,사용 커뮤니티 명,사용 동호회 명,등록일시,사용여부  목록입니다">
                                    	<caption>사용자목록관리</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                            <col style="width: 180px;">
                                            <col style="width: 150px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">번호</th>
                                                <th scope="col">게시판명</th>
                                                <th scope="col">사용 커뮤니티 명</th>
                                                <th scope="col">사용 동호회 명</th>
                                                <th scope="col">등록일시</th>
                                                <th scope="col">사용여부</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        		<tr>
                                        			<td nowrap colspan="6"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="result" items="${resultList}" varStatus="status">
	                                            <tr>
	                                                <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
	                                                <td>
	                                                	<input type=hidden name="bbsId" value="<c:out value="${result.bbsId}"/>">
	                                                	<input type=hidden name="trgetId" value="<c:out value="${result.trgetId}"/>">
	                                                	<a href="<c:url value='/mng/bbs/com/selectBBSUseInf.do'/>?bbsId=<c:out value='${result.bbsId}'/>&amp;trgetId=<c:out value='${result.trgetId}'/>" class="lnk">
	                                                		<c:out value="${result.bbsNm}"/>
	                                                	</a>
	                                                </td>
	                                                <td><c:out value="${result.cmmntyNm}"/></td>
	                                                <td><c:out value="${result.clbNm}"/></td>
	                                                <td><c:out value="${result.frstRegisterPnttm}"/></td>
	                                                <td>
	                                                	<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
	                                                	<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
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
                                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_bbsUseInfs" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- //페이지 네비게이션 끝 --> 
                                <!--// 게시판 -->
                        </div>						
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
