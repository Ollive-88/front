package org.palpalmans.ollive_back.domain.member.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.JoinRequest;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.status.JoinRequestStatus;
import org.palpalmans.ollive_back.domain.member.repository.MemberRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
@RequiredArgsConstructor
public class JoinService {

    private final MemberRepository memberRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public JoinRequestStatus joinProcess(JoinRequest joinRequest){

        String email = joinRequest.getEmail();
        String password = joinRequest.getPassword();
        String gender = joinRequest.getGender();
        String birthday = joinRequest.getBirthday();
        String name = joinRequest.getName();
        String nickname = joinRequest.getNickname();

        if(email == null || password == null || birthday == null || name == null){
            return JoinRequestStatus.NULL_EXIST;
        }

        //이미 존재하는 회원인지 체크
        Boolean isExist = memberRepository.existsByEmail(email);

        if(isExist) return JoinRequestStatus.EMAIL_DUPLICATED;

        // Builder 패턴 사용하여 객체 생성
        Member joinMember = Member.builder()
                .email(email)
                .password(bCryptPasswordEncoder.encode(password)) // 비밀번호는 인코딩하여 저장
                .gender(gender)
                .birthday(birthday)
                .name(name)
                .nickname(nickname)
                .role("ROLE_REGISTERED_MEMBER") // role 설정
                .profilepicture("picture")
                .build();

        //멤버 가입시키기
        memberRepository.save(joinMember);
        //모든 과정이 끝나면 성공 반환
        return JoinRequestStatus.JOIN_SUCCESS;

    }

}
