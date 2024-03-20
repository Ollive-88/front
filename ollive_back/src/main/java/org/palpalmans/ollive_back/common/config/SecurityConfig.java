package org.palpalmans.ollive_back.common.config;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.service.CustomOauth2UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import java.util.ArrayList;
import java.util.List;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final CustomOauth2UserService customOAuth2Service;
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {

        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{

        List<String> exposedHeaders = new ArrayList<>();
        exposedHeaders.add("Authorization");
        exposedHeaders.add("Refresh");


        http
                .httpBasic(AbstractHttpConfigurer::disable);

        //csrf disable
        http
                .csrf(AbstractHttpConfigurer::disable);

        //세션 stateless 상태로 설정
        http
                //세션이 있어도 사용하지 않고, 없어도 만들지 않음
                .sessionManagement((session) -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        //oauth2
        http
                .oauth2Login((oauth2) -> oauth2
                        .userInfoEndpoint((userInfoEndpointConfig) -> userInfoEndpointConfig
                                .userService(customOAuth2Service)));

        //인가작업
        http
                .authorizeHttpRequests((auth) -> auth
                        // 모든 경로("/", "/login", "/join", "/member/**", "/swagger-ui/**", "/v3/api-docs/**", "/oauth2/**")에 대한 접근 허용
                        .requestMatchers("/**","/login/**","/login","/","/join", "/member/**", "/swagger-ui/**", "/v3/api-docs/**","/oauth2/**").permitAll()
                        // "/admin" 경로에 대한 접근은 "ADMIN" 역할을 가진 사용자만 허용
                        .requestMatchers("/admin").hasRole("ADMIN")
                        // 그 외의 모든 요청은 인증된 사용자에게만 허용
                        .requestMatchers("/tokentest").hasRole("REGISTERED_MEMBER")
                        .anyRequest().authenticated());

        return http.build();

    }

//    AuthenticationManager Bean 등록
//    @Bean
//    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
//        return configuration.getAuthenticationManager();
//    }

}
