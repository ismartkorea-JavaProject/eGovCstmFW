package ko.co.sonsystem.mng.auth.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import ko.co.sonsystem.mng.auth.service.AuthorManage;
import ko.co.sonsystem.mng.auth.service.AuthorManageVO;

/**
 * 권한관리에 대한 DAO 클래스를 정의한다.
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

@Repository("sysAuthorManageDAO")
public class SysAuthorManageDAO extends EgovAbstractMapper {

    /**
	 * 권한목록을 조회한다.
	 * @param authorManageVO AuthorManageVO
	 * @return List<AuthorManageVO>
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List<AuthorManageVO> selectAuthorList(AuthorManageVO authorManageVO) throws Exception {
        return (List<AuthorManageVO>) list("system.auth.authorManageDAO.selectAuthorList", authorManageVO);
    }

	/**
	 * 권한을 등록한다.
	 * @param authorManage AuthorManage
	 * @exception Exception
	 */
    public void insertAuthor(AuthorManage authorManage) throws Exception {
        insert("system.auth.authorManageDAO.insertAuthor", authorManage);
    }

    /**
	 * 권한을 수정한다.
	 * @param authorManage AuthorManage
	 * @exception Exception
	 */
    public void updateAuthor(AuthorManage authorManage) throws Exception {
        update("system.auth.authorManageDAO.updateAuthor", authorManage);
    }

    /**
	 * 권한을 삭제한다.
	 * @param authorManage AuthorManage
	 * @exception Exception
	 */
    public void deleteAuthor(AuthorManage authorManage) throws Exception {
        delete("system.auth.authorManageDAO.deleteAuthor", authorManage);
    }

    /**
	 * 권한을 조회한다.
	 * @param authorManageVO AuthorManageVO
	 * @return AuthorManageVO
	 * @exception Exception
	 */
    public AuthorManageVO selectAuthor(AuthorManageVO authorManageVO) throws Exception {
        return (AuthorManageVO) selectOne("system.auth.authorManageDAO.selectAuthor", authorManageVO);
    }

    /**
	 * 권한목록 총 갯수를 조회한다.
	 * @param authorManageVO AuthorManageVO
	 * @return int
	 * @exception Exception
	 */
    public int selectAuthorListTotCnt(AuthorManageVO authorManageVO)  throws Exception {
        return (Integer)selectOne("system.auth.authorManageDAO.selectAuthorListTotCnt", authorManageVO);
    }

    /**
	 * 모든 권한목록을 조회한다.
	 * @param authorManageVO AuthorManageVO
	 * @return List<AuthorManageVO>
	 * @exception Exception
	 */
    @SuppressWarnings("unchecked")
	public List<AuthorManageVO> selectAuthorAllList(AuthorManageVO authorManageVO) throws Exception {
        return (List<AuthorManageVO>) list("system.auth.authorManageDAO.selectAuthorAllList", authorManageVO);
    }
}
