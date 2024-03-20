package org.palpalmans.ollive_back.domain.member.model.dto;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.response.Oauth2MemberResponse;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.Map;

@RequiredArgsConstructor
public class CustomOauth2Member implements OAuth2User {

    private final Oauth2MemberResponse oauth2MemberResponse;


    @Override
    public Map<String, Object> getAttributes() {
        return null;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getName() {
        return oauth2MemberResponse.getName();
    }

    public String getEmail(){
        return oauth2MemberResponse.getEmail();
    }
}
