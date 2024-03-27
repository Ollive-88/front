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
        Date birthday = joinRequest.getBirthday();
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

        //todo : Boolean 값보다, 존재하는 멤버 정보를 가져와야겠다.

        Boolean isExist = memberRepository.existsByEmail(email);
        //todo : 검색된 멤버가 ROLE_NON_REGISTERED_MEMBER 이고, 가입한지 2일이 지났으면 삭제하고 회원가입 진행
        if(isExist) return JoinRequestStatus.EMAIL_DUPLICATED;


        if(role == MemberRole.ROLE_NON_REGISTERED_MEMBER){
            //ROLE_NON_REGISTERD_MEMBER 면 SocialMember Entity 이용해서 회원가입
            Member member = Member.builder()
                    .email(email)
                    .gender("undefined")
                    .birthday(birthday)
                    .name(name)
                    .nickname(nickname)
                    .role(role) // role 설정
                    .profilepicture("picture")
                    .build();

            SocialMember joinMember = new SocialMember(member, SocialType.GOOGLE);

            // todo : memberRepository에 알맞은 save 확인하기
            memberRepository.save(joinMember);


        }else if(role == MemberRole.ROLE_REGISTERED_MEMBER){
            //ROLE_REGISTERED_MEMBER 면 NormalMember Entity 이용해서 회원가입
            Member member = Member.builder()
                    .email(email)
                    .gender(gender)
                    .birthday(birthday)
                    .name(name)
                    .nickname(nickname)
                    .role(role) // role 설정
                    .profilepicture("picture")
                    .build();

            String encodedPass = bCryptPasswordEncoder.encode(password);

            NormalMember joinMember = new NormalMember(member, encodedPass);

            //멤버 가입시키기
            memberRepository.save(joinMember);

        }else if(role == MemberRole.ROLE_ADMIN){
            // ROLE_ADMIN 이면 Normal Entity 이용해서 회원가입
            // Builder 패턴 사용하여 객체 생성
            Member member = Member.builder()
                    .email(email)
                    .gender(gender)
                    .birthday(birthday)
                    .name(name)
                    .nickname(nickname)
                    .role(role) // role 설정
                    .profilepicture("picture")
                    .build();

            String encodedPass = bCryptPasswordEncoder.encode(password);

            NormalMember admin = new NormalMember(member, encodedPass);
            //멤버 가입시키기
            memberRepository.save(admin);
        }





        //모든 과정이 끝나면 성공 반환
        return JoinRequestStatus.JOIN_SUCCESS;

    }

}
