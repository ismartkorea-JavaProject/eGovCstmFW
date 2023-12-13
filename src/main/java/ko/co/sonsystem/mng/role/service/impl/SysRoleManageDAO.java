package ko.co.sonsystem.mng.role.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import ko.co.sonsystem.mng.role.service.RoleManage;
import ko.co.sonsystem.mng.role.service.RoleManageVO;

/**
 * 롤관리에 대한 DAO 클래스를 정의한다.
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

@Repository("sysRoleManageDAO")
public class SysRoleManageDAO extends EgovAbstractMapper {

	/**
	 * 등록된 롤 정보 조회
	 * @param roleManageVO RoleManageVO
	 * @return RoleManageVO
	 * @exception Exception
	 */
	public RoleManageVO selectRole(RoleManageVO roleManageVO) throws Exception {
		return (RoleManageVO) selectOne("system.role.roleManageDAO.selectRole", roleManageVO);
	}

	/**
	 * 등록된 롤 정보 목록 조회
	 * @param roleManageVO RoleManageVO
	 * @return List<RoleManageVO>
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<RoleManageVO> selectRoleList(RoleManageVO roleManageVO) throws Exception {
		return (List<RoleManageVO>) list("system.role.roleManageDAO.selectRoleList", roleManageVO);
	}

	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 등록
	 * @param roleManage RoleManage
	 * @exception Exception
	 */
	public void insertRole(RoleManage roleManage) throws Exception {
		insert("system.role.roleManageDAO.insertRole", roleManage);
	}
	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 수정
	 * @param roleManage RoleManage
	 * @exception Exception
	 */
	public void updateRole(RoleManage roleManage) throws Exception {
		update("system.role.roleManageDAO.updateRole", roleManage);
	}
	/**
	 * 불필요한 롤정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param roleManage RoleManage
	 * @exception Exception
	 */
	public void deleteRole(RoleManage roleManage) throws Exception {
		delete("system.role.roleManageDAO.deleteRole", roleManage);
	}

    /**
	 * 롤목록 총 갯수를 조회한다.
	 * @param roleManageVO RoleManageVO
	 * @return int
	 * @exception Exception
	 */
    public int selectRoleListTotCnt(RoleManageVO roleManageVO) throws Exception {
        return (Integer)selectOne("system.role.roleManageDAO.selectAuthorListTotCnt", roleManageVO);
    }

	/**
	 * 등록된 모든 롤 정보 목록 조회
	 * @param roleManageVO RoleManageVO
	 * @return List<RoleManageVO>
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<RoleManageVO> selectRoleAllList(RoleManageVO roleManageVO) throws Exception {
		return (List<RoleManageVO>) list("system.role.roleManageDAO.selectRoleAllList", roleManageVO);
	}

}