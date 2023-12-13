package ko.co.sonsystem.mng.cmm.zip.web;

import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.LoginVO;
import ko.co.sonsystem.mng.cmm.zip.service.SysCcmZipManageService;
import ko.co.sonsystem.mng.cmm.zip.service.Zip;
import ko.co.sonsystem.mng.cmm.zip.service.ZipVO;

/**
 *
 * 우편번호에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
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
public class SysCcmZipManageController {
	private static final Logger LOGGER = LoggerFactory.getLogger(SysCcmZipManageController.class);

	@Resource(name = "ZipManageService")
	private SysCcmZipManageService zipManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private DefaultBeanValidator beanValidator;

	/**
	 * 우편번호 찾기 팝업 메인창을 호출한다.
	 * @param model
	 * @return "/mng/cmm/zip/SysCcmZipSearchPopup"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmZipSearchPopup.do")
	public String callNormalCalPopup(ModelMap model) throws Exception {
		return "/mng/cmm/zip/SysCcmZipSearchPopup";
	}

	/**
	 * 우편번호 찾기 목록을 조회한다.
	 * @param searchVO
	 * @param model
	 * @return "/mng/cmm/zip/SysCcmZipSearchList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmZipSearchList.do")
	public String selectZipSearchList(@ModelAttribute("searchVO") ZipVO searchVO, ModelMap model) throws Exception {
		/** EgovPropertyService.sample */
		//searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		//searchVO.setPageSize(propertiesService.getInt("pageSize"));
		searchVO.setPageUnit(10);
		searchVO.setPageSize(10);		

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("resultList", zipManageService.selectZipList(searchVO));

		int totCnt = zipManageService.selectZipListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/mng/cmm/zip/SysCcmZipSearchList";
	}

	/**
	 * 우편번호를 삭제한다.
	 * @param loginVO
	 * @param zip
	 * @param model
	 * @return "forward:/mng/cmm/zip/SysCcmZipList.do"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmZipRemove.do")
	public String deleteZip(@ModelAttribute("loginVO") LoginVO loginVO, Zip zip, ModelMap model) throws Exception {
		zipManageService.deleteZip(zip);
		return "forward:/mng/cmm/zip/SysCcmZipList.do";
	}

	/**
	 * 우편번호를 등록한다.
	 * @param loginVO
	 * @param zip
	 * @param bindingResult
	 * @param model
	 * @return "/mng/cmm/zip/SysCcmZipRegist"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmZipRegist.do")
	public String insertZip(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("zip") Zip zip, BindingResult bindingResult, ModelMap model) throws Exception {
		if (zip.getZip() == null || zip.getZip().equals("")) {

			return "/mng/cmm/zip/SysCcmZipRegist";
		}

		beanValidator.validate(zip, bindingResult);
		if (bindingResult.hasErrors()) {
			return "/mng/cmm/zip/SysCcmZipRegist";
		}

		zip.setFrstRegisterId(loginVO.getUniqId());
		zipManageService.insertZip(zip);
		return "forward:/mng/cmm/zip/SysCcmZipList.do";
	}

	/**
	 * 엑셀파일을 업로드하여 우편번호를 등록한다.
	 * @param loginVO
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return "/mng/cmm/zip/SysCcmExcelZipRegist"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmExcelZipRegist.do")
	public String insertExcelZip(@ModelAttribute("loginVO") LoginVO loginVO, final HttpServletRequest request, @RequestParam Map<String, Object> commandMap, Model model)
			throws Exception {

		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");
		if (sCmd.equals("")) {
			return "/mng/cmm/zip/SysCcmExcelZipRegist";
		}

		final MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file = null;
		InputStream fis = null;
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			try {

				file = entry.getValue();
				fis = file.getInputStream();
				if (!"".equals(file.getOriginalFilename())) {
					// 2011.10.07 업로드 파일에 대한 확장자를 체크
					if (file.getOriginalFilename().toLowerCase().endsWith(".xls") || file.getOriginalFilename().toLowerCase().endsWith(".xlsx")) {

						//zipManageService.deleteAllZip();
						//excelZipService.uploadExcel("ZipManageDAO.insertExcelZip", file.getInputStream(), 2);
						zipManageService.insertExcelZip(fis);

					} else {
						//log.info("xls, xlsx 파일 타입만 등록이 가능합니다.");
						return "egovframework/com/mng/cmm/zip/SysCcmExcelZipRegist";
					}
					// *********** 끝 ***********
				}

			} finally {
				try {
					if (fis != null) {
						fis.close();
					}
				} catch (IOException ee) {
					LOGGER.debug("{}", ee);
				}
			}

		}

		return "forward:/mng/cmm/zip/SysCcmZipList.do";
	}

	/**
	 * 우편번호 상세항목을 조회한다.
	 * @param loginVO
	 * @param zip
	 * @param model
	 * @return "/mng/cmm/zip/SysCcmZipDetail"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmZipDetail.do")
	public String selectZipDetail(@ModelAttribute("loginVO") LoginVO loginVO, Zip zip, ModelMap model) throws Exception {
		Zip vo = zipManageService.selectZipDetail(zip);
		model.addAttribute("result", vo);

		return "/mng/cmm/zip/SysCcmZipDetail";
	}

	/**
	 * 우편번호 목록을 조회한다.
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/mng/cmm/zip/SysCcmZipList"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmZipList.do")
	public String selectZipList(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("searchVO") ZipVO searchVO, ModelMap model) throws Exception {
		/** EgovPropertyService.sample */
		//searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		//searchVO.setPageSize(propertiesService.getInt("pageSize"));
		searchVO.setPageUnit(10);
		searchVO.setPageSize(10);		

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("resultList", zipManageService.selectZipList(searchVO));

		int totCnt = zipManageService.selectZipListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "/mng/cmm/zip/SysCcmZipList";
	}

	/**
	 * 우편번호를 수정한다.
	 * @param loginVO
	 * @param zip
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/mng/cmm/zip/SysCcmZipModify"
	 * @throws Exception
	 */
	@RequestMapping(value = "/mng/cmm/zip/SysCcmZipModify.do")
	public String updateZip(@ModelAttribute("loginVO") LoginVO loginVO, @ModelAttribute("zip") Zip zip, BindingResult bindingResult, @RequestParam Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		String sCmd = commandMap.get("cmd") == null ? "" : (String) commandMap.get("cmd");
		if (sCmd.equals("")) {
			Zip vo = zipManageService.selectZipDetail(zip);
			model.addAttribute("zip", vo);

			return "/mng/cmm/zip/SysCcmZipModify";
		} else if (sCmd.equals("Modify")) {
			beanValidator.validate(zip, bindingResult);
			if (bindingResult.hasErrors()) {
				return "/mng/cmm/zip/SysCcmZipModify";
			}

			zip.setLastUpdusrId(loginVO.getUniqId());
			zipManageService.updateZip(zip);

			return "forward:/mng/cmm/zip/SysCcmZipList.do";
		} else {
			return "forward:/mng/cmm/zip/SysCcmZipList.do";
		}
	}
}