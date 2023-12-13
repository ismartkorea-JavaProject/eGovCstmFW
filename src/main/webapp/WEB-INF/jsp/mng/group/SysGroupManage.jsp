<%-- 
  Class Name : SysGroupManage.jsp 
  Description : 그룹 관리 조회 화면
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
<%@ page import="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
 <!-- Header -->
 <c:import url="/mng/main/SysIncHeader.do" />
 <!--// Header -->
 
 	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	
	<title>내부업무 사이트 > 내부시스템관리 > 사용자그룹관리</title>	
 
        <script type="text/javaScript" language="javascript" defer="defer">
		function fncCheckAll() {
		    var checkField = document.listForm.delYn;
		    if(document.listForm.checkAll.checked) {
		        if(checkField) {
		            if(checkField.length > 1) {
		                for(var i=0; i < checkField.length; i++) {
		                    checkField[i].checked = true;
		                }
		            } else {
		                checkField.checked = true;
		            }
		        }
		    } else {
		        if(checkField) {
		            if(checkField.length > 1) {
		                for(var j=0; j < checkField.length; j++) {
		                    checkField[j].checked = false;
		                }
		            } else {
		                checkField.checked = false;
		            }
		        }
		    }
		}

		function fncManageChecked() {

		    var checkField = document.listForm.delYn;
		    var checkId = document.listForm.checkId;
		    var returnValue = "";
		    var returnBoolean = false;
		    var checkCount = 0;

		    if(checkField) {
		        if(checkField.length > 1) {
		            for(var i=0; i<checkField.length; i++) {
		                if(checkField[i].checked) {
		                    checkCount++;
		                    checkField[i].value = checkId[i].value;

		                    if(returnValue == "")
		                        returnValue = checkField[i].value;
		                    else
		                        returnValue = returnValue + ";" + checkField[i].value;
		                }
		            }
		            if(checkCount > 0)
		                returnBoolean = true;
		            else {
		                alert("선택된  그룹이 없습니다.");
		                returnBoolean = false;
		            }
		        } else {
		             if(document.listForm.delYn.checked == false) {
		                alert("선택된 그룹이 없습니다.");
		                returnBoolean = false;
		            }
		            else {
		                returnValue = checkId.value;
		                returnBoolean = true;
		            }
		        }
		    } else {
		        alert("조회된 결과가 없습니다.");
		    }

		    document.listForm.groupIds.value = returnValue;

		    return returnBoolean;
		}

		function fncSelectGroupList(pageNo){
		    document.listForm.searchCondition.value = "1";
		    document.listForm.pageIndex.value = pageNo;
		    document.listForm.action = "<c:url value='/mng/grp/SysGroupList.do'/>";
		    document.listForm.submit();
		}

		function fncSelectGroup(groupId) {
		    document.listForm.groupId.value = groupId;
		    document.listForm.action = "<c:url value='/mng/grp/SysGroup.do'/>";
		    document.listForm.submit();
		}

		function fncAddGroupInsert() {
		    location.replace("<c:url value='/mng/grp/SysGroupInsertView.do'/>");
		}

		function fncGroupListDelete() {
		    if(fncManageChecked()) {
		        if(confirm('<spring:message code="common.delete.msg" />')) {
		            document.listForm.action = "<c:url value='/mng/grp/SysGroupListDelete.do'/>";
		            document.listForm.submit();
		        }
		    }
		}

		function linkPage(pageNo){
		    document.listForm.searchCondition.value = "1";
		    document.listForm.pageIndex.value = pageNo;
		    document.listForm.action = "<c:url value='/mng/grp/SysGroupList.do'/>";
		    document.listForm.submit();
		}

		function press() {

		    if (event.keyCode==13) {
		        fncSelectGroupList('1');
		    }
		}		
        
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
                                <li><a href="">사용자권한관리</a></li>
                                <li>사용자그룹관리</li>
                            </ul>
                        </div>
                        <!--// Location -->

						<form:form id="listForm" name="listForm" action="<c:url value='/mng/grp/SysAuthorList.do'/>" method="post">

                              <h2 class="tit_2">사용자그룹관리</h2>
                              
<%--                                 <!-- 검색조건 -->
                                <div class="condition2">
                                    <span class="lb mr10">그룹 명 : </span>
                                    <span class="item f_search">
                                        <input id="searchKeyword" class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${groupManageVO.searchKeyword}'/>" title="검색" onkeypress="press();" />
                                        <button class="btn" type="submit" onclick="javascript:fncSelectGroupList('1')"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>
                                </div>
                                <!--// 검색조건 --> --%>

                              <div class="board_list_top">
                                  <div class="left_col">
                                  </div>

                                  <div class="right_col">
                                      <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncGroupListDelete()"><spring:message code='button.delete' /></a><!-- 삭제 -->
                                      <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncAddGroupInsert()"><spring:message code='button.create' /></a><!-- 등록 -->
                                  </div>
                              </div>

                              <!-- 게시판 -->
                              <div class="board_list">
                                  <table summary="그룹 관리에 관한 테이블입니다.그룹 ID,그룹 명,설명,등록일자의 정보를 담고 있습니다.">
                                  	<caption>그룹 관리</caption>
                                      <colgroup>
                                          <col style="width: 80px;">
                                          <col style="width: auto;">
                                          <col style="width: auto;">
                                          <col style="width: auto;">
                                          <col style="width: auto;">
                                      </colgroup>
                                      <thead>
                                          <tr>
                                              <th scope="col">
                                                  <span class="f_chk_only chkAll">
                                                      <input type="checkbox" name="checkAll" onclick="javascript:fncCheckAll()" title="전체선택">
                                                  </span>
                                              </th>
                                              <th scope="col">그룹ID</th>
                                              <th scope="col">그룹명</th>
                                              <th scope="col">설명</th>
                                              <th scope="col">등록일자</th>
                                          </tr>
                                      </thead>
                                      <tbody>
                                      	
                                      	<c:if test="${empty groupList}">
                                      		<tr>
                                      			<td colspan="5"><spring:message code="common.nodata.msg" /></td>
                                      		</tr>
                                      	</c:if>
                                      	
                                      	<c:forEach var="group" items="${groupList}" varStatus="status">
                                          <tr>
                                              <td>
                                                  <span class="f_chk_only">
                                                      <input type="checkbox" name="delYn" title="선택">
                                                      <input type="hidden" name="checkId" value="<c:out value="${group.groupId}"/>" />
                                                  </span>
                                              </td>
                                              <td>
                                                  <a href="#LINK" class="lnk" onclick="javascript:fncSelectGroup('<c:out value="${group.groupId}"/>')"><c:out value="${group.groupId}"/></a>
                                              </td>
                                              <td><c:out value="${group.groupNm}"/></td>
                                              <td><c:out value="${group.groupDc}"/></td>
                                              <td><c:out value="${group.groupCreatDe}"/></td>
                                          </tr>
                                          </c:forEach>
                                          
                                      </tbody>
                                  </table>
                              </div>

						<!-- 페이지 네비게이션 시작 -->
						<c:if test="${!empty groupManageVO.pageIndex }">
                              <div class="board_list_bot">
                                  <div class="paging" id="paging_div">
                                      <ul>
                                          <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                                      </ul>
                                  </div>
                              </div>
                              </c:if>
                              <!-- //페이지 네비게이션 끝 -->
                              <!--// 게시판 -->
                              
                              <input type="hidden" name="groupId"/>
						<input type="hidden" name="groupIds"/>
						<input type="hidden" name="pageIndex" value="<c:out value='${groupManageVO.pageIndex}'/>"/>
						<input type="hidden" name="searchCondition"/>
						
						</form:form>						
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
