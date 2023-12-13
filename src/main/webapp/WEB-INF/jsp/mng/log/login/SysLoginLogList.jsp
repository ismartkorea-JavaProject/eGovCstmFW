<%-- 
  Class Name : SysLoginLogList.jsp 
  Description : 로그인 로그 정보목록 화면
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
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">
 
        <script type="text/javaScript" language="javascript" defer="defer"> 
		/* ********************************************************
		* PROTOTYPE JS FUNCTION
		******************************************************** */
		String.prototype.trim = function(){
		    return this.replace(/^\s+|\s+$/g, "");
		}
		
		String.prototype.replaceAll = function(src, repl){
		     var str = this;
		     if(src == repl){return str;}
		     while(str.indexOf(src) != -1) {
		        str = str.replace(src, repl);
		     }
		     return str;
		}

		function fn_egov_select_loginLog(pageNo){
		    var fromDate = document.frm.searchBgnDe.value;
		    var toDate = document.frm.searchEndDe.value;
		    
		    fromDate = fromDate.replaceAll('-','');
	        toDate = toDate.replaceAll('-','');
	        
		    if(fromDate > toDate) {
		        alert("종료일자는 시작일자보다  이후날짜로 선택하세요.");
		        //return false;
		    } else {
		        document.frm.pageIndex.value = pageNo;
		        document.frm.action = "<c:url value='/mng/log/login/SelectLoginLogList.do'/>";
		        document.frm.submit();
		    }
		}
	   
	    function fn_egov_inqire_loginLog(logId){
	        var url = "<c:url value ='/mng/log/login/InqireLoginLog.do?logId='/>" + logId;
	        
	        var openParam = "scrollbars=yes,toolbar=0,location=no,resizable=0,status=0,menubar=0,width=640,height=320,left=0,top=0"; 
	        window.open(url,"p_loginLogInqire", openParam);
	    }
	    
	    function fn_egov_inqire_loginLog(logId) {
	        
	        var $dialog = $('<div id="modalPan"></div>')
	    	.html('<iframe style="border: 0px; " src="' + "<c:url value='/mng/log/login/InqireLoginLog.do?logId='/>" + logId +'" width="100%" height="100%"></iframe>')
	    	.dialog({
	        	autoOpen: false,
	            modal: true,
	            width: 850,
	            height: 550
	    	});
	        $(".ui-dialog-titlebar").hide();
	    	$dialog.dialog('open');
	    }
	    
	    function fn_egov_returnValue(retVal){
	    	if(retVal != null){
	            var tmp = retVal.split("|");
	            document.getElementById("tmplatId").value = tmp[0];
	            document.getElementById("tmplatNm").value = tmp[1];
	        }
	    	
	    	fn_egov_modal_remove();
		}

	    /**********************************************************
	     * 모달 종료 버튼
	     ******************************************************** */
	    function fn_egov_modal_remove() {
	    	$('#modalPan').remove();
	    }
	    
	    /* ********************************************************
	     * 달력
	     ******************************************************** */
	    function fn_egov_init_date(){
	    	
	    	$("#searchBgnDe").datepicker(
	    	        {dateFormat:'yy-mm-dd'
	    	         , showOn: 'button'
	    	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	    	         , buttonImageOnly: true
	    	         
	    	         , showMonthAfterYear: true
	    	         , showOtherMonths: true
	    		     , selectOtherMonths: true
	    		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
	    				
	    	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	    	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	    	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	    	});

	    	$("#searchEndDe").datepicker( 
	    	        {dateFormat:'yy-mm-dd'
	    	         , showOn: 'button'
	    	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	    	         , buttonImageOnly: true
	    	         
	    	         , showMonthAfterYear: true
	    	         , showOtherMonths: true
	    		     , selectOtherMonths: true
	    		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
	    				
	    	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	    	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	    	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	    	});
	    }		
        
        </script>    
        <title>내부업무 사이트 > 내부서비스관리 > 접속로그관리</title>    
    </head>
    
<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}
</style>
    
    <body class="sb-nav-fixed" onload="fn_egov_init_date();">
    
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
                                        <li><a href="">사용자현황관리</a></li>
                                        <li>접속로그관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="frm" id="frm" action ="<c:url value='/mng/log/login/SelectLoginLogList.do'/>" method="post">
								
								<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
                                <h2 class="tit_2">접속로그관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <label for="occurDate" class="item mr10">발생일자</label>
                                    <input type="text" name="searchBgnDe" id="searchBgnDe" class="f_date" maxlength="10" value="<c:out value='${searchVO.searchBgnDe}'/>" title="시작일자입력" />&nbsp ~ &nbsp
                                    <input type="text" name="searchEndDe" id="searchEndDe" class="f_date" maxlength="10" value="<c:out value='${searchVO.searchEndDe}'/>" title="종료일자입력" >

                                    <a href="<c:url value='/sym/log/SelectLoginLogList.do'/>" class="item btn btn_blue_46 w_100 ml10" onclick="javascript:fn_egov_select_loginLog('1'); return false;"><spring:message code='button.inquire' /></a><!-- 조회 -->
                                    <a href="#LINK" class="item btn btn_blue_46 w_100" onclick="document.frm.searchBgnDe.value=''; document.frm.searchEndDe.value=''; return false;">초기화</a><!-- 초기화 -->
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="">
                                    	<caption>로그인 로그조회</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: 200px;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">번호</th>
                                                <th scope="col">로그ID</th>
                                                <th scope="col">발생일자</th>
                                                <th scope="col">로그유형</th>
                                                <th scope="col">상세보기</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:forEach var="result" items="${resultList}" varStatus="status">
	                                            <tr>
	                                                <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
	                                                <td><c:out value="${result.logId}"/></td>
	                                                <td><c:out value="${result.creatDt}"/></td>
	                                                <td><c:out value="${result.loginMthd}"/></td>
	                                                <td>
	                                                    <a href="#LINK" class="btn btn_blue_30 w_80" onclick="javascript:fn_egov_inqire_loginLog('<c:out value="${result.logId}"/>'); return false;">
	                                                    	상세보기
	                                                    </a>
	                                                </td>
	                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_loginLog" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- // 페이지 네비게이션 끝 -->
                                
                                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
                                
                                </form>
                                
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
