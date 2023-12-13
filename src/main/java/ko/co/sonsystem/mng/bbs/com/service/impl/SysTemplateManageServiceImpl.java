package ko.co.sonsystem.mng.bbs.com.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Service;

import ko.co.sonsystem.mng.bbs.com.service.SysTemplateManageService;
import ko.co.sonsystem.mng.bbs.com.service.TemplateInf;
import ko.co.sonsystem.mng.bbs.com.service.TemplateInfVO;

/**
 * 템플릿 정보관리를 위한 서비스 구현 클래스
 * @author s-onsystem
 * @since 2023.11.16
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2023.11.16  jeong          최초 생성
 *
 *  </pre>
 */
@Service("SysTemplateManageService")
public class SysTemplateManageServiceImpl extends EgovAbstractServiceImpl implements SysTemplateManageService {

    @Resource(name = "SysTemplateManageDAO")
    private SysTemplateManageDAO tmplatDAO;

    @Resource(name = "egovTmplatIdGnrService")
    private EgovIdGnrService idgenService;

    /**
     * 템플릿 정보를 삭제한다.
     * 
     * @see egovframework.let.cop.bbs.com.service.EgovTemplateManageService#deleteTemplateInf(egovframework.let.cop.bbs.com.service.TemplateInf)
     */
    public void deleteTemplateInf(TemplateInf tmplatInf) throws Exception {
	tmplatDAO.deleteTemplateInf(tmplatInf);
    }

    /**
     * 템플릿 정보를 등록한다.
     * 
     * @see egovframework.let.cop.bbs.com.service.EgovTemplateManageService#insertTemplateInf(egovframework.let.cop.bbs.com.service.TemplateInf)
     */
    public void insertTemplateInf(TemplateInf tmplatInf) throws Exception {

	tmplatInf.setTmplatId(idgenService.getNextStringId());

	tmplatDAO.insertTemplateInf(tmplatInf);
    }

    /**
     * 템플릿에 대한 상세정보를 조회한다.
     * 
     * @see egovframework.let.cop.bbs.com.service.EgovTemplateManageService#selectTemplateInf(egovframework.let.cop.bbs.com.service.TemplateInfVO)
     */
    public TemplateInfVO selectTemplateInf(TemplateInfVO tmplatInfVO) throws Exception {
	TemplateInfVO vo = new TemplateInfVO();
	vo = tmplatDAO.selectTemplateInf(tmplatInfVO);
	return vo;
    }

    /**
     * 템플릿에 대한 목록를 조회한다.
     * 
     * @see egovframework.let.cop.bbs.com.service.EgovTemplateManageService#selectTemplateInfs(egovframework.let.cop.bbs.com.service.TemplateInfVO)
     */
    public Map<String, Object> selectTemplateInfs(TemplateInfVO tmplatInfVO) throws Exception {
	List<TemplateInfVO> result = tmplatDAO.selectTemplateInfs(tmplatInfVO);
	int cnt = tmplatDAO.selectTemplateInfsCnt(tmplatInfVO);
	
	Map<String, Object> map = new HashMap<String, Object>();
	
	map.put("resultList", result);
	map.put("resultCnt", Integer.toString(cnt));

	return map;
    }

    /**
     * 템플릿에 대한 미리보기 정보를 조회한다.
     * 
     * @see egovframework.let.cop.bbs.com.service.EgovTemplateManageService#selectTemplatePreview(egovframework.let.cop.bbs.com.service.TemplateInfVO)
     */
    public TemplateInfVO selectTemplatePreview(TemplateInfVO tmplatInfVO) throws Exception {
	TemplateInfVO vo = new TemplateInfVO();
	
	vo = tmplatDAO.selectTemplatePreview(tmplatInfVO);
	
	return vo;
    }

    /**
     * 템플릿 정보를 수정한다.
     * 
     * @see egovframework.let.cop.bbs.com.service.EgovTemplateManageService#updateTemplateInf(egovframework.let.cop.bbs.com.service.TemplateInf)
     */
    public void updateTemplateInf(TemplateInf tmplatInf) throws Exception {
	tmplatDAO.updateTemplateInf(tmplatInf);
    }

    /**
     * 템플릿 구분에 따른 목록을 조회한다.
     * 
     * @see egovframework.let.cop.bbs.com.service.EgovTemplateManageService#selectAllTemplateInfs(egovframework.let.cop.bbs.com.service.TemplateInfVO)
     */
    public List<TemplateInfVO> selectTemplateInfsByCode(TemplateInfVO tmplatInfVO) throws Exception {
	return tmplatDAO.selectTemplateInfsByCode(tmplatInfVO);
    }
}
