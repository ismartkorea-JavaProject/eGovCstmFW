<%-- 
  Class Name : SysAuthorManage.jsp 
  Description : 권한 관리 화면
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
 <!-- Header -->
 <c:import url="/mng/main/SysIncHeader.do" />
 <!--// Header -->
 
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
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else 
                        returnValue = returnValue + ";" + checkField[i].value;
                    checkCount++;
                }
            }
            if(checkCount > 0) 
                returnBoolean = true;
            else {
                alert("선택된 권한이 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된 권한이 없습니다.");
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

    document.listForm.authorCodes.value = returnValue;

    return returnBoolean;
}

function fncSelectAuthorList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/mng/auth/SysAuthorList.do'/>";
    document.listForm.submit();
}

function fncSelectAuthor(author) {
    document.listForm.authorCode.value = author;
    document.listForm.action = "<c:url value='/mng/auth/SysAuthor.do'/>";
    document.listForm.submit();     
}

function fncAddAuthorInsert() {
    location.replace("<c:url value='/mng/auth/SysAuthorInsertView.do'/>"); 
}

function fncAuthorDeleteList() {

    if(fncManageChecked()) {    
        if(confirm('<spring:message code="common.delete.msg" />')) {
            document.listForm.action = "<c:url value='/mng/auth/SysAuthorListDelete.do'/>";
            document.listForm.submit();
        } 
    }
}

function fncAddAuthorView() {
    document.listForm.action = "<c:url value='/mng/auth/SysAuthorUpdate.do'/>";
    document.listForm.submit();     
}

function fncSelectAuthorRole(author) {
    document.listForm.searchKeyword.value = author;
    document.listForm.action = "<c:url value='/mng/auth/SysAuthorRoleList.do'/>";
    document.listForm.submit();     
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/mng/auth/SysAuthorList.do'/>";
    document.listForm.submit();
}


function press() {

    if (event.keyCode==13) {
        fncSelectAuthorList('1');
    }
}


-->
</script>
 
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
                    
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">내부시스템관리</a></li>
                                        <li><a href="">사용자권한관리</a></li>
                                        <li>권한관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->                    
                    

								<form:form id="listForm" name="listForm" action="<c:url value='/mng/auth/SysAuthorList.do'/>" method="post">

                                <h2 class="tit_2">권한관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <span class="lb mr10">권한 명 : </span>
                                    <span class="item f_search">
                                        <input id="searchKeyword" class="f_input w_500" name="searchKeyword" type="text" value="<c:out value='${authorManageVO.searchKeyword}'/>" title="검색" onkeypress="press();" />
                                        <button class="btn" type="submit" onclick="javascript:fncSelectAuthorList('1')" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <div class="board_list_top">
                                    <div class="left_col">
                                    </div>

                                    <div class="right_col">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncAuthorDeleteList()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code='button.delete' /></a><!-- 삭제 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncAddAuthorInsert()" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code='button.create' /></a><!-- 등록 -->
                                    </div>
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="권한관리에  관한 테이블입니다.권한ID,권한 명,설명, 등록일자, 롤 정보의 내용을 담고 있습니다.">
                                    	<caption>사용자목록관리</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: 80px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <span class="f_chk_only chkAll">
                                                        <input type="checkbox" name="checkAll" title="선택여부" onclick="javascript:fncCheckAll()">
                                                    </span>
                                                </th>
                                                <th scope="col">권한코드</th>
                                                <th scope="col">권한명</th>
                                                <th scope="col">설명</th>
                                                <th scope="col">등록일자</th>
                                                <th scope="col">롤정보</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                        	<c:if test="${empty authorList}">
                                        		<tr>
                                        			<td colspan="6"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="author" items="${authorList}" varStatus="status">
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="delYn" title="선택">
                                                        <input type="hidden" name="checkId" value="<c:out value="${author.authorCode}"/>" />
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="#LINK" class="lnk" onclick="javascript:fncSelectAuthor('<c:out value="${author.authorCode}"/>')">
                                                    	<c:out value="${author.authorCode}"/>
                                                    </a>
                                                </td>
                                                <td><c:out value="${author.authorNm}"/></td>
                                                <td><c:out value="${author.authorDc}"/></td>
                                                <td><c:out value="${author.authorCreatDe}"/></td>
                                                <td>
                                                    <a href="#LINK" class="btn btn_blue_30 w_70" onclick="javascript:fncSelectAuthorRole('<c:out value="${author.authorCode}"/>')">
                                                    	이동
                                                    </a>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty authorManageVO.pageIndex }">
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="linkPage" />
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                                <!-- //페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
                                
                                <input type="hidden" name="authorCode"/>
                                <input type="hidden" name="authorCodes"/>
                                <input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
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
