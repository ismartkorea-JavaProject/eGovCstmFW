package ko.co.sonsystem.mng.auth.group.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import ko.co.sonsystem.mng.auth.group.service.AuthorGroup;
import ko.co.sonsystem.mng.auth.group.service.AuthorGroupVO;

/**
 * 권한그룹에 대한 DAO 클래스를 정의한다.
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

@Repository("sysAuthorGroupDAO")
public class SysAuthorGroupDAO extends EgovAbstractMapper {

	/**
	 * 그룹별 할당된 권한 목록 조회
	 * @param authorGroupVO AuthorGroupVO
	 * @return List<AuthorGroupVO>
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AuthorGroupVO> selectAuthorGroupList(AuthorGroupVO authorGroupVO) throws Exception {
		return (List<AuthorGroupVO>) list("system.auth.grp.authorGroupDAO.selectAuthorGroupList", authorGroupVO);
	}

	/**
	 * 그룹에 권한정보를 할당하여 데이터베이스에 등록
	 * @param authorGroup AuthorGroup
	 * @exception Exception
	 */
	public void insertAuthorGroup(AuthorGroup authorGroup) throws Exception {
		insert("system.auth.grp.authorGroupDAO.insertAuthorGroup", authorGroup);
	}

	/**
	 * 화면에 조회된 그룹권한정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param authorGroup AuthorGroup
	 * @exception Exception
	 */
	public void updateAuthorGroup(AuthorGroup authorGroup) throws Exception {
		update("system.auth.grp.authorGroupDAO.updateAuthorGroup", authorGroup);
	}

	/**
	 * 그룹별 할당된 시스템 메뉴 접근권한을 삭제
	 * @param authorGroup AuthorGroup
	 * @exception Exception
	 */
	public void deleteAuthorGroup(AuthorGroup authorGroup) throws Exception {
		delete("system.auth.grp.authorGroupDAO.deleteAuthorGroup", authorGroup);
	}

    /**
	 * 그룹권한목록 총 갯수를 조회한다.
	 * @param authorGroupVO AuthorGroupVO
	 * @return int
	 * @exception Exception
	 */
    public int selectAuthorGroupListTotCnt(AuthorGroupVO authorGroupVO) throws Exception {
        return (Integer)selectOne("system.auth.grp.authorGroupDAO.selectAuthorGroupListTotCnt", authorGroupVO);
    }
}