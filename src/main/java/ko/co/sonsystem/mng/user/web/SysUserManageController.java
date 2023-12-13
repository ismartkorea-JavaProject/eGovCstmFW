package ko.co.sonsystem.mng.user.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
//import egovframework.com.jwt.config.JwtVerification;
import egovframework.let.utl.sim.service.EgovFileScrty;
import ko.co.sonsystem.mng.user.service.SysUserManageService;
import ko.co.sonsystem.mng.user.service.UserDefaultVO;
import ko.co.sonsystem.mng.user.service.UserManageVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 업무사용자관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
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
@Controller
public class SysUserManageController {
	
	/** JwtVerification */
	//@Autowired
	//private JwtVerification jwtVerification;	

	/** userManageService */
	@Resource(name = "sysUserManageService")
	private SysUserManageService userManageService;

	/** cmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/** DefaultBeanValidator beanValidator */
	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 사용자목록을 조회한다. (pageing)
	 * @param userSearchVO 검색조건정보
	 * @param model 화면모델
	 * @return /mng/usr/SysUserManage
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/usr/SysUserManage.do")
	public String selectUserList(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, ModelMap model, HttpServletRequest request) throws Exception {

		// 메인화면에서 넘어온 경우 메뉴 갱신을 위해 추가
		request.getSession().setAttribute("baseMenuNo", "6000000");
        
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) { 
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login")); 
			return "mng/login/SysLogin";
		}

//		if (!jwtVerification.isVerification(request)) {
//			return handleAuthError(resultVO); // 토큰 확인
//		}
    	
		/** EgovPropertyService */
		//userSearchVO.setPageUnit(propertyService.getInt("pageUnit"));
		//userSearchVO.setPageSize(propertyService.getInt("pageSize"));
		userSearchVO.setPageUnit(10);
		userSearchVO.setPageSize(10);		

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userSearchVO.getPageUnit());
		paginationInfo.setPageSize(userSearchVO.getPageSize());
		//paginationInfo.setRecordCountPerPage(propertyService.getInt("pageUnit"));
		//paginationInfo.setPageSize(propertyService.getInt("pageSize"));		

		userSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("resultList", userManageService.selectUserList(userSearchVO));

		int totCnt = userManageService.selectUserListTotCnt(userSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//사용자상태코드를 코드정보로부터 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM013");
		model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));//사용자상태코드목록

		return "mng/usr/SysUserManage";
	}

	/**
	 * 사용자등록화면으로 이동한다.
	 * @param userSearchVO 검색조건정보
	 * @param userManageVO 사용자초기화정보
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovUserInsert
	 * @throws Exception
	 */
	@RequestMapping("/mng/usr/SysUserInsertView.do")
	public String insertUserView(@ModelAttribute("userSearchVO") UserDefaultVO userSearchVO, @ModelAttribute("userManageVO") UserManageVO userManageVO, Model model)
			throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		if(isAuthenticated == null || !isAuthenticated) { 
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login")); 
			return "mng/login/SysLogin"; 
		}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//패스워드힌트목록을 코드정보로부터 조회
		vo.setCodeId("COM022");
		model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo)); //패스워트힌트목록

		//성별구분코드를 코드정보로부터 조회
		vo.setCodeId("COM014");
		//List sexdstnCode_result = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//사용자상태코드를 코드정보로부터 조회
		vo.setCodeId("COM013");
		model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//소속기관코드를 코드정보로부터 조회 - COM025
		vo.setCodeId("COM025");
		model.addAttribute("insttCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));

		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));

		return "mng/usr/SysUserInsert";
	}

	/**
	 * 사용자등록처리후 목록화면으로 이동한다.
	 * @param userManageVO 사용자등록정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return forward:/uss/umt/user/EgovUserManage.do
	 * @throws Exception
	 */
	@RequestMapping("/mng/usr/SysUserInsert.do")
	public String insertUser(@ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "mng/login/SysLogin";
    	}

		beanValidator.validate(userManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			ComDefaultCodeVO vo = new ComDefaultCodeVO();
			//패스워드힌트목록을 코드정보로부터 조회
			vo.setCodeId("COM022");
			model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo)); //패스워트힌트목록

			//성별구분코드를 코드정보로부터 조회
			vo.setCodeId("COM014");
			//List sexdstnCode_result = cmmUseService.selectCmmCodeDetail(vo);
			model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//사용자상태코드를 코드정보로부터 조회
			vo.setCodeId("COM013");
			model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//소속기관코드를 코드정보로부터 조회 - COM025
			vo.setCodeId("COM025");
			model.addAttribute("insttCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//조직정보를 조회 - ORGNZT_ID정보
			vo.setTableNm("LETTNORGNZTINFO");
			model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));

			//그룹정보를 조회 - GROUP_ID정보
			vo.setTableNm("LETTNORGNZTINFO");
			model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));
			//return "forward:/mng/usr/SysUserInsertView.do";
			return "mng/usr/SysUserInsert";
		} else {
			userManageService.insertUser(userManageVO);
			//Exception 없이 진행시 등록성공메시지
			model.addAttribute("resultMsg", "success.common.insert");
		}
		return "forward:/mng/usr/SysUserManage.do";
	}

	/**
	 * 사용자정보 수정을 위해 사용자정보를 상세조회한다.
	 * @param uniqId 상세조회대상 사용자아이디
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovUserSelectUpdt
	 * @throws Exception
	 */
	@RequestMapping("/mng/usr/SysUserSelectUpdtView.do")
	public String updateUserView(@RequestParam("selectedId") String uniqId, @ModelAttribute("searchVO") UserDefaultVO userSearchVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		if(isAuthenticated == null || !isAuthenticated) { 
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login")); 
			return "mng/login/SysLogin"; 
		}

		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//패스워드힌트목록을 코드정보로부터 조회
		vo.setCodeId("COM022");
		model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));

		//성별구분코드를 코드정보로부터 조회
		vo.setCodeId("COM014");
		model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//사용자상태코드를 코드정보로부터 조회
		vo.setCodeId("COM013");
		model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//소속기관코드를 코드정보로부터 조회 - COM025
		vo.setCodeId("COM025");
		model.addAttribute("insttCode_result", cmmUseService.selectCmmCodeDetail(vo));

		//조직정보를 조회 - ORGNZT_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));

		//그룹정보를 조회 - GROUP_ID정보
		vo.setTableNm("LETTNORGNZTINFO");
		model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));

		UserManageVO userManageVO = new UserManageVO();
		userManageVO = userManageService.selectUser(uniqId);
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("userManageVO", userManageVO);

		return "mng/usr/SysUserSelectUpdt";
		//return "mng/usr/SysUserSelectUpdt2";
	}

	/**
	 * 사용자정보 수정후 목록조회 화면으로 이동한다.
	 * @param userManageVO 사용자수정정보
	 * @param bindingResult 입력값검증용 bindingResult
	 * @param model 화면모델
	 * @return forward:/uss/umt/user/EgovUserManage.do
	 * @throws Exception
	 */
	@RequestMapping("/mng/usr/SysUserSelectUpdt.do")
	public String updateUser(@ModelAttribute("userManageVO") UserManageVO userManageVO, BindingResult bindingResult, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
		if(isAuthenticated == null || !isAuthenticated) { 
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login")); 
			return "mng/login/SysLogin"; 
		}

		beanValidator.validate(userManageVO, bindingResult);
		if (bindingResult.hasErrors()) {
			ComDefaultCodeVO vo = new ComDefaultCodeVO();

			//패스워드힌트목록을 코드정보로부터 조회
			vo.setCodeId("COM022");
			model.addAttribute("passwordHint_result", cmmUseService.selectCmmCodeDetail(vo));

			//성별구분코드를 코드정보로부터 조회
			vo.setCodeId("COM014");
			model.addAttribute("sexdstnCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//사용자상태코드를 코드정보로부터 조회
			vo.setCodeId("COM013");
			model.addAttribute("emplyrSttusCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//소속기관코드를 코드정보로부터 조회 - COM025
			vo.setCodeId("COM025");
			model.addAttribute("insttCode_result", cmmUseService.selectCmmCodeDetail(vo));

			//조직정보를 조회 - ORGNZT_ID정보
			vo.setTableNm("LETTNORGNZTINFO");
			model.addAttribute("orgnztId_result", cmmUseService.selectOgrnztIdDetail(vo));

			//그룹정보를 조회 - GROUP_ID정보
			vo.setTableNm("LETTNORGNZTINFO");
			model.addAttribute("groupId_result", cmmUseService.selectGroupIdDetail(vo));
			return "mng/usr/SysUserSelectUpdt";
		} else {
			//업무사용자 수정시 히스토리 정보를 등록한다.
			userManageService.insertUserHistory(userManageVO);
			userManageService.updateUser(userManageVO);
			//Exception 없이 진행시 수정성공메시지
			model.addAttribute("resultMsg", "success.common.update");
			return "forward:/mng/usr/SysUserManage.do";
		}
	}

	/**
	 * 사용자정보삭제후 목록조회 화면으로 이동한다.
	 * @param checkedIdForDel 삭제대상아이디 정보
	 * @param userSearchVO 검색조건
	 * @param model 화면모델
	 * @return forward:/uss/umt/user/EgovUserManage.do
	 * @throws Exception
	 */
	@RequestMapping("/mng/usr/SysUserDelete.do")
	public String deleteUser(@RequestParam("checkedIdForDel") String checkedIdForDel, @ModelAttribute("searchVO") UserDefaultVO userSearchVO, Model model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "mng/login/SysLogin";
    	}

		userManageService.deleteUser(checkedIdForDel);
		//Exception 없이 진행시 등록성공메시지
		model.addAttribute("resultMsg", "success.common.delete");
		return "forward:/mng/usr/SysUserManage.do";
	}

	/**
	 * 입력한 사용자아이디의 중복확인화면 이동
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovIdDplctCnfirm
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/usr/SysIdDplctCnfirmView.do")
	public String checkIdDplct(ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "mng/login/SysLogin";
    	}

		model.addAttribute("checkId", "");
		model.addAttribute("usedCnt", "-1");
		return "mng/usr/SysIdDplctCnfirm";
	}

	/**
	 * 입력한 사용자아이디의 중복여부를 체크하여 사용가능여부를 확인
	 * @param commandMap 파라메터전달용 commandMap
	 * @param model 화면모델
	 * @return cmm/uss/umt/EgovIdDplctCnfirm
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/usr/SysIdDplctCnfirm.do")
	public String checkIdDplct(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "mng/login/SysLogin";
    	}

		String checkId = (String) commandMap.get("checkId");
		checkId = new String(checkId.getBytes("ISO-8859-1"), "UTF-8");

		if (checkId == null || checkId.equals(""))
			return "forward:/uss/umt/EgovIdDplctCnfirmView.do";

		int usedCnt = userManageService.checkIdDplct(checkId);
		model.addAttribute("usedCnt", usedCnt);
		model.addAttribute("checkId", checkId);

		return "mng/usr/SysIdDplctCnfirm";
	}

	/**
	 * 업무사용자 암호 수정처리 후 화면 이동
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조 건
	 * @param userManageVO 사용자수정정보(비밀번호)
	 * @return cmm/uss/umt/EgovUserPasswordUpdt
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/usr/SysUserPasswordUpdt.do")
	public String updatePassword(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "mng/login/SysLogin";
    	}

		String oldPassword = (String) commandMap.get("oldPassword");
		String newPassword = (String) commandMap.get("newPassword");
		String newPassword2 = (String) commandMap.get("newPassword2");
		String uniqId = (String) commandMap.get("uniqId");

		boolean isCorrectPassword = false;
		UserManageVO resultVO = new UserManageVO();
		userManageVO.setPassword(newPassword);
		userManageVO.setOldPassword(oldPassword);
		userManageVO.setUniqId(uniqId);

		String resultMsg = "";
		resultVO = userManageService.selectPassword(userManageVO);
		//패스워드 암호화
		String encryptPass = EgovFileScrty.encryptPassword(oldPassword, userManageVO.getEmplyrId());
		if (encryptPass.equals(resultVO.getPassword())) {
			if (newPassword.equals(newPassword2)) {
				isCorrectPassword = true;
			} else {
				isCorrectPassword = false;
				resultMsg = "fail.user.passwordUpdate2";
			}
		} else {
			isCorrectPassword = false;
			resultMsg = "fail.user.passwordUpdate1";
		}

		if (isCorrectPassword) {
			userManageVO.setPassword(EgovFileScrty.encryptPassword(newPassword, userManageVO.getEmplyrId()));
			userManageService.updatePassword(userManageVO);
			model.addAttribute("userManageVO", userManageVO);
			resultMsg = "success.common.update";
		} else {
			model.addAttribute("userManageVO", userManageVO);
		}
		model.addAttribute("userSearchVO", userSearchVO);
		model.addAttribute("resultMsg", resultMsg);

		return "mng/usr/SysUserPasswordUpdt";
	}

	/**
	 * 업무사용자 암호 수정  화면 이동
	 * @param model 화면모델
	 * @param commandMap 파라메터전달용 commandMap
	 * @param userSearchVO 검색조건
	 * @param userManageVO 사용자수정정보(비밀번호)
	 * @return cmm/uss/umt/EgovUserPasswordUpdt
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/usr/SysUserPasswordUpdtView.do")
	public String updatePasswordView(ModelMap model, @RequestParam Map<String, Object> commandMap, @ModelAttribute("searchVO") UserDefaultVO userSearchVO,
			@ModelAttribute("userManageVO") UserManageVO userManageVO) throws Exception {

		// 미인증 사용자에 대한 보안처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
        	return "mng/login/SysLogin";
    	}

		String userTyForPassword = (String) commandMap.get("userTyForPassword");
		userManageVO.setUserTy(userTyForPassword);

		model.addAttribute("userManageVO", userManageVO);
		model.addAttribute("userSearchVO", userSearchVO);
		return "mng/usr/SysUserPasswordUpdt";
	}

}
