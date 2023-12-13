<%-- 
  Class Name : SysNoticeInqire.jsp 
  Description : 게시물 조회 화면
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
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <!-- Header -->
 <c:import url="/mng/main/SysIncHeader.do" />
 <!--// Header -->
 
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
    function onloading() {
        if ("<c:out value='${msg}'/>" != "") {
            alert("<c:out value='${msg}'/>");
        }
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/mng/bbs${prefix}/selectBoardList.do'/>";
        document.frm.submit();  
    }
    
    function fn_egov_delete_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('등록시 사용한 패스워드를 입력해 주세요.');
            document.frm.password.focus();
            return;
        }
        
        if (confirm('<spring:message code="common.delete.msg" />')) {
            document.frm.action = "<c:url value='/mng/bbs${prefix}/deleteBoardArticle.do'/>";
            document.frm.submit();
        }   
    }
    
    function fn_egov_moveUpdt_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('등록시 사용한 패스워드를 입력해 주세요.');
            document.frm.password.focus();
            return;
        }

        document.frm.action = "<c:url value='/mng/bbs${prefix}/forUpdateBoardArticle.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_addReply() {
        document.frm.action = "<c:url value='/mng/bbs${prefix}/addReplyBoardArticle.do'/>";
        document.frm.submit();
    }
</script>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<c:if test="${useComment == 'true'}">
<c:import url="/mng/bbs/selectCommentList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useSatisfaction == 'true'}">
<c:import url="/mng/bbs/selectSatisfactionList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useScrap == 'true'}">
<script type="text/javascript">
    function fn_egov_addScrap() {
        document.frm.action = "<c:url value='/mng/bbs/addScrap.do'/>";
        document.frm.submit();          
    }
</script>
</c:if>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<title>내부업무 사이트 > 알림정보 > <c:out value='${result.bbsNm}'/></title>
 
    </head>
    <body class="sb-nav-fixed" onload="onloading();">
    
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
                               <li><a href="">알림정보</a></li>
                               <li><c:out value='${result.bbsNm}'/></li>
                           </ul>
                       </div>
                       <!--// Location -->                    
                    
 
                        <div class="card mb-4">
							<!--<div style="height: 100vh">-->

								<form name="frm" method="post" action="<c:url value='/mng/bbs${prefix}/selectBoardList.do'/>">
								
			                    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
			                    <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
			                    <input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
			                    <input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
			                    <input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
			                    <input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
			                    <input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >

                                <h2 class="tit_2"><c:out value='${result.bbsNm}'/></h2>

                                <!-- 게시판 상세보기 -->
                                <div class="board_view">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="${result.nttSj}" /></div>
                                        <div class="info">
                                            <dl>
                                                <dt>작성자</dt>
                                                <dd>
                                                	<c:choose>
                                                		<c:when test="${anonymous == 'true'}">
                                                			******
                                                		</c:when>
                                                		<c:when test="${result.ntcrNm == ''}">
                                                			<c:out value="${result.frstRegisterNm}" />
                                                		</c:when>
                                                		<c:otherwise>
                                                			<c:out value="${result.ntcrNm}" />
                                                		</c:otherwise>
                                                	</c:choose>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dt>작성일</dt>
                                                <dd><c:out value="${result.frstRegisterPnttm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>조회수</dt>
                                                <dd><c:out value="${result.inqireCo}" /></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="board_article">
										<textarea id="nttCn" name="nttCn" class="textarea" cols="30" rows="10" readonly="readonly" title="글내용"><c:out value="${result.nttCn}" escapeXml="true" /></textarea>
                                    </div>

									<c:if test="${not empty result.atchFileId}">
										<c:if test="${result.bbsAttrbCode == 'BBSA02'}">
		                                    <div class="board_attach">
		                                        <dl>
		                                            <dt>첨부이미지</dt>
		                                            <dd>
		                                                <c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
		                                                	<c:param name="atchFileId" value="${egovc:encryptSession(result.atchFileId, pageContext.session.id)}" />
		                                                </c:import>
		                                            </dd>
		                                        </dl>
		                                    </div>
		                                </c:if>
		                                <div class="board_attach">
	                                        <dl>
	                                            <dt>첨부파일</dt>
	                                            <dd>
	                                                <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                                        <c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
				                                    </c:import>
	                                            </dd>
	                                        </dl>
	                                    </div>
	                                </c:if>
	                                
                                    <c:if test="${anonymous == 'true'}">
                                    	<div class="board_attach">
	                                    	<dl>
                                                <dt><label for="password"><spring:message code="cop.password" /></label></dt>
                                                <dd><input name="password" title="암호" type="password" size="20" value="" maxlength="20" ></dd>
                                            </dl>
                                           </div>
                                    </c:if>

									<!-- 목록/저장버튼  -->
                                    <div class="board_view_bot">
                                        <div class="left_col btn3">
                                        	<c:if test="${result.frstRegisterId == sessionUniqId}">
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_moveUpdt_notice(); return false;">수정</a><!-- 수정 -->
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_delete_notice(); return false;">삭제</a><!-- 삭제 -->
                                            </c:if>
                                            <c:if test="${result.replyPosblAt == 'Y'}">
                                            	<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_addReply(); return false;">답글작성</a><!-- 답글작성 -->
                                            </c:if>
                                        </div>

                                        <div class="right_col btn1">
                                            <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_noticeList('1'); return false;">목록</a><!-- 목록 -->
                                        </div>
                                    </div>
                                    <!-- // 목록/저장버튼 끝  -->
                                </div>
                                
                                </form>
                                
                                <!-- 게시판 상세보기 -->			
							
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
