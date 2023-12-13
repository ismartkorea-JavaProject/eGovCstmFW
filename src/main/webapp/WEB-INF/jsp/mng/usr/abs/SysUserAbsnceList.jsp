<%-- 
  Class Name : SysUserAbsnceList.jsp 
  Description : 사용자 부재 조회 화면
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
	
<title>내부업무 사이트 > 내부시스템관리 > 사용자부재관리</title>
 
<script type="text/javaScript" language="javascript" defer="defer">
<!--

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
                alert("선택된 사용자가 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 사용자가 없습니다.");
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

    document.listForm.userIds.value = returnValue;
    return returnBoolean;
}

function fncInsertCheckId() {

    var checkedCounter = 0;
    var checkIds = document.listForm.delYn;
    var checkIdv = document.listForm.checkId;
    var checkRegYn = document.listForm.regYn;

    if(checkIds == null) { 
        alert("조회 후 등록하시기 바랍니다");
        return;
    } 
    else {

        for(var i=0; i<checkIds.length; i++) {
            if(checkIds[i].checked) {
                if(checkRegYn[i].value == 'Y') {
                    alert("이미 등록되어 있습니다.");
                    return false;;
                }                
                document.listForm.userId.value = checkIdv[i].value;
                checkedCounter++;
            }
        }

        if(checkedCounter > 1) {
            alert("등록대상 하나만 선택하십시오");
            return false;
        } else if(checkedCounter < 1) {
            alert("선택된 등록대상이  없습니다");
            return false;
        }

        return true;
    }
}

function fncSelectUserAbsnceList(pageNo) {
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/mng/usr/abs/selectUserAbsnceList.do'/>";
    document.listForm.submit();
}

function fncSelectUserAbsnce(userId, regYn) {
    if(regYn == 'N') {
        if(confirm("등록된 사용자부재 정보가 없습니다. 등록페이지로 이동하시겠습니까?")) {
            location.replace("<c:url value='/mng/usr/abs/addViewUserAbsnce.do'/>?userId="+userId);
        } else {
            return;
        }
    }
    document.listForm.userId.value = userId;
    document.listForm.action = "<c:url value='/mng/usr/abs/getUserAbsnce.do'/>";
    document.listForm.submit();     
}

function fncAddUserAbsnceInsert() {
    if(fncInsertCheckId()) {
        document.listForm.action = "<c:url value='/mng/usr/abs/addViewUserAbsnce.do'/>";
        document.listForm.submit();    
    }
}

function fncLoginUserAbsnceListDelete() {
    if(fncManageChecked()) {
        if(confirm('<spring:message code="common.delete.msg" />')) {
            document.listForm.action = "<c:url value='/mng/usr/abs/removeUserAbsnceList.do'/>";
            document.listForm.submit();
        }
    }
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/mng/usr/abs/selectUserAbsnceList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
        fncSelectUserAbsnceList('1');
    }
}
-->
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
                                        <li><a href="">사용자관리</a></li>
                                        <li>사용자부재관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h2 class="tit_2">사용자부재관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                	
                                	<form name="listForm" action="<c:url value='/mng/usr/SysUserManage.do'/>" method="post">
                                	
									<input type="hidden" name="userId">
									<input type="hidden" name="pageIndex" value="<c:if test="${empty userAbsnceVO.pageIndex }">1</c:if><c:if test="${!empty userAbsnceVO.pageIndex }"><c:out value='${userAbsnceVO.pageIndex}'/></c:if>">
									<input type="hidden" name="searchCondition" value="1">
                                	
                                    <span class="lb mr10">사용자 명 : </span>
                                    <input id="searchKeyword" class="f_txt mr20" name="searchKeyword" type="text" value="<c:out value="${userAbsnceVO.searchKeyword}"/>" title="검색" onkeypress="press();" >

                                    <span class="lb mr10">부재여부 : </span>
                                    <label class="item f_select" for="selAbsnceAt">
                                        <select id="selAbsnceAt" name="selAbsnceAt">
    		                                <option value="A" <c:if test="${userAbsnceVO.selAbsnceAt eq 'A'}">selected</c:if>>전체</option>
    		                                <option value="Y" <c:if test="${userAbsnceVO.selAbsnceAt eq 'Y'}">selected</c:if>>Y</option>
    		                                <option value="N" <c:if test="${userAbsnceVO.selAbsnceAt eq 'N'}">selected</c:if>>N</option>
    	                                </select>
                                    </label>

                                    <a href="<c:url value='/mng/usr/abs/selectUserAbsnceList.do'/>" class="item btn btn_blue_46 w_100" onclick="javascript:fncSelectUserAbsnceList('1'); return false;">조회</a><!-- 조회 -->
                                	
                                	</form>
                                	
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="사용자부재정보에 대한 목록을 제공한다.">
                                    	<caption>사용자부재 관리</caption>
                                        <colgroup>
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">사용자 ID</th>
                                                <th scope="col">사용자명</th>
                                                <th scope="col">부재여부</th>
                                                <th scope="col">등록여부</th>
                                                <th scope="col">등록일시</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                        	<c:if test="${empty userAbsnceList}">
                                        		<tr>
                                        			<td colspan="5">검색된 값이 없습니다.</td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="userAbsnce" items="${userAbsnceList}" varStatus="status">
                                            <tr>
                                                <td>
                                                	<form name="item" method="post" action="<c:url value='/mng/usr/abs/getUserAbsnce.do'/>">
                                                		<input type="hidden" name="userId" value="<c:out value="${userAbsnce.userId}"/>">
                                                		<input type="hidden" name="selAbsnceAt" value="<c:out value="${userAbsnceVO.selAbsnceAt}"/>">
                                                		<input type="hidden" name="pageIndex" value="<c:out value='${userAbsnceVO.pageIndex}'/>">
                                                		<input type="hidden" name="searchCondition" value="<c:out value='${userAbsnceVO.searchCondition}'/>">
                                                		<input type="hidden" name="searchKeyword" value="<c:out value="${userAbsnceVO.searchKeyword}"/>">
                                                		<c:out value="${userAbsnce.userId}"/>
                                                		<a href="" class="btn btn_blue_30 w_70" onclick="fncSelectUserAbsnce('<c:out value="${userAbsnce.userId}"/>', '<c:out value="${userAbsnce.regYn}"/>'); return false;">등록</a>
                                                    </form>
                                                </td>
                                                <td><c:out value="${userAbsnce.userNm}"/></td>
                                                <td>
                                                	<c:if test="${userAbsnce.userAbsnceAt eq 'Y'}" ><c:out value="Y"/></c:if>
                                                	<c:if test="${userAbsnce.userAbsnceAt eq 'N'}" ><c:out value="N"/></c:if>
                                                </td>
                                                <td>
                                                	<c:if test="${userAbsnce.regYn eq 'Y'}" ><c:out value="Y"/></c:if>
                                                	<c:if test="${userAbsnce.regYn eq 'N'}" ><c:out value="N"/></c:if>
                                                </td>
                                                <td><c:out value="${userAbsnce.lastUpdusrPnttm}"/></td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty userAbsnceVO.pageIndex }">
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
