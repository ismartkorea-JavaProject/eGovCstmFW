package ko.co.sonsystem.api.bbs.web;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.cryptography.EgovCryptoService;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.ResponseCode;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.service.ResultVO;
import egovframework.com.cmm.web.EgovFileDownloadController;
import egovframework.let.utl.sim.service.EgovFileScrty;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import ko.co.sonsystem.mng.bbs.service.BoardMasterVO;
import ko.co.sonsystem.mng.bbs.service.BoardVO;
import ko.co.sonsystem.mng.bbs.service.SysBBSAttributeManageService;
import ko.co.sonsystem.mng.bbs.service.SysBBSManageService;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2023.11.16
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.11.16  jung          최초 생성
 *
 *  </pre>
 */
@RestController
@Tag(name="SysBBSApiController",description = "게시물 관리")
public class SysBBSApiController {
	
	@Resource(name = "SysBBSManageService")
	private SysBBSManageService bbsMngService;

	@Resource(name = "SysBBSAttributeManageService")
	private SysBBSAttributeManageService bbsAttrbService;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;
	
	/** 암호화서비스 */
    @Resource(name="egovARIACryptoService")
    EgovCryptoService cryptoService;

	//---------------------------------
	// 2009.06.29 : 2단계 기능 추가
	//---------------------------------
	//SHT-CUSTOMIZING//@Resource(name = "EgovBBSCommentService")
	//SHT-CUSTOMIZING//private EgovBBSCommentService bbsCommentService;

	//SHT-CUSTOMIZING//@Resource(name = "EgovBBSSatisfactionService")
	//SHT-CUSTOMIZING//private EgovBBSSatisfactionService bbsSatisfactionService;

	//SHT-CUSTOMIZING//@Resource(name = "EgovBBSScrapService")
	//SHT-CUSTOMIZING//private EgovBBSScrapService bbsScrapService;
	////-------------------------------

	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * 게시판 마스터 상세내용을 조회한다.
	 * 파일 첨부 가능 여부 조회용
	 *
	 * @param request
	 * @param searchVO
	 * @return resultVO
	 * @throws Exception
	 */
	@Operation(
			summary = "게시판 마스터 상세 조회",
			description = "게시판 마스터 상세내용을 조회 (파일 첨부가능 여부 조회용)",
			tags = {"SysBBSApiController"}
	)
	@ApiResponses(value = {
			@ApiResponse(responseCode = "200", description = "조회 성공"),
			@ApiResponse(responseCode = "403", description = "인가된 사용자가 아님")
	})
	@PostMapping(value = "/sys/api/bbs/selectUserBBSInfAPI.do", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResultVO selectUserBBSMasterInf(@RequestBody BoardMasterVO searchVO)
		throws Exception {
		ResultVO resultVO = new ResultVO();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(searchVO);
		resultMap.put("brdMstrVO", master);

		resultVO.setResult(resultMap);
		resultVO.setResultCode(ResponseCode.SUCCESS.getCode());
		resultVO.setResultMessage(ResponseCode.SUCCESS.getMessage());
		
		return resultVO;
	}

	/**
	 * 게시물에 대한 목록을 조회한다.
	 *
	 * @param boardVO
	 * @return resultVO
	 * @throws Exception
	 */
	@Operation(
			summary = "게시물 목록 조회",
			description = "게시물에 대한 목록을 조회",
			tags = {"EgovBBSManageApiController"}
	)
	@ApiResponses(value = {
			@ApiResponse(responseCode = "200", description = "조회 성공"),
			@ApiResponse(responseCode = "403", description = "인가된 사용자가 아님")
	})
	@PostMapping(value = "/sys/api/bbs/selectBoardListAPI.do", consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResultVO selectBoardArticles(@RequestBody BoardVO boardVO, @AuthenticationPrincipal LoginVO user)
		throws Exception {
		ResultVO resultVO = new ResultVO();

		BoardMasterVO vo = new BoardMasterVO();
		vo.setBbsId(boardVO.getBbsId());
		vo.setUniqId(user.getUniqId());

		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(propertyService.getInt("Globals.pageUnit"));
		paginationInfo.setPageSize(propertyService.getInt("Globals.pageSize"));

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> resultMap = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());

		int totCnt = Integer.parseInt((String)resultMap.get("resultCnt"));
		paginationInfo.setTotalRecordCount(totCnt);

		resultMap.put("boardVO", boardVO);
		resultMap.put("brdMstrVO", master);
		resultMap.put("paginationInfo", paginationInfo);
		resultMap.put("user", user);

		resultVO.setResultCode(ResponseCode.SUCCESS.getCode());
		resultVO.setResultMessage(ResponseCode.SUCCESS.getMessage());
		resultVO.setResult(resultMap);

		return resultVO;
	}

	/**
	 * 게시물에 대한 상세 정보를 조회한다.
	 *
	 * @param boardVO
	 * @return resultVO
	 * @throws Exception
	 */
	@Operation(
			summary = "게시물 상세 조회",
			description = "게시물에 대한 상세 정보를 조회",
			tags = {"SysBBSManageApiController"}
	)
	@ApiResponses(value = {
			@ApiResponse(responseCode = "200", description = "조회 성공"),
			@ApiResponse(responseCode = "403", description = "인가된 사용자가 아님")
	})
	@PostMapping(value = "/sys/api/bbs/selectBoardArticleAPI.do")
	public ResultVO selectBoardArticle(@RequestBody BoardVO boardVO,@AuthenticationPrincipal LoginVO user)
		throws Exception {

		ResultVO resultVO = new ResultVO();

		// 조회수 증가 여부 지정
		boardVO.setPlusCount(true);

		//---------------------------------
		// 2009.06.29 : 2단계 기능 추가
		//---------------------------------
		if (!boardVO.getSubPageIndex().equals("")) {
			boardVO.setPlusCount(false);
		}
		////-------------------------------

		boardVO.setLastUpdusrId(user.getUniqId());
		BoardVO vo = bbsMngService.selectBoardArticle(boardVO);

		//----------------------------
		// template 처리 (기본 BBS template 지정  포함)
		//----------------------------
		BoardMasterVO master = new BoardMasterVO();

		master.setBbsId(boardVO.getBbsId());
		master.setUniqId(user.getUniqId());

		BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
		
		//model.addAttribute("brdMstrVO", masterVo);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("boardVO", vo);
		resultMap.put("sessionUniqId", user.getUniqId());
		resultMap.put("brdMstrVO", masterVo);
		resultMap.put("user", user);

		// 2021-06-01 신용호 추가
		// 첨부파일 확인
		if (vo != null && vo.getAtchFileId() != null && !vo.getAtchFileId().isEmpty()) {
			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(vo.getAtchFileId());
			List<FileVO> resultFiles = fileService.selectFileInfs(fileVO);
			
			// FileId를 유추하지 못하도록 암호화하여 표시한다. (2022.12.06 추가) - 파일아이디가 유추 불가능하도록 조치
			for (FileVO file : resultFiles) {
				String toEncrypt = file.atchFileId;
				file.setAtchFileId(Base64.getEncoder().encodeToString(cryptoService.encrypt(toEncrypt.getBytes(),EgovFileDownloadController.ALGORITM_KEY)));
			}
						
			resultMap.put("resultFiles", resultFiles);
		}

		resultVO.setResult(resultMap);
		resultVO.setResultCode(ResponseCode.SUCCESS.getCode());
		resultVO.setResultMessage(ResponseCode.SUCCESS.getMessage());
		return resultVO;
	}

	/**
	 * 게시물에 대한 내용을 수정한다.
	 *
	 * @param boardVO
	 * @param multiRequest
	 * @param bindingResult
	 * @param request
	 * @return resultVO
	 * @throws Exception
	 */
	@Operation(
			summary = "게시물 수정",
			description = "게시물에 대한 내용을 수정",
			tags = {"SysBBSApiController"}
	)
	@ApiResponses(value = {
			@ApiResponse(responseCode = "200", description = "수정 성공"),
			@ApiResponse(responseCode = "403", description = "인가된 사용자가 아님"),
			@ApiResponse(responseCode = "900", description = "입력값 무결성 오류")
	})
	@PostMapping(value ="/sys/api/bbs/updateBoardArticleAPI.do")
	public ResultVO updateBoardArticle(final MultipartHttpServletRequest multiRequest,
		BoardVO boardVO,
		BindingResult bindingResult,
		HttpServletRequest request)
		throws Exception {
		ResultVO resultVO = new ResultVO();

		// 사용자권한 처리
		LoginVO user = new LoginVO();
		user.setUniqId("USRCNFRM_00000000000");

		String atchFileId = boardVO.getAtchFileId().replaceAll("\\s", "");

		beanValidator.validate(boardVO, bindingResult);
		if (bindingResult.hasErrors()) {

			resultVO.setResultCode(ResponseCode.INPUT_CHECK_ERROR.getCode());
			resultVO.setResultMessage(ResponseCode.INPUT_CHECK_ERROR.getMessage());

			return resultVO;
		}
	
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			if ("".equals(atchFileId)) {
				List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
				atchFileId = fileMngService.insertFileInfs(result);
				boardVO.setAtchFileId(atchFileId);
			} else {
				FileVO fvo = new FileVO();
				fvo.setAtchFileId(atchFileId);
				int cnt = fileMngService.getMaxFileSN(fvo);
				List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
				fileMngService.updateFileInfs(_result);
			}
		}

		boardVO.setLastUpdusrId(user.getUniqId());
		boardVO.setNtcrNm(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨) 
		boardVO.setPassword(EgovFileScrty.encryptPassword("", user.getUniqId())); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		boardVO.setNttCn(unscript(boardVO.getNttCn())); // XSS 방지

		bbsMngService.updateBoardArticle(boardVO);

		resultVO.setResultCode(ResponseCode.SUCCESS.getCode());
		resultVO.setResultMessage(ResponseCode.SUCCESS.getMessage());

		return resultVO;
	}

	/**
	 * 게시물을 등록한다.
	 *
	 * @param multiRequest
	 * @param boardVO
	 * @param bindingResult
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@Operation(
			summary = "게시물 등록",
			description = "게시물을 등록",
			tags = {"SysBBSApiController"}
	)
	@ApiResponses(value = {
			@ApiResponse(responseCode = "200", description = "등록 성공"),
			@ApiResponse(responseCode = "403", description = "인가된 사용자가 아님"),
			@ApiResponse(responseCode = "900", description = "입력값 무결성 오류")
	})
	@PostMapping(value ="/sys/api/bbs/insertBoardArticleAPI.do")
	public ResultVO insertBoardArticle(final MultipartHttpServletRequest multiRequest,
		BoardVO boardVO,
		BindingResult bindingResult,
		HttpServletRequest request)
		throws Exception {
		ResultVO resultVO = new ResultVO();

		LoginVO user = new LoginVO();
		user.setUniqId("USRCNFRM_00000000000");

		beanValidator.validate(boardVO, bindingResult);
		if (bindingResult.hasErrors()) {
			resultVO.setResultCode(ResponseCode.INPUT_CHECK_ERROR.getCode());
			resultVO.setResultMessage(ResponseCode.INPUT_CHECK_ERROR.getMessage());

			return resultVO;
		}
	
		List<FileVO> result = null;
		String atchFileId = "";

		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		if (!files.isEmpty()) {
			result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}
		boardVO.setAtchFileId(atchFileId);
		boardVO.setFrstRegisterId(user.getUniqId());
		boardVO.setBbsId(boardVO.getBbsId());

		boardVO.setNtcrNm(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		boardVO.setPassword(EgovFileScrty.encryptPassword("", user.getUniqId())); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		// board.setNttCn(unscript(board.getNttCn())); // XSS 방지

		bbsMngService.insertBoardArticle(boardVO);
	

		resultVO.setResultCode(ResponseCode.SUCCESS.getCode());
		resultVO.setResultMessage(ResponseCode.SUCCESS.getMessage());
		return resultVO;
	}

	/**
	 * 게시물에 대한 답변을 등록한다.
	 *
	 * @param multiRequest
	 * @param boardVO
	 * @param bindingResult
	 * @param request 
	 * @return resultVO
	 * @throws Exception
	 */
	@Operation(
			summary = "게시물 답변 등록",
			description = "게시물에 대한 답변을 등록",
			tags = {"EgovBBSManageApiController"}
	)
	@ApiResponses(value = {
			@ApiResponse(responseCode = "200", description = "등록 성공"),
			@ApiResponse(responseCode = "403", description = "인가된 사용자가 아님"),
			@ApiResponse(responseCode = "900", description = "입력값 무결성 오류")
	})
	@PostMapping(value ="/sys/api/bbs/replyBoardArticleAPI.do")
	public ResultVO replyBoardArticle(final MultipartHttpServletRequest multiRequest,
		BoardVO boardVO,
		BindingResult bindingResult,
		HttpServletRequest request)
		throws Exception {
		ResultVO resultVO = new ResultVO();

		LoginVO user = new LoginVO();
		user.setUniqId("USRCNFRM_00000000000");

		beanValidator.validate(boardVO, bindingResult);
		if (bindingResult.hasErrors()) {
			resultVO.setResultCode(ResponseCode.INPUT_CHECK_ERROR.getCode());
			resultVO.setResultMessage(ResponseCode.INPUT_CHECK_ERROR.getMessage());

			return resultVO;
		}
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		String atchFileId = "";

		if (!files.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
		}

		boardVO.setAtchFileId(atchFileId);
		boardVO.setReplyAt("Y");
		boardVO.setFrstRegisterId(user.getUniqId());
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setParnts(Long.toString(boardVO.getNttId()));
		boardVO.setSortOrdr(boardVO.getSortOrdr());
		boardVO.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));

		boardVO.setNtcrNm(""); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
		boardVO.setPassword(EgovFileScrty.encryptPassword("", user.getUniqId())); // dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)

		boardVO.setNttCn(unscript(boardVO.getNttCn())); // XSS 방지

		bbsMngService.insertBoardArticle(boardVO);
	

		//return "forward:/cop/bbs/selectBoardList.do";
		resultVO.setResultCode(ResponseCode.SUCCESS.getCode());
		resultVO.setResultMessage(ResponseCode.SUCCESS.getMessage());
		return resultVO;
	}

	/**
	 * 게시물에 대한 내용을 삭제한다.
	 *
	 * @param boardVO
	 * @param nttId
	 * @param request
	 * @return resultVO
	 * @throws Exception
	 */
	@Operation(
			summary = "게시물 삭제",
			description = "게시물에 대한 내용을 삭제",
			tags = {"SysBBSApiController"}
	)
	@ApiResponses(value = {
			@ApiResponse(responseCode = "200", description = "삭제 성공"),
			@ApiResponse(responseCode = "403", description = "인가된 사용자가 아님")
	})
	@PutMapping(value = "/sys/api/bbs/deleteBoardArticleAPI/{nttId}.do")
	public ResultVO deleteBoardArticle(@RequestBody BoardVO boardVO, 
		@PathVariable("nttId") String nttId,
		@AuthenticationPrincipal LoginVO user,
		HttpServletRequest request)

		throws Exception {
		ResultVO resultVO = new ResultVO();

		boardVO.setNttId(Long.parseLong(nttId));
		boardVO.setLastUpdusrId(user.getUniqId());

		bbsMngService.deleteBoardArticle(boardVO);
		
		resultVO.setResultCode(ResponseCode.SUCCESS.getCode());
		resultVO.setResultMessage(ResponseCode.SUCCESS.getMessage());

		return resultVO;
	}

	/**
	 * XSS 방지 처리.
	 *
	 * @param data
	 * @return
	 */
	protected String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}

		String ret = data;

		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");

		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");

		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");

		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");

		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

		return ret;
	}
	
	

}