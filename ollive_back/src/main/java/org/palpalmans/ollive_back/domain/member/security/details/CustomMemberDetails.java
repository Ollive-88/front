package org.palpalmans.ollive_back.domain.member.security.details;

import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@ToString
public class CustomMemberDetails implements UserDetails {

    private final Member member;

    public CustomMemberDetails(Member member){
        this.member = member;
    }

    //유저 권한 가져오기
    @Override
    public List<? extends GrantedAuthority> getAuthorities() {

        List<GrantedAuthority> authorityList = new ArrayList<>();

        log.debug("login user role = {}", member.getRole());
        authorityList.add(new SimpleGrantedAuthority(member.getRole().name()));
        return authorityList;
    }

    //todo : normal member 일때만 password 가져오기로 고치기
    @Override
    public String getPassword() {
        return member.getName();
    }

    @Override
    public String getUsername() {
        return member.getName();
    }

    public long getMemberId(){ return  member.getId(); }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
