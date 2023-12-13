<%-- 
  Class Name : codeViewList.jsp 
  Description : 코드 관리 리스트 화면
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
    </head>
    <body class="sb-nav-fixed">
    
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
                        <h1 class="mt-4">사용자 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">사용자 리스트</li>
                        </ol>
                        <div class="row">
						</div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                데이타 리스트
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th scope="col">아이디</th>
                                            <th scope="col">이름</th>
                                            <th scope="col">이메일</th>
                                            <th scope="col">전화번호</th>
                                            <th scope="col">등록일</th>
                                            <th scope="col">가입상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <c:if test="${fn:length(resultList) == 0}">
                                     	<tr>
                                     		<td colspan="8" ><c:out value='${fn:length(resultList)}'/></td>
                                     	</tr>
                                       </c:if>
									   <c:forEach var="result" items="${resultList}" varStatus="status">                                        	                                    
                                        <tr>
                                             <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
                                             <td>
                                                 <span class="f_chk_only">
                                                     <input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
                                                     <input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
                                                 </span>
                                             </td>
                                             <td>
                                              <a href="<c:url value='/mng/usr/SysUserSelectUpdtView.do'/>?selectedId=<c:out value="${result.uniqId}"/>" class="lnk" onclick="javascript:fnSelectUser('<c:out value="${result.userTy}"/>:<c:out value="${result.uniqId}"/>'); return false;">
                                              	<c:out value="${result.userId}"/>
                                              </a>
                                             </td>
                                             <td><c:out value="${result.userNm}"/></td>
                                             <td><c:out value="${result.emailAdres}"/></td>
                                             <td><c:out value="${result.areaNo}"/>)<c:out value="${result.middleTelno}"/>-<c:out value="${result.endTelno}"/></td>
                                             <td><c:out value="${result.sbscrbDe}"/></td>
                                             <td>
                                             	<c:forEach var="emplyrSttusCode_result" items="${emplyrSttusCode_result}" varStatus="status">
                                             		<c:if test="${result.sttus == emplyrSttusCode_result.code}"><c:out value="${emplyrSttusCode_result.codeNm}"/></c:if>
                                             	</c:forEach>
                                             </td>
                                        </tr>
                                        </c:forEach>
                                        <tfoot>                                        
                                        </tfoot>
                                    </tbody>
                                </table>
                            </div>
								<!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty userAbsnceVO.pageIndex }">
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fnLinkPage" />
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
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
