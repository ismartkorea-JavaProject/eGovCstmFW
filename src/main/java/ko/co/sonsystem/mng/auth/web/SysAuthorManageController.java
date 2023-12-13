package ko.co.sonsystem.mng.auth.web;

import javax.annotation.Resource;

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
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import ko.co.sonsystem.mng.auth.service.AuthorManage;
import ko.co.sonsystem.mng.auth.service.AuthorManageVO;
import ko.co.sonsystem.mng.auth.service.SysAuthorManageService;

/**
 * 권한관리에 관한 controller 클래스를 정의한다.
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
public class SysAuthorManageController {

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "sysAuthorManageService")
	private SysAuthorManageService sysAuthorManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/mng/auth/SysAuthorListView.do")
	public String selectAuthorListView() throws Exception {
		return "/mng/auth/SysAuthorManage";
	}

	/**
	 * 권한 목록을 조회한다
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/mng/auth/SysAuthorList.do")
	public String selectAuthorList(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, ModelMap model) throws Exception {
		
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorManageVO.getPageUnit());
		paginationInfo.setPageSize(authorManageVO.getPageSize());

		authorManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		authorManageVO.setAuthorManageList(sysAuthorManageService.selectAuthorList(authorManageVO));
		model.addAttribute("authorList", authorManageVO.getAuthorManageList());

		int totCnt = sysAuthorManageService.selectAuthorListTotCnt(authorManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

		return "/mng/auth/SysAuthorManage";
	}

	/**
	 * 권한 세부정보를 조회한다.
	 * @param authorCode String
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/mng/auth/SysAuthor.do")
	public String selectAuthor(@RequestParam("authorCode") String authorCode, @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, ModelMap model) throws Exception {

		authorManageVO.setAuthorCode(authorCode);

		model.addAttribute("authorManage", sysAuthorManageService.selectAuthor(authorManageVO));
		model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));
		return "/mng/auth/SysAuthorUpdate";
	}

	/**
	 * 권한 등록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/mng/auth/SysAuthorInsertView.do")
	public String insertAuthorView() throws Exception {
		return "/mng/auth/SysAuthorInsert";
	}

	/**
	 * 권한 세부정보를 등록한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/mng/auth/SysAuthorInsert.do")
	public String insertAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, BindingResult bindingResult, SessionStatus status, ModelMap model) throws Exception {

		beanValidator.validate(authorManage, bindingResult); //validation 수행

		if (bindingResult.hasErrors()) {
			return "/mng/auth/SysAuthorInsert";
		} else {
			sysAuthorManageService.insertAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			return "forward:/mng/auth/SysAuthor.do";
		}
	}

	/**
	 * 권한 세부정보를 수정한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/mng/auth/SysAuthorUpdate.do")
	public String updateAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		beanValidator.validate(authorManage, bindingResult); //validation 수행

		if (bindingResult.hasErrors()) {
			return "/mng/auth/SysAuthorUpdate";
		} else {
			sysAuthorManageService.updateAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
			return "forward:/mng/auth/SysAuthor.do";
		}
	}

	/**
	 * 권한 세부정보를 삭제한다.
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/mng/auth/SysAuthorDelete.do")
	public String deleteAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, SessionStatus status, Model model) throws Exception {

		sysAuthorManageService.deleteAuthor(authorManage);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/mng/auth/SysAuthorList.do";
	}

	/**
	 * 권한목록을 삭제한다.
	 * @param authorCodes String
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/mng/auth/SysAuthorListDelete.do")
	public String deleteAuthorList(@RequestParam("authorCodes") String authorCodes, @ModelAttribute("authorManage") AuthorManage authorManage, SessionStatus status, Model model)
			throws Exception {

		String[] strAuthorCodes = authorCodes.split(";");
		for (int i = 0; i < strAuthorCodes.length; i++) {
			authorManage.setAuthorCode(strAuthorCodes[i]);
			sysAuthorManageService.deleteAuthor(authorManage);
		}
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/mng/auth/SysAuthorList.do";
	}

	/**
	 * 권한제한 화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/mng/auth/accessDenied.do")
	public String accessDenied() throws Exception {
		return "auth/accessDenied";
	}
}
