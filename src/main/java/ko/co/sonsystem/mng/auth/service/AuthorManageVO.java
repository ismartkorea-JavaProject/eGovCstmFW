package ko.co.sonsystem.mng.auth.service;

import java.util.List;

/**
 * 권한관리에 대한 Vo 클래스를 정의한다.
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

public class AuthorManageVO extends AuthorManage {

	private static final long serialVersionUID = 1L;

	List <AuthorManageVO> authorManageList;

	/**
	 * authorManageList attribute 를 리턴한다.
	 * @return List<AuthorManageVO>
	 */
	public List<AuthorManageVO> getAuthorManageList() {
		return authorManageList;
	}

	/**
	 * authorManageList attribute 값을 설정한다.
	 * @param authorManageList List<AuthorManageVO> 
	 */
	public void setAuthorManageList(List<AuthorManageVO> authorManageList) {
		this.authorManageList = authorManageList;
	}



}