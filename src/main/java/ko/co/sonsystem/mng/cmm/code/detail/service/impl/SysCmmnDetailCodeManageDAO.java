package ko.co.sonsystem.mng.cmm.code.detail.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.CmmnDetailCode;
import ko.co.sonsystem.mng.cmm.code.detail.service.CmmnDetailCodeVO;

/**
 *
 * 공통상세코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("SysCmmnDetailCodeManageDAO")
public class SysCmmnDetailCodeManageDAO extends EgovAbstractMapper {

	/**
	 * 공통상세코드를 삭제한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	public void deleteCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception {
		delete("system.cmm.code.CmmnDetailCodeManageDAO.deleteCmmnDetailCode", cmmnDetailCode);
	}


	/**
	 * 공통상세코드를 등록한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	public void insertCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception {
        insert("system.cmm.code.CmmnDetailCodeManageDAO.insertCmmnDetailCode", cmmnDetailCode);
	}

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param cmmnDetailCode
	 * @return CmmnDetailCode(공통상세코드)
	 */
	public CmmnDetailCode selectCmmnDetailCodeDetail(CmmnDetailCode cmmnDetailCode) throws Exception {
		return (CmmnDetailCode) selectOne("system.cmm.code.CmmnDetailCodeManageDAO.selectCmmnDetailCodeDetail", cmmnDetailCode);
	}


    /**
	 * 공통상세코드 목록을 조회한다.
     * @param searchVO
     * @return List(공통상세코드 목록)
     * @throws Exception
     */
	public List<?> selectCmmnDetailCodeList(CmmnDetailCodeVO searchVO) throws Exception {
        return list("system.cmm.code.CmmnDetailCodeManageDAO.selectCmmnDetailCodeList", searchVO);
    }

    /**
	 * 공통상세코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통상세코드 총 갯수)
     */
    public int selectCmmnDetailCodeListTotCnt(CmmnDetailCodeVO searchVO) throws Exception {
        return (Integer)selectOne("system.cmm.code.CmmnDetailCodeManageDAO.selectCmmnDetailCodeListTotCnt", searchVO);
    }

	/**
	 * 공통상세코드를 수정한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	public void updateCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception {
		update("system.cmm.code.CmmnDetailCodeManageDAO.updateCmmnDetailCode", cmmnDetailCode);
	}

}
