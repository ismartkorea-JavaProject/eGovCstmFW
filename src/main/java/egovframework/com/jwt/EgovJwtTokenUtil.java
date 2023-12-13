package egovframework.com.jwt;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

import org.springframework.stereotype.Component;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovProperties;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author : 정완배
 * @since : 2023. 8. 9.
 * @version : 1.0
 *
 * @package : egovframework.com.jwt
 * @filename : EgovJwtTokenUtil.java
 * @modificationInformation
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *  수정일            수정자             수정내용
 *  ----------   ----------   ----------------------
 *  2023. 8. 9.    정완배              주석추가
 * </pre>
 *
 *
 */
//security 관련 제외한 jwt util 클래스
@Slf4j
@Component
public class EgovJwtTokenUtil implements Serializable{

	private static final long serialVersionUID = -5180902194184255251L;
	//public static final long JWT_TOKEN_VALIDITY = 24 * 60 * 60; //하루
	public static final long JWT_TOKEN_VALIDITY = (long) ((1 * 60 * 60) / 60) * 60; //토큰의 유효시간 설정, 기본 60분
	
	public static final String SECRET_KEY = EgovProperties.getProperty("Globals.jwt.secret");
	
	//retrieve username from jwt token (4.1버전 추가)
    public String getUsernameFromToken(String token) {
        return getClaimFromToken(token, Claims::getSubject);
    }	
	
	//retrieve username from jwt token
    public String getUserIdFromToken(String token) {
        Claims claims = getClaimFromToken(token);
        return claims.get("id").toString();
    }
    public String getUserSeFromToken(String token) {
        Claims claims = getClaimFromToken(token);
        return claims.get("userSe").toString();
    }
    public String getInfoFromToken(String type, String token) {
        Claims claims = getClaimFromToken(token);
        return claims.get(type).toString();
    }
    
    //retrieve expiration date from jwt token (4.1버전 추가)
    public Date getExpirationDateFromToken(String token) {
        return getClaimFromToken(token, Claims::getExpiration);
    }    
    
    public Claims getClaimFromToken(String token) {
        final Claims claims = getAllClaimsFromToken(token);
        return claims;
    }
    // (4.1버전 추가)
    public <T> T getClaimFromToken(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = getAllClaimsFromToken(token);
        return claimsResolver.apply(claims);
    }    
	
    //for retrieveing any information from token we will need the secret key
    public Claims getAllClaimsFromToken(String token) {
    	
    	log.debug("===>>> getAllClaimsFromToken::token = "+token);
    	log.debug("===>>> getAllClaimsFromToken::secret = "+SECRET_KEY);
    	log.debug("===>>> getAllClaimsFromToken::Jwts.parser() : " + Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).getBody() + "");
    	
        return Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(token).getBody();
    }
    
    //check if the token has expired (4.1버전 추가)
    private Boolean isTokenExpired(String token) {
        final Date expiration = getExpirationDateFromToken(token);
        return expiration.before(new Date());
    }    

    //generate token for user
    public String generateToken(LoginVO loginVO) {
        return doGenerateToken(loginVO, "Authorization");
    }

	//while creating the token -
	//1. Define  claims of the token, like Issuer, Expiration, Subject, and the ID
	//2. Sign the JWT using the HS512 algorithm and secret key.
	//3. According to JWS Compact Serialization(https://tools.ietf.org/html/draft-ietf-jose-json-web-signature-41#section-3.1)
	//   compaction of the JWT to a URL-safe string
    private String doGenerateToken(LoginVO loginVO, String subject) {
    	
    	log.debug(">>> doGenerateToken::loginVO : " + loginVO.toString());

        Map<String, Object> claims = new HashMap<>();
        claims.put("id", loginVO.getId() );
        claims.put("name", loginVO.getName() );
        claims.put("userSe", loginVO.getUserSe() );
        claims.put("orgnztId", loginVO.getOrgnztId() );
        claims.put("uniqId", loginVO.getUniqId() );
        claims.put("type", subject);
        
        log.debug("===>>> doGenerateToken <<<===");
    	log.debug("===>>> secret = "+SECRET_KEY);
        return Jwts.builder().setClaims(claims).setSubject(subject).setIssuedAt(new Date(System.currentTimeMillis()))
            .setExpiration(new Date(System.currentTimeMillis() + JWT_TOKEN_VALIDITY * 1000))
            .signWith(SignatureAlgorithm.HS512, SECRET_KEY).compact();
    }
    
    //validate token (4.1버전 추가)
    public Boolean validateToken(String token, LoginVO loginVO) {
        final String username = getUsernameFromToken(token);
        return (username.equals(loginVO.getUserSe()+loginVO.getId()) && !isTokenExpired(token));
    }    


}
