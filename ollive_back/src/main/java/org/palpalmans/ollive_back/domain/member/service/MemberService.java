package org.palpalmans.ollive_back.domain.member.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.repository.MemberRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    public Member getmMemberinfo(long id){
        Member member = memberRepository.getMemberById(id);

        return member;
    }

}
