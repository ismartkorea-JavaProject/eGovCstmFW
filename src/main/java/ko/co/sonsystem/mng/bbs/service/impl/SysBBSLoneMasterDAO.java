package ko.co.sonsystem.mng.bbs.service.impl;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import ko.co.sonsystem.mng.bbs.service.BoardMaster;
import ko.co.sonsystem.mng.bbs.service.BoardMasterVO;


/**
 * 게시판 속성정보 관리를 위한 데이터 접근 클래스
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
@Repository("SysBBSLoneMasterDAO")
public class SysBBSLoneMasterDAO extends EgovAbstractMapper {

    /**
     * 등록된 게시판 속성정보를 삭제한다.
     *
     * @param BoardMaster
     */
    public void deleteMaster(BoardMaster boardMaster) throws Exception {
	update("system.bbs.BBSLoneMasterDAO.deleteMaster", boardMaster);
    }

    /**
     * 신규 게시판 속성정보를 등록한다.
     *
     * @param BoardMaster
     */
    public int insertMaster(BoardMaster boardMaster) throws Exception {
	return insert("system.bbs.BBSLoneMasterDAO.insertMaster", boardMaster);
    }

    /**
     * 게시판 속성정보 한 건을 상세조회 한다.
     *
     * @param BoardMasterVO
     */
    public BoardMasterVO selectMaster(BoardMaster vo) throws Exception {
	return (BoardMasterVO)selectOne("system.bbs.BBSLoneMasterDAO.selectMaster", vo);
    }

    /**
     * 게시판 속성정보 목록을 조회한다.
     *
     * @param BoardMasterVO
     */
    @SuppressWarnings("unchecked")
    public List<BoardMasterVO> selectMasterList(BoardMasterVO vo) throws Exception {
	return (List<BoardMasterVO>) list("system.bbs.BBSLoneMasterDAO.selectMasterList", vo);
    }

    /**
     * 게시판 속성정보 목록 숫자를 조회한다
     *
     * @param vo
     * @return
     * @throws Exception
     */
    public int selectMasterListCnt(BoardMasterVO vo) throws Exception {
	return (Integer)selectOne("system.bbs.BBSLoneMasterDAO.selectMasterListCnt", vo);
    }

    /**
     * 게시판 속성정보를 수정한다.
     *
     * @param BoardMaster
     */
    public void updateMaster(BoardMaster boardMaster) throws Exception {
	update("system.bbs.BBSLoneMasterDAO.updateMaster", boardMaster);
    }
}
