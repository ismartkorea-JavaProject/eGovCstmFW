package ko.co.sonsystem.mng.log.syslog.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import ko.co.sonsystem.mng.log.syslog.service.SysSytmLog;

/**
 * 로그관리(시스템)를 위한 데이터 접근 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.03.11
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이삼섭          최초 생성
 *   2011.07.01  이기하          패키지 분리(sym.log -> sym.log.lgm)
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */
@Repository("SysSytmLogDAO")
public class SysSytmLogDAO extends EgovAbstractMapper {

	/**
	 * 시스템 로그정보를 생성한다.
	 *
	 * @param SysLog
	 * @return
	 * @throws Exception
	 */
	public void logInsertSysLog(SysSytmLog sysLog) throws Exception{
		insert("system.log.SysLogDAO.logInsertSysLog", sysLog);
	}

	/**
	 * 시스템 로그정보를 요약한다.
	 *
	 * @param
	 * @return
	 * @throws Exception
	 */
	public void logInsertSysLogSummary() throws Exception{
		insert("system.log.SysLogDAO.logInsertSysLogSummary", null);
		delete("system.log.SysLogDAO.logDeleteSysLogSummary", null);
	}

	/**
	 * 시스템 로그정보를 조회한다.
	 *
	 * @param sysLog
	 * @return sysLog
	 * @throws Exception
	 */
	public SysSytmLog selectSysLog(SysSytmLog sysLog) throws Exception{

		return (SysSytmLog) selectOne("system.log.SysLogDAO.selectSysLog", sysLog);
	}

	/**
	 * 시스템 로그정보 목록을 조회한다.
	 *
	 * @param sysLog
	 * @return
	 * @throws Exception
	 */
	public List<?> selectSysLogInf(SysSytmLog sysLog) throws Exception{
		return list("system.log.SysLogDAO.selectSysLogInf", sysLog);
	}

	/**
	 * 시스템 로그정보 목록의 숫자를 조회한다.
	 * @param sysLog
	 * @return
	 * @throws Exception
	 */
	public int selectSysLogInfCnt(SysSytmLog sysLog) throws Exception{

		return (Integer)selectOne("system.log.SysLogDAO.selectSysLogInfCnt", sysLog);
	}

}
