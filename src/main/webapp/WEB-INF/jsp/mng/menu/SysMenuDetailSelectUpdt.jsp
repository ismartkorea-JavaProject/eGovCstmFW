<%-- 
  Class Name : SysMenuDetailSelectUpdt.jsp 
  Description : 메뉴 상세 화면
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
<validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css"> 
 <script type="text/javaScript" language="javascript" defer="defer">
 <!--
 /* ********************************************************
  * 수정처리 함수
  ******************************************************** */
 function updateMenuManage(form) {
     
     if(!validateMenuManageVO(form)){            
         return;
     }else{
     	if(confirm("<spring:message code='common.save.msg' />")){
          form.action="<c:url value='/mng/menu/SysMenuDetailSelectUpdt.do'/>";
          form.submit();
     	}
     }
 }

 /* ********************************************************
  * 삭제처리함수
  ******************************************************** */
 function deleteMenuManage(form) {
     if(confirm("<spring:message code='common.delete.msg' />")){
         form.action="<c:url value='/mng/menu/SysMenuManageDelete.do'/>";
         form.submit();
     }
 }
 /* ********************************************************
  * 파일목록조회  함수
  ******************************************************** */
 function searchFileNm() {
     document.all.tmp_SearchElementName.value = "progrmFileNm";
     window.open("<c:url value='/mng/prm/SysProgramListSearch.do'/>",'','width=800,height=600');
 }
 /* ********************************************************
  * 목록조회 함수
  ******************************************************** */
 function selectList(){
     location.href = "<c:url value='/mng/menu/SysMenuManageSelect.do'/>";
 }

 /* ********************************************************
  * 파일명 엔터key 목록조회  함수
  ******************************************************** */
 function press() {
     if (event.keyCode==13) {
         searchFileNm();    // 원래 검색 function 호출
     }
 }
 <c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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
                                <li><a href="">사용자관리</a></li>
                                <li>사용자등록관리</li>
                            </ul>
                        </div>
                        <!--// Location -->                    
                    

                        <div class="card mb-4">
							<!--<div style="height: 100vh">-->

								<form:form modelAttribute="menuManageVO" name="menuManageVO" action ="<c:url value='/mng/menu/SysMenuDetailSelectUpdt.do' />" method="post">

                                <h2 class="tit_2">메뉴목록관리</h2>

                                <div class="board_view2">
                                    <table summary="메뉴상세정보">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min"><label for="menuNo">메뉴번호</label></span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input class="f_txt" type="text" value="<c:out value="${menuManageVO.menuNo}"/>" id="" readonly="readonly">
                                                <form:hidden path="menuNo" />
                                                <form:errors path="menuNo" />
                                            </td>
                                            <td class="lb">
                                                <label for="menuOrdr">메뉴순서</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="menuOrdr" maxlength="10" title="메뉴순서"/>
                                                <form:errors path="menuOrdr" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="menuNm">메뉴명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="menuNm" maxlength="30" title="메뉴명"/>
                                                <form:errors path="menuNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="upperMenuId">상위메뉴번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="upperMenuId" maxlength="10" title="상위메뉴No"/>
                                                <form:errors path="upperMenuId" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="progrmFileNm">프로그램파일명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td colspan="3">
                                                <span class="f_search2 w_500">
                                                    <input id="" type="text" name="progrmFileNm_view" size="60" disabled="disabled" value="<c:out value='${menuManageVO.progrmFileNm}'/>" readonly="readonly">
                                                    <form:input path="progrmFileNm" type="hidden" maxlength="60" title="프로그램파일명" />
                                                    <form:errors path="progrmFileNm" />
                                                    <button type="button" class="btn" onclick="searchFileNm();return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                                </span>
                                                <span class="f_txt_inner ml15">(프로그램파일명 검색)</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="relateImageNm">관련이미지명</label>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="relateImageNm" maxlength="30" title="관련이미지명"/>
                                                <form:errors path="relateImageNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="relateImagePath">관련이미지경로</label>
                                            </td>
                                            <td>
                                                <form:input id="" class="f_txt" path="relateImagePath" maxlength="30" title="관련이미지경로"/>
                                                <form:errors path="relateImagePath" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="menuDc">메뉴설명</label>
                                            </td>
                                            <td colspan="3">
                                                <form:textarea id="" class="f_txtar w_full h_200" path="menuDc" rows="10" cols="30" title="메뉴설명"/>
                                                <form:errors path="menuDc" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="deleteMenuManage(document.getElementById('menuManageVO')); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:updateMenuManage(document.getElementById('menuManageVO')); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/mng/menu/SysMenuManageSelect.do'/>" class="btn btn_blue_46 w_100" onclick="selectList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input type="hidden" name="tmp_SearchElementName" value=""/>
                                <input type="hidden" name="tmp_SearchElementVal" value=""/>
                                <input name="cmd" type="hidden" value="update"/>
                                
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
