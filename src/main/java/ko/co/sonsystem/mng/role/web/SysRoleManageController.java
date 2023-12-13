package ko.co.sonsystem.mng.role.web;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
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

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovCmmUseService;
import ko.co.sonsystem.mng.auth.service.AuthorManageVO;
import ko.co.sonsystem.mng.auth.service.SysAuthorManageService;
import ko.co.sonsystem.mng.role.service.RoleManage;
import ko.co.sonsystem.mng.role.service.RoleManageVO;
import ko.co.sonsystem.mng.role.service.SysRoleManageService;

/**
 * 롤관리에 관한 controller 클래스를 정의한다.
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
public class SysRoleManageController {

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name = "sysRoleManageService")
    private SysRoleManageService sysRoleManageService;

    @Resource(name = "EgovCmmUseService")
    EgovCmmUseService egovCmmUseService;

    @Resource(name = "sysAuthorManageService")
    private SysAuthorManageService sysAuthorManageService;

    /** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

    /** Message ID Generation */
    @Resource(name="egovRoleIdGnrService")
    private EgovIdGnrService egovRoleIdGnrService;

    @Autowired
	private DefaultBeanValidator beanValidator;

    /**
	 * 롤 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/mng/role/SysRoleListView.do")
    public String selectRoleListView()
            throws Exception {
        return "/mng/role/SysRoleManage";
    }

	/**
	 * 등록된 롤 정보 목록 조회
	 * @param roleManageVO RoleManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/role/SysRoleList.do")
	public String selectRoleList(@ModelAttribute("roleManageVO") RoleManageVO roleManageVO,
			                      ModelMap model) throws Exception {

    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(roleManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(roleManageVO.getPageUnit());
		paginationInfo.setPageSize(roleManageVO.getPageSize());

		roleManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		roleManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		roleManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		roleManageVO.setRoleManageList(sysRoleManageService.selectRoleList(roleManageVO));
        model.addAttribute("roleList", roleManageVO.getRoleManageList());

        int totCnt = sysRoleManageService.selectRoleListTotCnt(roleManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("message", egovMessageSource.getMessage("success.common.select"));

        return "/mng/role/SysRoleManage";
	}

	/**
	 * 등록된 롤 정보 조회
	 * @param roleCode String
	 * @param roleManageVO RoleManageVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/role/SysRole.do")
	public String selectRole(@RequestParam("roleCode") String roleCode,
	                         @ModelAttribute("roleManageVO") RoleManageVO roleManageVO,
	                         @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
		                      ModelMap model) throws Exception {

    	roleManageVO.setRoleCode(roleCode);

    	authorManageVO.setAuthorManageList(sysAuthorManageService.selectAuthorAllList(authorManageVO));

    	model.addAttribute("roleManage", sysRoleManageService.selectRole(roleManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"COM029"));

        return "/mng/role/SysRoleUpdate";
	}

    /**
	 * 롤 등록화면 이동
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/mng/role/SysRoleInsertView.do")
    public String insertRoleView(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
    		                      ModelMap model) throws Exception {

    	authorManageVO.setAuthorManageList(sysAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"COM029"));

        return "/mng/role/SysRoleInsert";
    }

    /**
	 * 공통코드 호출
	 * @param comDefaultCodeVO ComDefaultCodeVO
	 * @param codeId String
	 * @return List
	 * @exception Exception
	 */
	public List<?> getCmmCodeDetailList(ComDefaultCodeVO comDefaultCodeVO, String codeId)  throws Exception {
    	comDefaultCodeVO.setCodeId(codeId);
    	return egovCmmUseService.selectCmmCodeDetail(comDefaultCodeVO);
    }

	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 등록
	 * @param roleManage RoleManage
	 * @param roleManageVO RoleManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/role/SysRoleInsert.do")
	public String insertRole(@ModelAttribute("roleManage") RoleManage roleManage,
			                 @ModelAttribute("roleManageVO") RoleManageVO roleManageVO,
			                  BindingResult bindingResult,
			                  SessionStatus status,
                              ModelMap model) throws Exception {

    	beanValidator.validate(roleManage, bindingResult); //validation 수행

    	if (bindingResult.hasErrors()) {
			return "/mng/role/SysRoleInsert";
		} else {
    	    String roleTyp = roleManage.getRoleTyp();
	    	if(roleTyp.equals("method"))
	    		roleTyp = "mtd";
	    	else if(roleTyp.equals("pointcut"))
	    		roleTyp = "pct";
	    	else roleTyp = "web";

	    	roleManage.setRoleCode(roleTyp.concat("-").concat(egovRoleIdGnrService.getNextStringId()));
	    	roleManageVO.setRoleCode(roleManage.getRoleCode());

	    	status.setComplete();
	        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"COM029"));
	    	model.addAttribute("message", egovMessageSource.getMessage("success.common.insert"));
	        model.addAttribute("roleManage", sysRoleManageService.insertRole(roleManage, roleManageVO));

	        return "/mng/role/SysRoleUpdate";
		}
	}

	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 수정
	 * @param roleManage RoleManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/role/SysRoleUpdate.do")
	public String updateRole(@ModelAttribute("roleManage") RoleManage roleManage,
			BindingResult bindingResult,
			SessionStatus status,
            ModelMap model) throws Exception {

    	beanValidator.validate(roleManage, bindingResult); //validation 수행
    	if (bindingResult.hasErrors()) {
			return "/mng/role/SysRoleUpdate";
		} else {
    	sysRoleManageService.updateRole(roleManage);
    	status.setComplete();
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
    	return "forward:/mng/role/SysRole.do";
		}
	}

	/**
	 * 불필요한 롤정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param roleManage RoleManage
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/mng/role/SysRoleDelete.do")
	public String deleteRole(@ModelAttribute("roleManage") RoleManage roleManage,
            SessionStatus status,
            ModelMap model) throws Exception {

    	sysRoleManageService.deleteRole(roleManage);
    	status.setComplete();
    	model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
    	return "forward:/mng/role/SysRoleList.do";

	}

	/**
	 * 불필요한 그룹정보 목록을 화면에 조회하여 데이터베이스에서 삭제
	 * @param roleCodes String
	 * @param roleManage RoleManage
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/mng/role/SysRoleListDelete.do")
	public String deleteRoleList(@RequestParam("roleCodes") String roleCodes,
			                     @ModelAttribute("roleManage") RoleManage roleManage,
	                              SessionStatus status,
	                              Model model) throws Exception {
    	String [] strRoleCodes = roleCodes.split(";");
    	for(int i=0; i<strRoleCodes.length;i++) {
    		roleManage.setRoleCode(strRoleCodes[i]);
    		sysRoleManageService.deleteRole(roleManage);
    	}
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/mng/role/SysRoleList.do";
	}

}