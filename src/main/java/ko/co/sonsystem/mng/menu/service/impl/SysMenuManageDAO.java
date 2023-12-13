package ko.co.sonsystem.mng.menu.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import ko.co.sonsystem.mng.menu.service.MenuManageVO;
/**
 * 메뉴관리, 메뉴생성, 사이트맵 생성에 대한 DAO 클래스를 정의한다.
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

@Repository("sysMenuManageDAO")
public class SysMenuManageDAO extends EgovAbstractMapper{

	/**
	 * 메뉴목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List<?> selectMenuManageList(ComDefaultVO vo) throws Exception{
		return list("system.menu.menuManageDAO.selectMenuManageList_D", vo);
	}

    /**
	 * 메뉴목록관리 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectMenuManageListTotCnt(ComDefaultVO vo) {
        return (Integer)selectOne("system.menu.menuManageDAO.selectMenuManageListTotCnt_S", vo);
    }

	/**
	 * 메뉴목록관리 기본정보를 조회
	 * @param vo ComDefaultVO
	 * @return MenuManageVO
	 * @exception Exception
	 */
	public MenuManageVO selectMenuManage(ComDefaultVO vo)throws Exception{
		return (MenuManageVO)selectOne("system.menu.menuManageDAO.selectMenuManage_D", vo);
	}

	/**
	 * 메뉴목록 기본정보를 등록
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void insertMenuManage(MenuManageVO vo){
		insert("system.menu.menuManageDAO.insertMenuManage_S", vo);
	}

	/**
	 * 메뉴목록 기본정보를 수정
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void updateMenuManage(MenuManageVO vo){
		update("system.menu.menuManageDAO.updateMenuManage_S", vo);
	}

	/**
	 * 메뉴목록 기본정보를 삭제
	 * @param vo MenuManageVO
	 * @exception Exception
	 */
	public void deleteMenuManage(MenuManageVO vo){
		delete("system.menu.menuManageDAO.deleteMenuManage_S", vo);
	}

	/**
	 * 메뉴 전체목록을 조회
	 * @return list
	 * @exception Exception
	 */
	public List<?> selectMenuList() throws Exception{
		ComDefaultVO vo  = new ComDefaultVO();
		return list("system.menu.menuManageDAO.selectMenuListT_D", vo);
	}


	/**
	 * 메뉴번호 존재여부를 조회
	 * @param vo MenuManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectMenuNoByPk(MenuManageVO vo) throws Exception{
		return (Integer)selectOne("system.menu.menuManageDAO.selectMenuNoByPk", vo);
	}



	/**
	 * 메뉴번호를 상위메뉴로 참조하고 있는 메뉴 존재여부를 조회
	 * @param vo MenuManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectUpperMenuNoByPk(MenuManageVO vo) throws Exception{
		return (Integer)selectOne("system.menu.menuManageDAO.selectUpperMenuNoByPk", vo);
	}














	/**
	 * 메뉴정보 전체삭제 초기화
	 * @return boolean
	 * @exception Exception
	 */
	public boolean deleteAllMenuList(){
		MenuManageVO vo = new MenuManageVO();
		insert("system.menu.menuManageDAO.deleteAllMenuList", vo);
		return true;
	}

    /**
	 * 메뉴정보 존재여부 조회한다.
	 * @return int
	 * @exception Exception
	 */
    public int selectMenuListTotCnt() {
    	MenuManageVO vo = new MenuManageVO();
        return (Integer)selectOne("system.menu.menuManageDAO.selectMenuListTotCnt", vo);
    }


	/*### 메뉴관련 프로세스 ###*/
	/**
	 * MainMenu Head Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List<?> selectMainMenuHead(MenuManageVO vo) throws Exception{
		return list("system.menu.menuManageDAO.selectMainMenuHead", vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return List
	 * @exception Exception
	 */
	public List<?> selectMainMenuLeft(MenuManageVO vo) throws Exception{
		return list("system.menu.menuManageDAO.selectMainMenuLeft", vo);
	}

	/**
	 * MainMenu Head MenuURL 조회
	 * @param vo MenuManageVO
	 * @return  String
	 * @exception Exception
	 */
	public String selectLastMenuURL(MenuManageVO vo) throws Exception{
		return (String)selectOne("system.menu.menuManageDAO.selectLastMenuURL", vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectLastMenuNo(MenuManageVO vo) throws Exception{
		return (Integer)selectOne("system.menu.menuManageDAO.selectLastMenuNo", vo);
	}

	/**
	 * MainMenu Left Menu 조회
	 * @param vo MenuManageVO
	 * @return int
	 * @exception Exception
	 */
	public int selectLastMenuNoCnt(MenuManageVO vo) throws Exception{
		return (Integer)selectOne("system.menu.menuManageDAO.selectLastMenuNoCnt", vo);
	}
}