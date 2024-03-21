package org.palpalmans.ollive_back.domain.member.service;

import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.dto.response.CustomOauth2User;
import org.palpalmans.ollive_back.domain.member.model.dto.response.GoogleResponse;
import org.palpalmans.ollive_back.domain.member.model.dto.response.Oauth2MemberResponse;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class CustomOauth2UserService extends DefaultOAuth2UserService {

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oAuth2User = super.loadUser(userRequest);

        log.info("oAuth2User = {}",oAuth2User);

        String registrationId = userRequest.getClientRegistration().getRegistrationId();

        GoogleResponse googleResponse = null;

        if (registrationId.equals("google")) {

            googleResponse = new GoogleResponse(oAuth2User.getAttributes());
        } else {

            return null;
        }

        //받은 멤버 정보를 객체에 담아 반환
        Oauth2MemberResponse oauth2MemberResponse = new Oauth2MemberResponse();

        //필요한 정보인 이름과 Email만 추출
        oauth2MemberResponse.setName(googleResponse.getName());
        oauth2MemberResponse.setEmail(googleResponse.getEmail());

        log.info("name = {}", googleResponse.getName());
        log.info("email = {}", googleResponse.getEmail());

        //원래는 여기서 회원가입 진행
        //but 추가 정보가 필요하기 때문에 그냥 반환해서 SuccessHandler에서 처리

        return new CustomOauth2User(oauth2MemberResponse);
    }
}
