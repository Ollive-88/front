package org.palpalmans.ollive_back.domain.member.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.JoinRequest;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.status.JoinRequestStatus;
import org.palpalmans.ollive_back.domain.member.repository.MemberRepository;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
@RequiredArgsConstructor
public class JoinService {

    private final MemberRepository memberRepository;

    public JoinRequestStatus joinProcess(JoinRequest joinRequest){

        String email = joinRequest.getEmail();
        String password = joinRequest.getPassword();
        int gender = joinRequest.getGender();
        String birthday = joinRequest.getBirthday();
        String name = joinRequest.getName();
        String nickname = joinRequest.getNickname();

        if(email == null || password == null || birthday == null || name == null){
            return JoinRequestStatus.NULL_EXIST;
        }

        //이미 존재하는 회원인지 체크
        Boolean isExist = memberRepository.existsByEmail(email);

        if(isExist) return JoinRequestStatus.EMAIL_DUPLICATED;

        Member joinMember = new Member();

        joinMember.setEmail(email);
        joinMember.setPassword(password); //todo : 패스워드 암호화
        joinMember.setGender(gender);
        joinMember.setBirthday(birthday);
        joinMember.setName(name);
        joinMember.setNickname(nickname);

        //가입 날짜 세팅
        joinMember.setCreatedAt(new Date().toString());

        //멤버 가입시키기
        memberRepository.save(joinMember);
        //모든 과정이 끝나면 성공 반환
        return JoinRequestStatus.JOIN_SUCCESS;

    }

}
