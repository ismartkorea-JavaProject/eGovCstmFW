<%-- 
  Class Name : SysMenuCreate.jsp 
  Description : 메뉴 등록 화면
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
 
<script type="text/javaScript">
<!--
var imgpath = "<c:url value='/'/>images/";
//-->
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/EgovMenuCreat.js'/>"></script>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectMenuCreatTmp() {
    document.menuCreatManageForm.action = "<c:url value='/mng/menu/create/SysMenuCreatSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 멀티입력 처리 함수
 ******************************************************** */
function fInsertMenuCreat() {
    var checkField = document.menuCreatManageForm.checkField;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + checkField[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = checkField.value;
            }
        }
    }   
    document.menuCreatManageForm.checkedMenuNoForInsert.value=checkMenuNos;
    document.menuCreatManageForm.checkedAuthorForInsert.value=document.menuCreatManageForm.authorCode.value;
    document.menuCreatManageForm.action = "<c:url value='/mng/menu/create/SysMenuCreatInsert.do'/>";
    document.menuCreatManageForm.submit(); 
}
/* ********************************************************
 * 메뉴사이트맵 생성 화면 호출
 ******************************************************** */
function fMenuCreatSiteMap() {
    id = document.menuCreatManageForm.authorCode.value;
    window.open("<c:url value='/mng/menu/create/SysMenuCreatSiteMapSelect.do'/>?authorCode="+id,'Pop_SiteMap','scrollbars=yes, width=550, height=700');
}

/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>
 
    </head>
    <body>
    
    <noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<form name="menuCreatManageForm" action ="/mng/menu/create/SysMenuCreatSiteMapSelect.do" method="post">
	
	<input name="checkedMenuNoForInsert" type="hidden" >
	<input name="checkedAuthorForInsert"  type="hidden" >
	
    <!-- 그룹 조회 팝업 -->
    <div class="popup POP_MENU_CREATE">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>메뉴 생성</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition2">
                    <label for="authorCode" class="lb mr10">권한코드 : </label>
                    <input id="authorCode" class="f_txt item" name="authorCode" type="text" maxlength="30" title="권한코드" value="<c:out value='${resultVO.authorCode}'/>" readonly="readonly">
                    <a href="#LINK" class="item btn btn_blue_46 w_100" onclick="fInsertMenuCreat(); return false;">메뉴생성</a>
                </div>
                <!--// 검색조건 -->

                <!-- Tree -->
                <div class="tree_ui tree-ui">
                
                	<c:forEach var="result1" items="${list_menulist}" varStatus="status" >
                		<input type="hidden" name="tmp_menuNmVal" value="<c:out value='${result1.menuNo}'/>|<c:out value='${result1.upperMenuId}'/>|<c:out value='${result1.menuNm}'/>|<c:out value='${result1.progrmFileNm}'/>|<c:out value='${result1.chkYeoBu}'/>|">
                	</c:forEach>
                	
                    <script language="javascript" type="text/javaScript">
			            var chk_Object = true;
			            var chk_browse = "";
			            if (eval(document.menuCreatManageForm.authorCode)=="[object]") chk_browse = "IE";
			            if (eval(document.menuCreatManageForm.authorCode)=="[object NodeList]") chk_browse = "Fox";
			            if (eval(document.menuCreatManageForm.authorCode)=="[object Collection]") chk_browse = "safai";
			
			            var Tree = new Array;
			            if(chk_browse=="IE"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object]"){
			               alert("메뉴 목록 데이타가 존재하지 않습니다.");
			               chk_Object = false;
			            }
			            if(chk_browse=="Fox"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object NodeList]"){
			               alert("메뉴 목록 데이타가 존재하지 않습니다.");
			               chk_Object = false;
			            }
			            if(chk_browse=="safai"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object Collection]"){
			                   alert("메뉴 목록 데이타가 존재하지 않습니다.");
			                   chk_Object = false;
			            }
			            if( chk_Object ){
			                for (var j = 0; j < document.menuCreatManageForm.tmp_menuNmVal.length; j++) {
			                    Tree[j] = document.menuCreatManageForm.tmp_menuNmVal[j].value;
			                }
			                createTree(Tree);
			            }else{
			                alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.");
			                window.close();
			            }
			        </script>
                    
                </div>
                <!--// Tree -->
            </div>
        </div>
    </div>
    <!--// 그룹 조회 팝업 -->
    
    <input type="hidden" name="req_menuNo">
    
    </form>						

    </body>
</html>
