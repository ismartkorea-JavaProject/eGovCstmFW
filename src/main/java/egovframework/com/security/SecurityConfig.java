package egovframework.com.security;

import java.util.Arrays;

import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import egovframework.com.cmm.LoginVO;
import egovframework.com.jwt.JwtAuthenticationFilter;

/**
 * fileName       : SecurityConfig
 * author         : s-onsystem
 * date           : 2023/11/16
 * description    :
 * ===========================================================
 * DATE              AUTHOR             NOTE
 * -----------------------------------------------------------
 * 2023/11/16        jeong       최초 생성
 * @param <T>
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
    //Http Methpd : Get 인증예외 List
    private String[] AUTH_GET_WHITELIST = {
            "/schedule/daily", //일별 일정 조회
            "/schedule/week", //주간 일정 조회
            "/schedule/{schdulId}", //일정 상세조회
    };
	
    // 인증 예외 List
    private String[] AUTH_WHITELIST = {
    		"/",
    		"/**",
    		"/css/**",
    		"/images/**",
    		"/js/**",
            "/mng/login/**",
            "/mng/login/loginView.do", // 관리자 로그인 추가.
            "/mng/login/actionSecurityLogin.do",            
            "/mng/main/sysMainView.do", // 관리자 로그인 추가.
            "/mng/main/**.do", // 관리자 로그인 추가.            
            "/mng/usr/**.do",
            "/mng/bbs/**.do",
            "/mng/com/bbs/**.do",

            "/cmm/fms/FileDown.do", //파일 다운로드
            "/cmm/fms/getImage.do", //갤러리 이미지보기
            "/sb-admin/**", // sb-admin 추가.
            
            "/v2/api-docs",
            "/resource/**",
            "/swagger-resources",
            "/swagger-resources/**",
            "/swagger-ui.html",
            "/swagger-ui/**",
            "/favicon.ico"
    };

    private static final String[] ORIGINS_WHITELIST = {
            "http://127.0.0.1:8080",
    };
    	
    @Bean
    public JwtAuthenticationFilter authenticationTokenFilterBean() throws Exception {
        return new JwtAuthenticationFilter();
    }

    @Bean
    protected CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();

        configuration.setAllowedOriginPatterns(Arrays.asList("*"));
        configuration.setAllowedMethods(Arrays.asList("HEAD","POST","GET","DELETE","PUT"));
        configuration.setAllowedOrigins(Arrays.asList(ORIGINS_WHITELIST));
        configuration.setAllowedHeaders(Arrays.asList("*"));
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
	
    @Bean
    protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
		     .headers()
		     .frameOptions().sameOrigin()
             .and()
		   	 .csrf(AbstractHttpConfigurer::disable)
		   	 .authorizeHttpRequests(authorize -> authorize
		               .antMatchers(AUTH_WHITELIST).permitAll()
		               .antMatchers(HttpMethod.GET,AUTH_GET_WHITELIST).permitAll()
		               .antMatchers("/mng/**").hasRole("ROLE_ADMIN")
		               .antMatchers("/sys/api/**").hasRole("ROLE_USER_MEMBER")
		               .antMatchers("/sys/api/**").authenticated()
		        )
		   	.cors().and()
		   	.addFilterAt(usernamePasswordAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class)
		   	.addFilterAt(authenticationTokenFilterBean(), UsernamePasswordAuthenticationFilter.class)
            .formLogin()
            .loginPage("/mng/login/loginView.do")
            //.loginProcessingUrl("/mng/login/actionLogin.do")
       		.defaultSuccessUrl("/mng/main/sysMainView.do")
       		.failureUrl("/mng/login/loginView.do")
                .permitAll()
                .and()
            .logout()
                .permitAll()
                .and()
            .anonymous().disable(); // Disable anonymous user
        
        return http.build();
    }
        
    @Bean
    public UsernamePasswordAuthenticationFilter usernamePasswordAuthenticationFilter() throws Exception {
        UsernamePasswordAuthenticationFilter filter = new UsernamePasswordAuthenticationFilter(); 
        filter.setAuthenticationManager(authentication -> {
            String username = authentication.getName();
            String password = authentication.getCredentials().toString();
            // 이제 request 객체를 사용하여 필요한 정보 추출 가능
//            HttpServletRequest request = (HttpServletRequest) authentication.getDetails();
            // 실제 인증 로직을 구현해야 합니다. (db 조회하여 처리 필요)
            if (!"".equals(username) && !"".equals(password)) {
             	  return new UsernamePasswordAuthenticationToken(username, password, Arrays.asList(new SimpleGrantedAuthority("ROLE_ADMIN")));
            } else {
                throw new BadCredentialsException("Authentication failed");
            }
        });
        filter.setAuthenticationSuccessHandler((request, response, authentication) -> {
        	UsernamePasswordAuthenticationToken authToken = null;
        	//System.out.println(">>> param : " + request.getSession().getAttribute("LoginVO"));
        	if(request.getSession() !=null && request.getSession().getAttribute("LoginVO")!=null) {
        		LoginVO loginVO = (LoginVO) request.getSession().getAttribute("LoginVO");
            	authToken = new UsernamePasswordAuthenticationToken(loginVO, null, Arrays.asList(new SimpleGrantedAuthority("ROLE_ADMIN")));
        	}
        	authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        	SecurityContextHolder.getContext().setAuthentication(authToken);
        	
            // 로그인 성공 시 동작
            response.setStatus(HttpServletResponse.SC_OK);
        });
        filter.setAuthenticationFailureHandler((request, response, exception) -> {
            // 로그인 실패 시 동작
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        });
        //filter.setFilterProcessesUrl("/mng/login/actionSecurityLogin.do");
        
        return filter;
    }
    
    
/*
	@Bean
    public UserDetailsService userDetailsService() {
        return username -> {
            if ("id".equals(username)) {
                return User.withUsername("id")
                    .password("password")
                    //.roles("USER")
                    .build();
            } else {
                throw new UsernameNotFoundException("User not found with username: " + username);
            }
        };
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return NoOpPasswordEncoder.getInstance();
    }
*/    

}