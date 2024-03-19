package org.palpalmans.ollive_back.domain.member.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.repository.MemberRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    public Member getMemberInfo(long id){

        //todo : Configure the appropriate Response DTO to avoid returning unnecessary information
        Member member = memberRepository.getMemberById(id);

        return member;
    }

}
