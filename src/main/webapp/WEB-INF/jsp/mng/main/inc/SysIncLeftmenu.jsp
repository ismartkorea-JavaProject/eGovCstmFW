<%-- 
  Class Name : SysIncLeftmenu.jsp 
  Description : 메뉴(Navi) 부분
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.11.16   jeong       경량환경 버전 생성
 
    author   : s-onsystem
    since    : 2023.11.16 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">Core</div>
                            <a class="nav-link" href="/mng/main/sysMainView.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                대쉬보드
                            </a>
                            <div class="sb-sidenav-menu-heading">Interface</div>                           
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse1Pages" aria-expanded="false" aria-controls="collapsePages">
                            	<div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                            	메뉴 관리
                            	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapse1Pages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="/mng/menu/create/SysMenuCreatManageSelect.do">메뉴 생성</a>                                 
                                    <a class="nav-link collapsed" href="/mng/menu/SysMenuManageSelect.do">메뉴 목록</a>
                                </nav>
                            </div>                            
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse2Pages" aria-expanded="false" aria-controls="collapsePages">
                            	<div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                            	사용자 관리
                            	<div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapse2Pages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="/mng/usr/SysUserManage.do">사용자 관리</a>                                 
                                    <a class="nav-link collapsed" href="/mng/usr/abs/selectUserAbsnceListView.do">부재자 관리</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse3Pages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                공통 코드 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapse3Pages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="/mng/cmm/clcode/SysCcmCmmnClCodeList.do">Cl 코드</a>                                 
                                    <a class="nav-link collapsed" href="/mng/cmm/code/SysCcmCmmnCodeList.do">공통 코드</a>
                                    <a class="nav-link collapsed" href="/mng/cmm/code/SysCcmCmmnDetailCodeList.do">공통 상세 코드</a>
                                </nav>
                            </div>                          
                            <a class="nav-link collapsed" href="/mng/grp/SysGroupList.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>그룹 관리
                            </a>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse4Pages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                게시판 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapse4Pages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="/mng/bbs/SelectBBSMasterInfs.do">게시판 생성 관리</a>
                                    <a class="nav-link collapsed" href="/mng/bbs/com/selectBBSUseInfs.do">게시판 사용 관리</a>
                                    <a class="nav-link collapsed" href="/mng/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA&trgetId=SYSTEM_DEFAULT_BOARD">공지사항 관리</a>
                                    <a class="nav-link collapsed" href="/mng/bbs/selectBoardList.do?bbsId=BBSMSTR_BBBBBBBBBBBB">사이트갤러리 관리</a>
                                </nav>
                            </div>                            
                            <a class="nav-link collapsed" href="/mng/prm/SysProgramListManageSelect.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                프로그램 관리
                            </a>
                            <a class="nav-link collapsed" href="/mng/role/SysRoleList.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                롤 관리
                            </a>
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse5Pages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                권한 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapse5Pages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="/mng/auth/SysAuthorList.do">권한 관리</a>
                                    <a class="nav-link collapsed" href="/mng/auth/grp/SysAuthorGroupListView.do">그룹권한 관리</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="/mng/policy/selectLoginPolicyListView.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                정책 관리
                            </a>                                                      
                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapse6Pages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                접속 관리
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapse6Pages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="/mng/log/login/SelectLoginLogList.do">접속로그관리</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="/mng/cmm/zip/SysCcmZipList.do">
                                <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                                우편번호 관리
                            </a>                                                         
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>