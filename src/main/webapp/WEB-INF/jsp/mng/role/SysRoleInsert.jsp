<%-- 
  Class Name : SysRoleInsert.jsp 
  Description : 권한 입력 화면
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
 
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script> 
 
<script type="text/javascript" src="<c:url value="/mng/cmmn/validator.do"/>"></script>
<validator:javascript formName="roleManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectRoleList() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/mng/role/SysRoleList.do'/>";
    varFrom.submit();       
}

function fncRoleInsert() {

    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/mng/role/SysRoleInsert.do'/>";

    
    if(!validateRoleManage(varFrom)){           
        return;
    }else{
     	if(confirm('<spring:message code="common.regist.msg" />')){
            varFrom.submit();
     	}
    } 
    
}

function fncRoleUpdate() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/mng/role/SysRoleUpdate.do'/>";

    if(!validateRoleManage(varFrom)){           
        return;
    }else{
        if(confirm('<spring:message code="common.update.msg" />')){
            varFrom.submit();
        }
    } 
}

function fncRoleDelete() {
    var varFrom = document.getElementById("roleManage");
    varFrom.action = "<c:url value='/mng/role/SysRoleDelete.do'/>";
    if(confirm('<spring:message code="common.delete.msg" />')){
        varFrom.submit();
    }
}

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
                                <li>롤관리</li>
                            </ul>
                        </div>
                        <!--// Location -->                    
                    
 
                        <div class="card mb-4">
							<!--<div style="height: 100vh">-->

								<form:form modelAttribute="roleManage" method="post" >

                                <h2 class="tit_2">롤관리</h2>

                                <div class="board_view2">
                                    <table summary="롤 등록 테이블입니다.롤 코드,롤 명,롤 패턴,설명,롤 타입,롤 Sort,등록일자의 정보를 담고 있습니다.">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr style="display:none">
                                            <td class="lb">
                                                <label for="roleCode">롤코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="roleCode" id="roleCode" class="f_txt" type="text" value="<c:out value='${roleManage.roleCode}'/>" title="롤 코드"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="roleNm">롤명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="roleNm" id="roleNm" class="f_txt" type="text" value="<c:out value='${roleManage.roleNm}'/>" maxLength="50" title="롤명"/>
                                                &nbsp;<form:errors path="roleNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="rolePtn">롤패턴</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="rolePtn" id="rolePtn" class="f_txt" type="text" value="<c:out value='${roleManage.rolePtn}'/>" maxLength="50" title="롤패턴"/>
                                                &nbsp;<form:errors path="rolePtn" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="roleDc">설명</label>
                                            </td>
                                            <td>
                                                <input name="roleDc" id="roleDc" class="f_txt w_full" type="text" value="<c:out value='${roleManage.roleDc}'/>" maxLength="50" title="설명"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="roleTyp">롤타입</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="sel1">
                                                    <select id="sel1" name="roleTyp" title="롤타입">
                                                    	<c:forEach var="cmmCodeDetail" items="${cmmCodeDetailList}" varStatus="status">
                                                        	<option value="<c:out value='${cmmCodeDetail.code}'/>" <c:if test="${cmmCodeDetail.code == roleManage.roleTyp}">selected</c:if> ><c:out value="${cmmCodeDetail.codeNm}"/></option>
                                                        </c:forEach>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="roleSort">롤Sort</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="roleSort" id="roleSort" class="f_txt" type="text" value="<c:out value='${roleManage.roleSort}'/>" maxLength="50" title="롤sort"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="roleCreatDe">등록일자</label>
                                            </td>
                                            <td>
                                                <input name="roleCreatDe" id="roleCreatDe" class="f_txt" type="text" value="<c:out value='${roleManage.roleCreatDe}'/>" maxLength="50" readonly="readonly" title="등록일자"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    	<c:if test="${registerFlag == 'UPDATE'}">
                                        	<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fncRoleDelete()"><spring:message code='button.delete' /></a><!-- 삭제 -->
                                        </c:if>
                                    </div>

                                    <div class="right_col btn1">
                                    	<c:if test="${registerFlag == 'INSERT'}">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncRoleInsert()"><spring:message code='button.save' /></a><!-- 저장 -->
                                        </c:if>
                                        <c:if test="${registerFlag == 'UPDATE'}">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncRoleUpdate()"><spring:message code='button.save' /></a><!-- 저장 -->
                                        </c:if>
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncSelectRoleList()"><spring:message code='button.list' /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
								<c:if test="${registerFlag == 'UPDATE'}">
									<input type="hidden" name="searchCondition" value="<c:out value='${roleManageVO.searchCondition}'/>"/>
									<input type="hidden" name="searchKeyword" value="<c:out value='${roleManageVO.searchKeyword}'/>"/>
									<input type="hidden" name="pageIndex" value="<c:out value='${roleManageVO.pageIndex}'/>"/>
								</c:if>
								
								</form:form>						
							
							<!--</div> -->
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
