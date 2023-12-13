<%-- 
  Class Name : EgovTemplateRegist.jsp
  Description : 템플릿 속성 등록화면
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
<validator:javascript formName="templateInf" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript">
    function fn_egov_regist_tmplatInfo(){
        if (!validateTemplateInf(document.templateInf)){
            return;
        }
        
        if (confirm('<spring:message code="common.regist.msg" />')) {
            document.templateInf.action = "<c:url value='/mng/bbs/com/insertTemplateInf.do'/>";
            document.templateInf.submit();
        }
    }
    
    function fn_egov_select_tmplatInfo(){
        document.templateInf.action = "<c:url value='/mng/bbs/com/selectTemplateInfs.do'/>";
        document.templateInf.submit();  
    }

    function fn_egov_selectTmplatType(obj){
        if (obj.value == 'TMPT01') {
            document.getElementById('sometext').innerHTML = "게시판 템플릿은 CSS만 가능합니다.";
        } else if (obj.value == '') {
            document.getElementById('sometext').innerHTML = "";
        } else {
            document.getElementById('sometext').innerHTML = "템플릿은 JSP만 가능합니다.";
        }       
    }

    function fn_egov_previewTmplat() {
        var frm = document.templateInf;
        
        var url = frm.tmplatCours.value;

        var target = "";

        if (frm.tmplatSeCode.value == 'TMPT01') {
            target = "<c:url value='/mng/bbs/previewBoardList.do'/>";
            width = "1024";
        } else {
            alert('<spring:message code="cop.tmplatCours" /> 지정 후 선택해 주세요.');
        }

        if (target != "") {
            window.open(target + "?searchWrd="+url, "preview", "width=" + width + "px, height=500px;");
        }
    }
</script>
 
<title>내부업무 사이트 > 내부서비스관리 > 게시판템플릿관리</title>
 
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
                                <li><a href="">내부서비스관리</a></li>
                                <li><a href="">내부업무게시판관리</a></li>
                                <li>게시판템플릿관리</li>
                            </ul>
                        </div>
                        <!--// Location -->                   
                    
 
                        <div class="card mb-4">
							<!--<div style="height: 100vh">-->

								<form:form modelAttribute="templateInf" name="templateInf" method="post" >
								
								<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />

                                <h1 class="tit_1">내부서비스관리</h1>

                                <h2 class="tit_2">게시판템플릿관리</h2>
                                
                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="tmplatNm"><spring:message code="cop.tmplatNm" /></label><!-- 템플릿명 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input class="f_txt w_full" name="tmplatNm" type="text" value="" maxlength="60" id="tmplatNm" title="템플릿명">
                                                <br/><form:errors path="tmplatNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="tmplatSeCode"><spring:message code="cop.tmplatSeCode" /></label><!-- 템플릿구분 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="sel1">
                                                    <select id="sel1" name="tmplatSeCode" class="select" onchange="fn_egov_selectTmplatType(this)" id="tmplatSeCode" title="템플릿구분">
                                                        <option value="">선택하세요</option>
                                                        <c:forEach var="result" items="${resultList}" varStatus="status">
                                                        	<option value='<c:out value="${result.code}"/>'><c:out value="${result.codeNm}"/></option>
                                                        </c:forEach>
                                                	</select>
                                                </label>
                                                <br/><form:errors path="tmplatSeCode" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="tmplatCours"><spring:message code="cop.tmplatCours" /></label><!-- 템플릿경로 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input class="f_txt w_full" name="tmplatCours" type="text" value="" maxlength="60" id="tmplatCours" title="템플릿경로">
                                                <br/><form:errors path="tmplatCours" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label><spring:message code="cop.useAt" /></label><!-- 사용여부 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td class="rdoSet"><!-- 2개이상 radio 있을때 필요 -->
                                                <label for="rdo1" class="f_rdo mr30 on">
                                                    <input id="rdo1" type="radio" name="useAt aa" class="radio2" value="Y" checked>
                                                    Y
                                                </label>
                                                <label for="rdo2" class="f_rdo">
                                                    <input id="rdo2" type="radio" name="useAt aa" class="radio2" value="N">
                                                    N
                                                </label>
                                                <br/><form:errors path="useAt" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="<c:url value='/mng/bbs/com/insertTemplateInf.do'/>" class="btn btn_blue_46 w_100" onclick="fn_egov_regist_tmplatInfo(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/mng/bbs/com/selectTemplateInfs.do'/>" class="btn btn_blue_46 w_100"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
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
