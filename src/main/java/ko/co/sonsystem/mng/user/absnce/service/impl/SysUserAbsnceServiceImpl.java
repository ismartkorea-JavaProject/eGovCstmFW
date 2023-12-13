package ko.co.sonsystem.mng.user.absnce.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import ko.co.sonsystem.mng.user.absnce.service.SysUserAbsnceService;
import ko.co.sonsystem.mng.user.absnce.service.UserAbsnce;
import ko.co.sonsystem.mng.user.absnce.service.UserAbsnceVO;
/**
 * 사용자부재에 대한 ServiceImpl 클래스를 정의한다.
 * 사용자부재에 대한 등록, 수정, 삭제, 조회, 반영확인 기능을 제공한다.
 * 사용자부재의 조회기능은 목록조회, 상세조회로 구분된다.
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
@Service("sysUserAbsnceService")
public class SysUserAbsnceServiceImpl extends EgovAbstractServiceImpl implements SysUserAbsnceService {

	@Resource(name="sysUserAbsnceDAO")
	private SysUserAbsnceDAO userAbsnceDAO;

	/**
	 * 사용자부재정보를 관리하기 위해 등록된 사용자부재 목록을 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return List - 사용자부재 목록
	 */
	public List<UserAbsnceVO> selectUserAbsnceList(UserAbsnceVO userAbsnceVO) throws Exception {
		return userAbsnceDAO.selectUserAbsnceList(userAbsnceVO);
	}

	/**
	 * 사용자부재정보목록 총 갯수를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return int - 사용자부재 카운트 수
	 */
	public int selectUserAbsnceListTotCnt(UserAbsnceVO userAbsnceVO) throws Exception {
		return userAbsnceDAO.selectUserAbsnceListTotCnt(userAbsnceVO);
	}

	/**
	 * 등록된 사용자부재 상세정보를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO selectUserAbsnce(UserAbsnceVO userAbsnceVO) throws Exception {
		return userAbsnceDAO.selectUserAbsnce(userAbsnceVO);
	}

	/**
	 * 사용자부재정보를 신규로 등록한다.
	 * @param userAbsnce - 사용자부재 model
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO insertUserAbsnce(UserAbsnce userAbsnce, UserAbsnceVO userAbsnceVO) throws Exception {
		userAbsnceDAO.insertUserAbsnce(userAbsnce);
		userAbsnceVO.setUserId(userAbsnce.getUserId());
		return selectUserAbsnce(userAbsnceVO);
	}

	/**
	 * 기 등록된 사용자부재정보를 수정한다.
	 * @param userAbsnce - 사용자부재 model
	 */
	public void updateUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		userAbsnceDAO.updateUserAbsnce(userAbsnce);
	}

	/**
	 * 기 등록된 사용자부재정보를 삭제한다.
	 * @param userAbsnce - 사용자부재 model
	 */
	public void deleteUserAbsnce(UserAbsnce userAbsnce) throws Exception {
		userAbsnceDAO.deleteUserAbsnce(userAbsnce);
	}

	/**
	 * 사용자부재정보가 특정화면에 반영된 결과를 조회한다.
	 * @param userAbsnceVO - 사용자부재 VO
	 * @return UserAbsnceVO - 사용자부재 VO
	 */
	public UserAbsnceVO selectUserAbsnceResult(UserAbsnceVO userAbsnceVO) throws Exception {
		return null;
	}
}
