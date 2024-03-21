package org.palpalmans.ollive_back.domain.member.model.Handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.dto.request.JoinRequest;
import org.palpalmans.ollive_back.domain.member.model.dto.request.TokenCreateRequest;
import org.palpalmans.ollive_back.domain.member.model.dto.response.CustomOauth2User;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.service.JoinService;
import org.palpalmans.ollive_back.domain.member.service.JwtService;
import org.palpalmans.ollive_back.domain.member.service.MemberService;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
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
            // 유저 권한이 NON_REGISTERD_MEMBER면 아무것도 안함
            if(isExist.get().getRole().equals("ROLE_REGISTERED_MEMBER")){

                TokenCreateRequest tokenCreateRequest = new TokenCreateRequest();

                tokenCreateRequest.setId(isExist.get().getId());
                tokenCreateRequest.setEmail(isExist.get().getEmail());
                tokenCreateRequest.setRole(isExist.get().getRole());

                String accessToken = jwtService.generateAccessToken(tokenCreateRequest);

                response.addHeader("Authorization", "Bearer " + accessToken);

            }
        }



        super.onAuthenticationSuccess(request, response, authentication);
    }


}
