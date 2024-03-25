package org.palpalmans.ollive_back.domain.member.security.Handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.dto.request.TokenCreateRequest;
import org.palpalmans.ollive_back.domain.member.model.dto.response.CustomOauth2User;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.security.service.JwtService;
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
                tokenCreateRequest.setEmail(isExist.get().getEmail());
                tokenCreateRequest.setRole(role);

                String accessToken = jwtService.generateAccessToken(tokenCreateRequest);

                response.addHeader("Authorization", "Bearer " + accessToken);

            }
        }



        super.onAuthenticationSuccess(request, response, authentication);
    }


}
