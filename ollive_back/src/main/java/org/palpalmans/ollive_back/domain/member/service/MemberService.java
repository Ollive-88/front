package org.palpalmans.ollive_back.domain.member.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.response.MemberInfoResponse;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.repository.MemberRepository;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MemberService {

    private final MemberRepository memberRepository;

    public MemberInfoResponse getMemberInfo(long id){

        Member member = memberRepository.getMemberById(id)
                .orElseThrow(() -> new NoSuchElementException("해당 ID를 가진 멤버가 존재하지 않습니다: " + id));

        MemberInfoResponse memberInfoResponse = new MemberInfoResponse();

        memberInfoResponse.setNickname(member.getNickname());
        memberInfoResponse.setName(member.getName());
        memberInfoResponse.setGender(member.getGender());
        memberInfoResponse.setEmail(member.getEmail());
        memberInfoResponse.setBirthday(member.getBirthday());

        return memberInfoResponse;
    }

    public Optional<Member> getMemberInfo(String email){

        return memberRepository.getMemberByEmail(email);
    }



}
