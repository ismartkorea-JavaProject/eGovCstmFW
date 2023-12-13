<%-- 
  Class Name : SysUserInsert.jsp 
  Description : 사용자 등록 화면
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
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css"> 
 
<title>내부업무 사이트 > 내부서비스관리 > 사용자등록관리</title>
<script type="text/javascript" src="<c:url value="/mng/cmmn/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
 <script type="text/javaScript" language="javascript" defer="defer">
 <!--
 function fnIdCheck(){
     
     var $dialog = $('<div id="modalPan"></div>')
 	.html('<iframe style="border: 0px; " src="' + "<c:url value='/mng/usr/SysIdDplctCnfirmView.do'/>?" + '" width="100%" height="100%"></iframe>')
 	.dialog({
     	autoOpen: false,
         modal: true,
         width: 600,
         height: 450
 	});
     $(".ui-dialog-titlebar").hide();
 	$dialog.dialog('open');
 }
 function showModalDialogCallback(retVal) {
     if(retVal) {
         document.userManageVO.emplyrId.value = retVal;
         document.userManageVO.id_view.value = retVal;
         
         fn_egov_modal_remove();
     }
 }
 function fnListPage(){
     document.userManageVO.action = "<c:url value='/mng/usr/SysUserManage.do'/>"; 
     document.userManageVO.submit();
 }
 function fnInsert(){
     if(validateUserManageVO(document.userManageVO)){
         if(document.userManageVO.password.value != document.userManageVO.password2.value){
             alert("<spring:message code="fail.user.passwordUpdate2" />");
             return;
         }
         document.userManageVO.submit();
     }
 }
 function fn_egov_inqire_cert() {
     var url = '/uat/uia/EgovGpkiRegist.do';
     var popupwidth = '500';
     var popupheight = '400';
     var title = '인증서';

     Top = (window.screen.height - popupheight) / 3;
     Left = (window.screen.width - popupwidth) / 2;
     if (Top < 0) Top = 0;
     if (Left < 0) Left = 0;
     Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
     PopUpWindow = window.open(url, title, Future)
     PopUpWindow.focus();
 }

 function fn_egov_dn_info_setting(dn) {
     var frm = document.userManageVO;
     
     frm.subDn.value = dn;
 }

 /*
 if (typeof(opener.fn_egov_dn_info_setting) == 'undefined') {
     alert('메인 화면이 변경되거나 없습니다');
     this.close();
 } else {
     opener.fn_egov_dn_info_setting(dn);
     this.close();
 }
 */

 function fn_egov_ZipSearch(){
     
     var $dialog = $('<div id="modalPan"></div>')
 	.html('<iframe style="border: 0px; " src="' + "<c:url value='/mng/cmm/zip/SysCcmZipSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
 	.dialog({
     	autoOpen: false,
         modal: true,
         width: 1100,
         height: 700
 	});
     $(".ui-dialog-titlebar").hide();
 	$dialog.dialog('open');
 }

 function fn_egov_returnValue(retVal){
 	
 	if (retVal) {
 		document.getElementById("zip_view").value  = retVal.sAddr;
 	}
 	
 	fn_egov_modal_remove();
 }

 /**********************************************************
  * 모달 종료 버튼
  ******************************************************** */
 function fn_egov_modal_remove() {
 	$('#modalPan').remove();
 }
 //-->
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
							<div style="height: 100vh">

								<form:form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/mng/usr/SysUserInsert.do" name="userManageVO" method="post" >
								<!-- 우편번호검색 -->
								<input type="hidden" name="zip_url" value="<c:url value='/mng/cmm/SysCcmZipSearchPopup.do'/>" />

                                <h2 class="tit_2">사용자등록관리</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrId">사용자아이디</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_150">
                                                    <input type="text" maxlength="20" disabled="disabled" id="id_view" name="id_view" readonly="readonly">
                                                    <form:input path="emplyrId" id="emplyrId" title="사용자아이디" maxlength="20" type="hidden" />
                                                    <button type="button" class="btn" onclick="fnIdCheck();">조회</button>
                                                </span>
                                                <span class="f_txt_inner ml10">(중복체크)</span>
                                                <form:errors path="emplyrId" />
                                            </td>
                                            <td class="lb">
                                                <label for="moblphonNo">핸드폰번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="moblphonNo" id="moblphonNo" title="핸드폰번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="moblphonNo" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="password">비밀번호</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:password path="password" id="password" title="비밀번호" class="f_txt w_full" maxlength="20" />
                                                <form:errors path="password" />
                                            </td>
                                            <td class="lb">
                                                <label for="password2">비밀번호확인</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="password2" id="password2" title="비밀번호확인" type="password" class="f_txt w_full" maxlength="20" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="passwordHint">비밀번호힌트</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="passwordHint">
                                                    <form:select path="passwordHint" id="passwordHint" name="passwordHint" title="비밀번호힌트">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="passwordHint" />
                                            </td>
                                            <td class="lb">
                                                <label for="passwordCnsr">비밀번호정답</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="passwordCnsr" id="passwordCnsr" title="비밀번호정답" class="f_txt w_full" maxlength="100" />
                                                <form:errors path="passwordCnsr" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrNm">이름</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="emplyrNm" id="emplyrNm" title="사용자이름" type="text" class="f_txt w_full" value="" maxlength="60" />
                                                <form:errors path="emplyrNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="insttCode">소속기관</label>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="insttCode">
                                                    <form:select path="insttCode" id="insttCode" name="insttCode" title="소속기관">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${insttCode_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="insttCode" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="orgnztId">조직코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="orgnztId">
                                                    <form:select path="orgnztId" id="orgnztId" name="orgnztId" title="부서">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${orgnztId_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="orgnztId" />
                                            </td>
                                            <td class="lb">
                                                <label for="ofcpsNm">직위명</label>
                                            </td>
                                            <td>
                                                <form:input path="ofcpsNm" id="ofcpsNm" title="직위명" class="f_txt w_full" maxlength="30" />
                                                <form:errors path="ofcpsNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="emailAdres">이메일주소</label>
                                            </td>
                                            <td>
                                                <form:input path="emailAdres" id="emailAdres" title="이메일주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="emailAdres" />
                                            </td>
                                            <td class="lb">
                                                <label for="areaNo">집전화<br>지역번호</label>
                                            </td>
                                            <td>
                                                <form:input path="areaNo" id="areaNo" title="areaNo" class="f_txt w_70" maxlength="5" />
                                                <span class="f_txt_inner mr5 ml5" title="전화번호 첫번째">-</span>
                                                <form:input path="homemiddleTelno" title="homemiddleTelno" id="homemiddleTelno" class="f_txt w_70" maxlength="5" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <form:input path="homeendTelno" title="homeendTelno" id="homeendTelno" class="f_txt w_70" maxlength="5" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="offmTelno">사무실<br>전화번호</label>
                                            </td>
                                            <td>
                                                <form:input path="offmTelno" id="offmTelno" title="사무실전화번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="offmTelno" />
                                            </td>
                                            <td class="lb">
                                                <label for="fxnum">팩스번호</label>
                                            </td>
                                            <td>
                                                <form:input path="fxnum" id="fxnum" title="팩스번호" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="fxnum" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="homeadres">주소</label>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_150">
                                                    <form:input path="homeadres" id="zip_view" title="주소" maxlength="100" readonly="true" />
                                                    <form:errors path="homeadres" />
                                                    <form:hidden path="zip" />
                                                    <button type="button" class="btn" onclick="fn_egov_ZipSearch();">조회</button>
                                                </span>
                                                <span class="f_txt_inner ml15">(우편번호 검색)</span>
                                                <form:errors path="zip" />
                                                <input name="zip_view" id="zip_view" type="hidden" title="우편번호" value="<c:out value='${userManageVO.zip}'/>" maxlength="8" readonly="readonly" />
                                            </td>
                                            <td class="lb">
                                                <label for="detailAdres">상세주소</label>
                                            </td>
                                            <td>
                                                <form:input path="detailAdres" id="detailAdres" title="상세주소" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="detailAdres" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrSttusCode">사용자상태<br>코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="emplyrSttusCode">
                                                    <form:select path="emplyrSttusCode" id="emplyrSttusCode" name="emplyrSttusCode" title="사용자상태코드">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${emplyrSttusCode_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="emplyrSttusCode" />
                                            </td>
                                            <td class="lb">
                                                <label for="groupId">그룹아이디</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="groupId">
                                                    <form:select path="groupId" id="groupId" name="groupId" title="그룹아이디">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${groupId_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="groupId" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.userManageVO.reset();"><spring:message code="button.reset" /></a><!-- 초기화 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnInsert(); return fallse;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/mng/usr/SysUserManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
						        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
						        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
						        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
						        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/><c:if test="${userSearchVO.pageIndex eq null}">1</c:if>"/>
						        
			                	</form:form>							
							
							</div>
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
