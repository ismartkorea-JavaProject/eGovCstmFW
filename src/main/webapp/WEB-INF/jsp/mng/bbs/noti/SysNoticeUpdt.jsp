<%-- 
  Class Name : SysNoticeUpdt.jsp 
  Description : 게시물 수정 화면
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
 
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<!-- script type="text/javascript" src="<c:url value='/html/egovframework/cmm/utl/htmlarea/EgovWebEditor.js'/>" ></script-->
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/mng/cmmn/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">

    function fn_egov_validateForm(obj) {
        return true;
    }

    function fn_egov_regist_notice() {
        //document.board.onsubmit();

        if (!validateBoard(document.board)){
            return;
        }
        
        if (confirm('<spring:message code="common.regist.msg" />')) {
            document.board.action = "<c:url value='/mng/bbs${prefix}/noti/replyBoardArticle.do'/>";
            document.board.submit();                    
        }
    }
    
    function fn_egov_select_noticeList() {
        document.board.action = "<c:url value='/mng/bbs${prefix}/noti/selectBoardList.do'/>";
        document.board.submit();    
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
                                        <li><a href="">내부서비스관리</a></li>
                                        <li><a href="">내부업무게시판관리</a></li>
                                        <li><c:out value='${bdMstr.bbsNm}'/>관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="board" name="board" method="post" enctype="multipart/form-data" >
								
			                    <input type="hidden" name="replyAt" value="Y" />
			                    <input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
			                    <input type="hidden" name="nttId" value="<c:out value='${searchVO.nttId}'/>" />
			                    <input type="hidden" name="parnts" value="<c:out value='${searchVO.parnts}'/>" />
			                    <input type="hidden" name="sortOrdr" value="<c:out value='${searchVO.sortOrdr}'/>" />
			                    <input type="hidden" name="replyLc" value="<c:out value='${searchVO.replyLc}'/>" />
			                    
			                    <input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
			                    <input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
			                    <input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
			                    <input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
			                    <input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
			                    <input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
			                    <input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
			                    <input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
			                    
			                    <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
			                    
			                    <c:if test="${anonymous != 'true'}">
			                        <input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
			                        <input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
			                    </c:if>
			                    
			                    <c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
			                       <input name="ntceBgnde" type="hidden" value="10000101">
			                       <input name="ntceEndde" type="hidden" value="99991231">
			                    </c:if>

                                <h1 class="tit_1">내부서비스관리</h1>

                                <h2 class="tit_2"><c:out value='${bdMstr.bbsNm}'/>관리</h2>
                                
                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="nttSj"><spring:message code="cop.nttSj" /></label><!-- 제목 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="nttSj" class="f_txt w_full" name="nttSj" type="text" value="RE: <c:out value='${result.nttSj}'/>" maxlength="60" >
                                                <br/><form:errors path="nttSj" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="nttCn"><spring:message code="cop.nttCn" /></label><!-- 글내용 -->
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <textarea id="nttCn" class="f_txtar w_full h_200" name="nttCn" cols="30" rows="10" ></textarea>
                                                <form:errors path="nttCn" />
                                            </td>
                                        </tr>
                                        
                                        <c:if test="${bdMstr.bbsAttrbCode == 'BBSA01'}">
	                                        <tr>
	                                            <td class="lb">
	                                                <label for=""><spring:message code="cop.noticeTerm" /></label><!-- 게시기간 -->
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                            	<input name="ntceBgnde" type="hidden" value='<c:out value="${result.ntceBgnde}" />'>
	                                            	<input type="text" name="searchBgnDe" id="searchBgnDe" class="f_date" maxlength="10" value="<c:out value='${searchVO.searchBgnDe}'/>" title="시작일자입력" />
	                                            	~
	                                            	<input name="ntceEndde" type="hidden" value='<c:out value="${result.ntceEndde}" />'>
	                                            	<input type="text" name="searchEndDe" id="searchEndDe" class="f_date" maxlength="10" value="<c:out value='${searchVO.searchEndDe}'/>" title="종료일자입력" />
	                                            	<br/><form:errors path="ntceBgndeView" />
	                                            	<br/><form:errors path="ntceEnddeView" />
	                                            </td>
	                                        </tr>
                                        </c:if>
                                        
                                        <!-- 파일첨부 시작 -->
                                        <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
	                                        <tr>
	                                            <td class="lb">
	                                            	<label for="egovComFileUploader" ><spring:message code="cop.atchFile" /></label>
	                                            </td>
	                                            <td>
	                                                <div class="board_attach2" id="file_upload_posbl">
	                                                    <input name="file_1" id="egovComFileUploader" type="file" />
	                                                    <div id="egovComFileList"></div>
	                                                </div>
	                                                <div class="board_attach2" id="file_upload_imposbl">
	                                                </div>
	                                                <c:if test="${empty result.atchFileId}">
											            <input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
											        </c:if>
	                                            </td>
	                                        </tr>
                                        </c:if>
                                        <!-- /파일첨부 끝 -->
                                        
                                        <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
				                        <script type="text/javascript">
				                            var maxFileNum = document.board.posblAtchFileNumber.value;
				                            if(maxFileNum==null || maxFileNum==""){
				                                maxFileNum = 3;
				                            } 
				                            var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
				                            multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
				                        </script>
	                        			</c:if>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                    	<c:if test="${bdMstr.authFlag == 'Y'}">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_regist_notice(); return fasle;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        </c:if>
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_noticeList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                </form:form>
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
