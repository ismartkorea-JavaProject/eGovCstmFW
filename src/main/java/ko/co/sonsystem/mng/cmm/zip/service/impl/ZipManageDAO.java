package ko.co.sonsystem.mng.cmm.zip.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import ko.co.sonsystem.mng.cmm.zip.service.Zip;
import ko.co.sonsystem.mng.cmm.zip.service.ZipVO;

/**
 *
 * 우편번호에 대한 데이터 접근 클래스를 정의한다
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
@Repository("ZipManageDAO")
public class ZipManageDAO extends EgovAbstractMapper {

	/**
	 * 우편번호를 삭제한다.
	 * @param zip
	 * @throws Exception
	 */
	public void deleteZip(Zip zip) throws Exception {
		delete("system.cmm.zip.ZipManageDAO.deleteZip", zip);
	}

	/**
	 * 우편번호 전체를 삭제한다.
	 * @throws Exception
	 */
	public void deleteAllZip() throws Exception {
		delete("system.cmm.zip.ZipManageDAO.deleteAllZip", new Object());
	}

	/**
	 * 우편번호를 등록한다.
	 * @param zip
	 * @throws Exception
	 */
	public void insertZip(Zip zip) throws Exception {
        insert("system.cmm.zip.ZipManageDAO.insertZip", zip);
	}

	/**
	 * 우편번호 엑셀파일을 등록한다.
	 * @param zip
	 * @throws Exception
	 */
	public void insertExcelZip() throws Exception {
		delete("ZipManageDAO.deleteAllZip", new Object());
	}


	/**
	 * 우편번호 상세항목을 조회한다.
	 * @param zip
	 * @return Zip(우편번호)
	 */
	public Zip selectZipDetail(Zip zip) throws Exception {
		return (Zip) selectOne("system.cmm.zip.ZipManageDAO.selectZipDetail", zip);
	}


    /**
	 * 우편번호 목록을 조회한다.
     * @param searchVO
     * @return List(우편번호 목록)
     * @throws Exception
     */
	public List<?> selectZipList(ZipVO searchVO) throws Exception {
        return list("system.cmm.zip.ZipManageDAO.selectZipList", searchVO);
    }

    /**
	 * 우편번호 총 갯수를 조회한다.
     * @param searchVO
     * @return int(우편번호 총 갯수)
     */
    public int selectZipListTotCnt(ZipVO searchVO) throws Exception {
        return (Integer)selectOne("system.cmm.zip.ZipManageDAO.selectZipListTotCnt", searchVO);
    }

	/**
	 * 우편번호를 수정한다.
	 * @param zip
	 * @throws Exception
	 */
	public void updateZip(Zip zip) throws Exception {
		update("system.cmm.zip.ZipManageDAO.updateZip", zip);
	}

}
