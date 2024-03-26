package org.palpalmans.ollive_back.domain.member.security.details;

import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.entity.NormalMember;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@ToString
public class CustomMemberDetails implements UserDetails {

    private final NormalMember normalMember;

    public CustomMemberDetails(NormalMember normalMember){
        this.normalMember = normalMember;
    }

    //유저 권한 가져오기
    @Override
    public List<? extends GrantedAuthority> getAuthorities() {

        List<GrantedAuthority> authorityList = new ArrayList<>();

        log.debug("login user role = {}", normalMember.getRole());
        authorityList.add(new SimpleGrantedAuthority(normalMember.getRole().name()));
        return authorityList;
    }

    @Override
    public String getPassword() {
        return normalMember.getPassword();
    }

    @Override
    public String getUsername() {
        return normalMember.getName();
    }

    public long getMemberId(){ return  normalMember.getId(); }

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
