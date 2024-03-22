package org.palpalmans.ollive_back.domain.member.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.JoinRequest;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.entity.NormalMember;
import org.palpalmans.ollive_back.domain.member.model.entity.SocialMember;
import org.palpalmans.ollive_back.domain.member.model.status.JoinRequestStatus;
import org.palpalmans.ollive_back.domain.member.model.status.MemberRole;
import org.palpalmans.ollive_back.domain.member.model.status.SocialType;
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
        MemberRole role;
        try {
            role = MemberRole.valueOf(joinRequest.getRole().toUpperCase());
        } catch (IllegalArgumentException e) {
            // role 문자열이 MemberRole에 없는 경우 예외 처리
            return JoinRequestStatus.INVALID_ROLE;
        }

        if(email == null || birthday == null || name == null){
            return JoinRequestStatus.NULL_EXIST;
        }

        //이미 존재하는 회원인지 체크
        Boolean isExist = memberRepository.existsByEmail(email);

        if(isExist) return JoinRequestStatus.EMAIL_DUPLICATED;


        if(role == MemberRole.ROLE_NON_REGISTERED_MEMBER){
            //ROLE_NON_REGISTERD_MEMBER 면 SocialMember Entity 이용해서 회원가입
            SocialMember socialMember = SocialMember.builder()
                    .email(email)
                    .gender(gender)
                    .birthday(birthday)
                    .name(name)
                    .nickname(nickname)
                    .role(role) // role 설정
                    .socialType(SocialType.GOOGLE)
                    .profilepicture("picture")
                    .build();

            // todo : memberRepository에 알맞은 save 확인하기


        }else if(role == MemberRole.ROLE_REGISTERED_MEMBER){
            //ROLE_REGISTERED_MEMBER 면 NormalMember Entity 이용해서 회원가입
            NormalMember normalMember = NormalMember.builder()
                    .email(email)
                    .password(bCryptPasswordEncoder.encode(password)) // 비밀번호는 인코딩하여 저장
                    .gender(gender)
                    .birthday(birthday)
                    .name(name)
                    .nickname(nickname)
                    .role(role) // role 설정
                    .profilepicture("picture")
                    .build();

            //멤버 가입시키기
            memberRepository.save(normalMember);

        }else if(role == MemberRole.ROLE_ADMIN){
            // ROLE_ADMIN 이면 Normal Entity 이용해서 회원가입
            // Builder 패턴 사용하여 객체 생성
            NormalMember admin = NormalMember.builder()
                    .email(email)
                    .password(bCryptPasswordEncoder.encode(password)) // 비밀번호는 인코딩하여 저장
                    .gender(gender)
                    .birthday(birthday)
                    .name(name)
                    .nickname(nickname)
                    .role(role) // role 설정
                    .profilepicture("picture")
                    .build();

            //멤버 가입시키기
            memberRepository.save(admin);
        }





        //모든 과정이 끝나면 성공 반환
        return JoinRequestStatus.JOIN_SUCCESS;

    }

}
