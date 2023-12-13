<%-- 
  Class Name : SysBoardMstrList.jsp 
  Description : 게시판 속성 목록화면
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

<title>내부업무 사이트 > 내부서비스관리 > 게시판생성관리</title>

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript">
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_brdMstr('1');
        }
    }
    
    function fn_egov_insert_addBrdMstr(){   
        document.frm.action = "<c:url value='/mng/bbs/addBBSMaster.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_select_brdMstr(pageNo){
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/mng/bbs/SelectBBSMasterInfs.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_inqire_brdMstr(bbsId){
        document.frm.bbsId.value = bbsId;
        document.frm.action = "<c:url value='/mng/bbs/SelectBBSMasterInf.do'/>";
        document.frm.submit();          
    }
</script>
       
    </head>
    <body class="sb-nav-fixed">
    
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
                                <li>게시판생성관리</li>
                            </ul>
                        </div>
                        <!--// Location -->
                        
                        <div class="card mb-4">

                                <h2 class="tit_2">게시판생성관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition">
                                
                                	<form name="frm" action="<c:url value='/mng/bbs/SelectBBSMasterInfs.do'/>" method="post">
                                	
                                	<input type="hidden" name="bbsId">
                                	<input type="hidden" name="trgetId">
                                	<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                                
                                    <label class="item f_select" for="searchCnd">
                                        <select id="searchCnd" name="searchCnd" title="검색유형선력">
                                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
                                            <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >게시판유형</option>
                                         </select>
                                    </label>

                                    <span class="item f_search">
                                        <input class="f_input w_500" title="검색값입력" id="searchWrd" name="searchWrd" type="text" value='<c:out value="${searchVO.searchWrd}" />' maxlength="35" onkeypress="press(event);">
                                        <button class="btn" type="submit" onclick="fn_egov_select_brdMstr('1'); return false;"><spring:message code="button.inquire"/></button><!-- 조회 -->
                                    </span>

                                    <a href="<c:url value='/mng/bbs/addBBSMaster.do'/>" class="item btn btn_blue_46 w_100" onclick="fn_egov_insert_addBrdMstr(); return false;"><spring:message code="button.create"/></a><!-- 등록 -->
                                    
                                    </form>
                                    
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="번호,게시판명,게시판유형,게시판속성,생성일,사용여부  목록입니다">
                                    	<caption>사용자목록관리</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">번호</th>
                                                <th scope="col">게시판명</th>
                                                <th scope="col">게시판유형</th>
                                                <th scope="col">게시판속성</th>
                                                <th scope="col">생성일</th>
                                                <th scope="col">사용여부</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        		<tr>
                                        			<td colspan="6"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="result" items="${resultList}" varStatus="status">
	                                            <tr>
	                                               <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
	                                                <td>
	                                                	<a href="<c:url value='/mng/bbs/SelectBBSMasterInf.do'/>?bbsId=<c:out value='${result.bbsId}'/>" class="lnk">
	                                                		<c:out value="${result.bbsNm}"/>
	                                                	</a>
	                                                </td>
	                                                <td><c:out value="${result.bbsTyCodeNm}"/></td>
	                                                <td><c:out value="${result.bbsAttrbCodeNm}"/></td>
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
                                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_brdMstr" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- // 페이지 네비게이션 끝 --> 
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
