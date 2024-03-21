package org.palpalmans.ollive_back.domain.member.model.Handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.dto.response.CustomOauth2User;
import org.palpalmans.ollive_back.domain.member.service.JwtService;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@RequiredArgsConstructor
@Slf4j
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final JwtService jwtService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        CustomOauth2User customOauth2User = (CustomOauth2User) authentication.getPrincipal();

        log.info("received information = {}", customOauth2User);

        super.onAuthenticationSuccess(request, response, authentication);
    }

    //todo : 디비에서 유저 장보 확인

    //todo : 유저 정보가 없다면 회원가입 진행

    //todo : 유저 정보가 있다면 토큰 발급
}
