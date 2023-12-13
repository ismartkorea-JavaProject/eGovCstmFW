<%-- 
  Class Name : SysMenuBndeRegist.jsp 
  Description : 메뉴 일괄 등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.11.16   jeong       경량환경 버전 생성
 
    author   : s-onsystem
    since    : 2023.11.16 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images_old/egovframework/sym/mpm/icon";
  String imagePath_button = "/images_old/egovframework/sym/mpm/button/";
%>
<c:url var="ImgUrl" value="/images"/>
 <!-- Header -->
 <c:import url="/mng/main/SysIncHeader.do" />
 <!--// Header -->
 
<script type="text/javascript" src="<c:url value="/mng/cmmn/validator.do"/>"></script>
<validator:javascript formName="menuManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script  language="javascript1.2" type="text/javaScript">
/* ********************************************************
 * 메뉴일괄생성처리 함수
 ******************************************************** */
function insertMenuManage() {
    if(confirm("메뉴일괄등록을 하시겠습니까?. \n 메뉴정보와  프로그램목록, 프로그램 변경내역 존재시 삭제 하실 수 없습니다.")){
       if(checkFile()){
           document.menuManageRegistForm.action ="<c:url value='/mng/menu/SysMenuBndeRegist.do'/>";
          document.menuManageRegistForm.submit();
       }
    }
}
/* ********************************************************
 * 메뉴일괄삭제처리 함수
 ******************************************************** */
function deleteMenuList() {
    if(confirm("메뉴일괄삭제를 하시겠습니까?. \n 메뉴정보와  프로그램목록, 프로그램 변경내역 데이타 모두  삭제 삭제처리 됩니다.")){
        document.menuManageRegistForm.action ="<c:url value='/mng/menu/SysMenuBndeAllDelete.do'/>";
        document.menuManageRegistForm.submit();
    }
}
/* ********************************************************
 * 메뉴일괄등록시 등록파일 체크 함수
 ******************************************************** */
function checkFile(){ 
    if(document.menuManageRegistForm.file.value==""){
       alert("업로드 할 파일을 지정해 주세요");
       return false;
    }

    var  str_dotlocation,str_ext,str_low;
    str_value  = document.menuManageRegistForm.file.value;
    str_low   = str_value.toLowerCase(str_value);
    str_dotlocation = str_low.lastIndexOf(".");
    str_ext   = str_low.substring(str_dotlocation+1);
    
    switch (str_ext) {
      case "xls" :
      case "xlsx" :
         return true;
         break;
      default:
         alert("파일 형식이 맞지 않습니다.\n xls,XLS,xlsx,XLSX 만\n 업로드가 가능합니다!");
         return false;
    }
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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
                                <li><a href="">메뉴관리</a></li>
                                <li>메뉴목록관리</li>
                            </ul>
                        </div>
                        <!--// Location -->                    
                    
 
                        <div class="card mb-4">
							<!--<div style="height: 100vh">-->

								<form name="menuManageRegistForm" action ="<c:url value='/mng/menu/SysMenuBndeRegist.do'/>" method="post" enctype="multipart/form-data">

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">메뉴목록관리</h2>

                                <div class="board_view2">
                                    <table summary="메뉴일괄등록">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min"><label for="file">일괄파일</label></span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input type="file" id="file" class="f_file" name="file" title="일괄파일"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:insertMenuManage(); return false;"><spring:message code='button.save' /></a><!-- 저장 -->
                                        <a href="<c:url value='/mng/menu/SysMenuManageSelect.do'/>" class="btn btn_blue_46 w_100" onclick="selectList(); return false;"><spring:message code='button.list' /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input name="cmd" type="hidden" value="<c:out value='bndeInsert'/>"/>
                                
                                </form>						
							
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
