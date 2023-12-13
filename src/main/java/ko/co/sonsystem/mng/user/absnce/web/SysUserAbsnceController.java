package ko.co.sonsystem.mng.user.absnce.web;

import javax.annotation.Resource;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import ko.co.sonsystem.mng.user.absnce.service.SysUserAbsnceService;
import ko.co.sonsystem.mng.user.absnce.service.UserAbsnce;
import ko.co.sonsystem.mng.user.absnce.service.UserAbsnceVO;

/**
 * 사용자부재에 대한 controller 클래스를 정의한다.
 * 사용자부재에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * 사용자부재의 조회기능은 목록조회, 상세조회로 구분된다.
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
@Controller
public class SysUserAbsnceController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "sysUserAbsnceService")
	private SysUserAbsnceService sysUserAbsnceService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 사용자부재 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/mng/usr/abs/selectUserAbsnceListView.do")
	public String selectUserAbsnceListView() throws Exception {

		return "/mng/usr/abs/SysUserAbsnceList";
	}

	/**
	 * 사용자부재정보를 관리하기 위해 등록된 사용자부재 목록을 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/selectUserAbsnceList.do")
	public String selectUserAbsnceList(@RequestParam("selAbsnceAt") String selAbsnceAt, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userAbsnceVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(userAbsnceVO.getPageUnit());
		paginationInfo.setPageSize(userAbsnceVO.getPageSize());

		userAbsnceVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userAbsnceVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userAbsnceVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		userAbsnceVO.setSelAbsnceAt(selAbsnceAt);
		userAbsnceVO.setUserAbsnceList(sysUserAbsnceService.selectUserAbsnceList(userAbsnceVO));

		model.addAttribute("userAbsnceList", userAbsnceVO.getUserAbsnceList());

		int totCnt = sysUserAbsnceService.selectUserAbsnceListTotCnt(userAbsnceVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/mng/usr/abs/SysUserAbsnceList";
	}

	/**
	 * 등록된 사용자부재 상세정보를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/getUserAbsnce.do")
	public String selectUserAbsnce(@RequestParam("userId") String userId, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {

		userAbsnceVO.setUserId(userId);
		model.addAttribute("userAbsnce", sysUserAbsnceService.selectUserAbsnce(userAbsnceVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		UserAbsnceVO vo = (UserAbsnceVO) model.get("userAbsnce");

		if (vo.getRegYn().equals("N"))
			return "/mng/usr/abs/SysUserAbsnceRegist";
		else
			return "/mng/usr/abs/SysUserAbsnceUpdt";
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/addViewUserAbsnce.do")
	public String insertUserAbsnceView(@RequestParam("userId") String userId, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {
		userAbsnceVO.setUserId(userId);
		model.addAttribute("userAbsnce", sysUserAbsnceService.selectUserAbsnce(userAbsnceVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/mng/usr/abs/SysUserAbsnceRegist";
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/addUserAbsnce.do")
	public String insertUserAbsnce(@ModelAttribute("userAbsnce") UserAbsnce userAbsnce, @ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, BindingResult bindingResult,
			ModelMap model) throws Exception {

		beanValidator.validate(userAbsnce, bindingResult); //validation 수행

		if (bindingResult.hasErrors()) {
			model.addAttribute("userAbsnceVO", userAbsnceVO);
			return "/uss/ion/msi/SysMainImageRegist";
		} else {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userAbsnce.setLastUpdusrId(user.getId());
			// userAbsnce.setLastUpdusrId("jung");

			model.addAttribute("userAbsnce", sysUserAbsnceService.insertUserAbsnce(userAbsnce, userAbsnceVO));
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));

			return "/mng/usr/abs/SysUserAbsnceUpdt";
		}
	}

	/**
	 * 기 등록된 사용자부재정보를 수정한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/updtUserAbsnce.do")
	public String updateUserAbsnce(@ModelAttribute("userAbsnce") UserAbsnce userAbsnce, BindingResult bindingResult, ModelMap model) throws Exception {

		if (bindingResult.hasErrors()) {
			model.addAttribute("userAbsnceVO", userAbsnce);
			return "/mng/usr/abs/SysUserAbsnceUpdt";
		} else {

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userAbsnce.setLastUpdusrId(user.getId());
			//userAbsnce.setLastUpdusrId("jung");

			sysUserAbsnceService.updateUserAbsnce(userAbsnce);
			return "forward:/mng/usr/abs/getUserAbsnce.do";
		}
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/removeUserAbsnce.do")
	public String deleteUserAbsnce(@ModelAttribute("userAbsnce") UserAbsnce userAbsnce, ModelMap model) throws Exception {

		sysUserAbsnceService.deleteUserAbsnce(userAbsnce);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/mng/usr/abs/selectUserAbsnceList.do";
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/removeUserAbsnceList.do")
	public String deleteUserAbsnceList(@RequestParam("userIds") String userIds, @ModelAttribute("userAbsnce") UserAbsnce userAbsnce, ModelMap model) throws Exception {

		String[] strUserIds = userIds.split(";");

		for (int i = 0; i < strUserIds.length; i++) {
			userAbsnce.setUserId(strUserIds[i]);
			sysUserAbsnceService.deleteUserAbsnce(userAbsnce);
		}

		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/mng/usr/abs/selectUserAbsnceList.do";
	}

	/**
	 * MyPage에 사용자부재정보를 제공하기 위해 목록을 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return String - 리턴 Url
	 */
	@RequestMapping("/mng/usr/abs/selectUserAbsnceMainList.do")
	public String selectUserAbsnceMainList(@ModelAttribute("userAbsnceVO") UserAbsnceVO userAbsnceVO, ModelMap model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(userAbsnceVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(userAbsnceVO.getPageSize());

		userAbsnceVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		userAbsnceVO.setLastIndex(paginationInfo.getLastRecordIndex());
		userAbsnceVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		userAbsnceVO.setSelAbsnceAt("A");
		userAbsnceVO.setUserAbsnceList(sysUserAbsnceService.selectUserAbsnceList(userAbsnceVO));

		model.addAttribute("userAbsnceList", userAbsnceVO.getUserAbsnceList());

		return "/mng/usr/abs/SysUserAbsnceMainList";
	}
}
