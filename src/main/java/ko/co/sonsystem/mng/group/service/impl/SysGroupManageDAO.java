package ko.co.sonsystem.mng.group.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import ko.co.sonsystem.mng.group.service.GroupManage;
import ko.co.sonsystem.mng.group.service.GroupManageVO;

/**
 * 그룹관리에 대한 DAO 클래스를 정의한다.
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

@Repository("sysGroupManageDAO")
public class SysGroupManageDAO extends EgovAbstractMapper {

	/**
	 * 검색조건에 따른 그룹정보를 조회
	 * @param groupManageVO GroupManageVO
	 * @return GroupManageVO
	 * @exception Exception
	 */
	public GroupManageVO selectGroup(GroupManageVO groupManageVO) throws Exception {
		return (GroupManageVO) selectOne("system.grp.groupManageDAO.selectGroup", groupManageVO);
	}

	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * @param groupManageVO GroupManageVO
	 * @return GroupManageVO
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<GroupManageVO> selectGroupList(GroupManageVO groupManageVO) throws Exception {
		return (List<GroupManageVO>) list("system.grp.groupManageDAO.selectGroupList", groupManageVO);
	}

	/**
	 * 그룹 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param groupManage GroupManage
	 * @exception Exception
	 */
	public void insertGroup(GroupManage groupManage) throws Exception {
		insert("system.grp.groupManageDAO.insertGroup", groupManage);
	}

	/**
	 * 화면에 조회된 그룹의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param groupManage GroupManage
	 * @exception Exception
	 */
	public void updateGroup(GroupManage groupManage) throws Exception {
		update("system.grp.groupManageDAO.updateGroup", groupManage);
	}

	/**
	 * 불필요한 그룹정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param groupManage GroupManage
	 * @exception Exception
	 */
	public void deleteGroup(GroupManage groupManage) throws Exception {
		delete("system.grp.groupManageDAO.deleteGroup", groupManage);
	}

    /**
	 * 롤목록 총 갯수를 조회한다.
	 * @param groupManageVO GroupManageVO
	 * @return int
	 * @exception Exception
	 */
    public int selectGroupListTotCnt(GroupManageVO groupManageVO) throws Exception {
        return (Integer)selectOne("system.grp.groupManageDAO.selectGroupListTotCnt", groupManageVO);
    }
}