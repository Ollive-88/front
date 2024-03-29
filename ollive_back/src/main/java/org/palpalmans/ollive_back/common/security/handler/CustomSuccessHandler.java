package org.palpalmans.ollive_back.common.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.common.security.service.JwtService;
import org.palpalmans.ollive_back.domain.member.model.dto.GeneratedToken;
import org.palpalmans.ollive_back.domain.member.model.dto.request.TokenCreateRequest;
import org.palpalmans.ollive_back.domain.member.model.dto.response.CustomOauth2User;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.service.MemberService;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Optional;

@Component
@RequiredArgsConstructor
@Slf4j
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final JwtService jwtService;
    private final MemberService memberService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        CustomOauth2User customOauth2User = (CustomOauth2User) authentication.getPrincipal();

        log.info("received information = {}", customOauth2User);
        Optional<Member> isExist = memberService.getMemberInfo(customOauth2User.getEmail());

        if(isExist.isPresent()){
            // 유저 권한이 REGISTERD_MEMBER일 경우에만 동작
            String role = isExist.get().getRole().name();

            if(role.equals("ROLE_REGISTERED_MEMBER")){

                TokenCreateRequest tokenCreateRequest = new TokenCreateRequest();

                tokenCreateRequest.setId(isExist.get().getId());
                tokenCreateRequest.setRole(role);

                GeneratedToken generatedToken = jwtService.generateToken(tokenCreateRequest);
                String accessToken = generatedToken.getAccessToken();
                String refreshToken = generatedToken.getRefreshToken();


                response.addHeader("Authorization", "Bearer " + accessToken);
                response.addCookie(createCookie("Refresh", refreshToken));

            }
        }



        super.onAuthenticationSuccess(request, response, authentication);
    }
    private Cookie createCookie(String key, String value) {

        Cookie cookie = new Cookie(key, value);
        cookie.setMaxAge(60*60*60);
        //cookie.setSecure(true);
        cookie.setPath("/");
        cookie.setHttpOnly(true);

        return cookie;
    }

}
