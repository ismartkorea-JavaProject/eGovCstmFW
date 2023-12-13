package ko.co.sonsystem.mng.log.syslog.web;

import java.util.HashMap;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ko.co.sonsystem.mng.log.syslog.service.SysSytmLog;
import ko.co.sonsystem.mng.log.syslog.service.SysSytmLogService;

/**
 * 시스템 로그정보를 관리하기 위한 컨트롤러 클래스
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
public class SysSytmLogController {

	@Resource(name="SysSytmLogService")
	private SysSytmLogService sysLogService;

	@Resource(name="propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * 시스템 로그 목록 조회
	 *
	 * @param sysLog
	 * @return mng/log/system/SelectSysLogList
	 * @throws Exception
	 */
	@RequestMapping(value="/mng/log/system/SelectSysLogList.do")
	public String selectSysLogInf(@ModelAttribute("searchVO") SysSytmLog sysLog,
			ModelMap model) throws Exception{

		//sysLog.setPageUnit(propertyService.getInt("pageUnit"));
		//sysLog.setPageSize(propertyService.getInt("pageSize"));
		sysLog.setPageUnit(10);
		sysLog.setPageSize(10);		

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sysLog.getPageIndex());
		paginationInfo.setRecordCountPerPage(sysLog.getPageUnit());
		paginationInfo.setPageSize(sysLog.getPageSize());

		sysLog.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sysLog.setLastIndex(paginationInfo.getLastRecordIndex());
		sysLog.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		HashMap<?, ?> _map = (HashMap<?, ?>)sysLogService.selectSysLogInf(sysLog);
		int totCnt = Integer.parseInt((String)_map.get("resultCnt"));

		model.addAttribute("resultList", _map.get("resultList"));
		model.addAttribute("resultCnt", _map.get("resultCnt"));

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "mng/log/system/SysLogList";
	}

	/**
	 * 시스템 로그 상세 조회
	 *
	 * @param sysLog
	 * @param model
	 * @return mng/log/system/InqireSysLog
	 * @throws Exception
	 */
	@RequestMapping(value="/mng/log/system/InqireSysLog.do")
	public String selectSysLog(@ModelAttribute("searchVO") SysSytmLog sysLog,
			@RequestParam("requstId") String requstId,
			ModelMap model) throws Exception{

		sysLog.setRequstId(requstId.trim());

		SysSytmLog vo = sysLogService.selectSysLog(sysLog);
		model.addAttribute("result", vo);
		return "mng/log/system/SysLogInqire";
	}

}
