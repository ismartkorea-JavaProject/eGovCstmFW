package ko.co.sonsystem.mng.main.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.com.cmm.ComDefaultVO;
import ko.co.sonsystem.mng.menu.service.SysMenuManageService;
import lombok.extern.slf4j.Slf4j;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * @author s-onsystem
 * @since 2023.11.16
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2023.11.16  jeong          최초 생성
 *
 * </pre>
 */
@Slf4j
@Controller@SessionAttributes(types = ComDefaultVO.class)
public class MngMainController {
	
	/** SysMenuManageService */
	@Resource(name = "sysMeunManageService")
    private SysMenuManageService menuManageService;
	
	/**
	 * 메인 페이지 뷰 호출.
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/main/sysMainView.do")
	public String getMgtMainPageView(HttpServletRequest request, ModelMap model) throws Exception {
		
		log.debug("### MngMainController::getMngMainPageView Called !!! ###");
		
//    	LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;		
//    	if(EgovUserDetailsHelper.isAuthenticated() && user!=null){
//    		
//    		return "mng/main/SysMainView";
//    	} else {
//    		return "mng/login/SysLogin";
//    	}
		
		return "mng/main/SysMainView";
		
	}
	
	/**
     * Header Page를 조회한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "EgovIncHeader"
     * @exception Exception
     */
    @RequestMapping(value="/mng/main/SysIncHeader.do")
    public String selectHeader(ModelMap model) throws Exception {
    	return "mng/main/inc/SysIncHeader"; // 업무화면의 상단메뉴 화면

    }
    
	/**
     * Footer Page를 조회한다.
     * @param 
     * @return 출력페이지정보 "EgovIncFooter"
     * @exception Exception
     */
    @RequestMapping(value="/mng/main/SysIncFooter.do")
    public String selectFooter(ModelMap model) throws Exception {
    	return "mng/main/inc/SysIncFooter";
    }
    
    /**
     * 좌측메뉴를 조회한다.
     * @param 
     * @return 출력페이지정보 "SysIncLeftmenu"
     * @exception Exception
     */
    @RequestMapping(value="/mng/main/SysIncMenuLeft.do")
    public String selectMenuLeft(ModelMap model) throws Exception {

    	//LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;

    	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		/*
		 * if(EgovUserDetailsHelper.isAuthenticated()){ //인증된 경우 처리할 사항 추가 ...
		 * model.addAttribute("lastLogoutDateTime", "로그아웃 타임: 2021-08-12 11:30"); //최근
		 * 로그아웃 시간 등에 대한 확보 후 메인 컨텐츠로 활용 }
		 */

      	return "mng/main/inc/SysIncLeftmenu";
    }
    
    /**
     * 좌측메뉴를 조회한다.
     * @param 
     * @return 출력페이지정보 "SysIncNavi"
     * @exception Exception
     */
    @RequestMapping(value="/mng/main/SysIncNavi.do")
    public String selectNavi(ModelMap model) throws Exception {
      	return "mng/main/inc/SysIncNavi";
    } 
    
    /**
     * 스크립트 선언부분을 조회한다.
     * @param 
     * @return 출력페이지정보 "SysIncScripts"
     * @exception Exception
     */
    @RequestMapping(value="/mng/main/SysIncScripts.do")
    public String selectScripts(ModelMap model) throws Exception {
      	return "mng/main/inc/SysIncScripts";
    }     

}