package org.palpalmans.ollive_back.domain.member.service;

import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.dto.CustomOauth2Member;
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

        //받은 멤버 정보 저장
        Oauth2MemberResponse oauth2MemberResponse = new Oauth2MemberResponse();

        oauth2MemberResponse.setName(googleResponse.getName());
        oauth2MemberResponse.setEmail(googleResponse.getEmail());

        log.info("name = {}", googleResponse.getName());
        log.info("email = {}", googleResponse.getEmail());

        return new CustomOauth2Member(oauth2MemberResponse);
    }
}
