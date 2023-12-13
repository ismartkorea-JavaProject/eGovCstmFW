<%-- 
  Class Name : SysTemplateList.jsp 
  Description : 템플릿 목록화면
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

<script type="text/javascript">
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_tmplatInfo('1');
        }
    }

    function fn_egov_insert_addTmplatInfo(){    
        document.frm.action = "<c:url value='/mng/bbs/com/addTemplateInf.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_select_tmplatInfo(pageNo){
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/mng/bbs/com/selectTemplateInfs.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_inqire_tmplatInfor(tmplatId){
        document.frm.tmplatId.value = tmplatId;
        document.frm.action = "<c:url value='/mng/bbs/com/selectTemplateInf.do'/>";
        document.frm.submit();          
    }
</script>

<title>내부업무 사이트 > 내부서비스관리 > 게시판템플릿목록</title>
       
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
                                <li><a href="">내부서비스관리</a></li>
                                <li><a href="">내부업무게시판관리</a></li>
                                <li>게시판템플릿관리</li>
                            </ul>
                        </div>
                        <!--// Location -->
                        
                        <div class="card mb-4">

                                <h2 class="tit_2">게시판템플릿관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition">
                                
                                	<form name="frm" action ="<c:url value='/mng/bbs/com/selectTemplateInfs.do'/>" method="post">
			                        
			                        <input type="hidden" name="tmplatId" value="" />
			                        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                                
                                    <label class="item f_select" for="sel1">
                                        <select id="sel1" name="searchCnd" title="검색조건" class="select">
                                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >템플릿명</option>
                                            <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >템플릿구분</option>
                                         </select>
                                    </label>

                                    <span class="item f_search">
                                        <input class="f_input w_500" name="searchWrd" title="검색어" type="text" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);">
                                        <button class="btn" type="submit" onclick="javascript:fn_egov_select_tmplatInfo('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>

                                    <a href="<c:url value='/mng/bbs/com/addTemplateInf.do'/>" class="item btn btn_blue_46 w_100" onclick="javascript:fn_egov_insert_addTmplatInfo(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
                                    
                                    </form>
                                    
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="번호,게시판 명,사용 커뮤니티 명,사용 동호회 명,등록일시,사용여부  목록입니다">
                                    	<caption>게시판 템플릿 목록</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: 150px;">
                                            <col style="width: 130px;">
                                            <col style="width: auto;">
                                            <col style="width: 100px;">
                                            <col style="width: 150px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">번호</th>
                                                <th scope="col">템플릿명</th>
                                                <th scope="col">템플릿구분</th>
                                                <th scope="col">템플릿경로</th>
                                                <th scope="col">사용여부</th>
                                                <th scope="col">등록일자</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(resultList) == 0}">
	                                        	<tr>
	                                        		<td colspan="6" ><spring:message code="common.nodata.msg" /></td>
	                                        	</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="result" items="${resultList}" varStatus="status">
	                                            <tr>
	                                                <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
	                                                <td>
	                                                	<a href="<c:url value='/mng/bbs/com/selectTemplateInf.do'/>?tmplatId=<c:out value='${result.tmplatId}'/>" class="lnk">
	                                                		<c:out value="${result.tmplatNm}"/>
	                                                	</a>
	                                                </td>
	                                                <td><c:out value="${result.tmplatSeCodeNm}"/></td>
	                                                <td class="al"><c:out value="${result.tmplatCours}"/></td>
	                                                <td>
	                                                	<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
	                                                	<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
	                                                </td>
	                                                <td><c:out value="${result.frstRegisterPnttm}"/></td>
	                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_tmplatInfo"  />
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
