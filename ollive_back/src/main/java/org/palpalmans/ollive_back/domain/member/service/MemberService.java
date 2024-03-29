package org.palpalmans.ollive_back.domain.member.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.response.MemberInfoResponse;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.entity.NormalMember;
import org.palpalmans.ollive_back.domain.member.model.entity.SocialMember;
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

    //이메일로 정보 불러오기
    public Optional<Member> getMemberInfo(String email){

        return memberRepository.getMemberByEmail(email);
    }

    //이메일로 패스워드 포함 멤버 불러오기
    public Optional<NormalMember> getNormalMemberByEmail(String email){
        return  memberRepository.getNormalMemberByEmail(email);
    }

    public Optional<NormalMember> getNormalMemberById(long id){
        return memberRepository.getNormalMemberById(id);
    }

    public Optional<SocialMember> getSocialMemberByEmail(String email){
        return  memberRepository.getSocialMemberByEmail(email);
    }

    public Boolean modifyPassword(long id, String password){

        Optional<NormalMember> nm = memberRepository.getNormalMemberById(id);

        if(nm.isPresent()){
           nm.get().setPassword(password);
           memberRepository.save(nm.get());
           return true;
        }
        return false;
    }

    public Boolean modifyGender(long id, String gender){

        Optional<Member> member = memberRepository.getMemberById(id);

        if(member.isPresent()){
            Member now = member.get();

            Member update = Member.builder()
                    .id(now.getId())
                    .email(now.getEmail())
                    .gender(gender)
                    .birthday(now.getBirthday())
                    .name(now.getName())
                    .nickname(now.getNickname())
                    .role(now.getRole())
                    .profilePicture(now.getProfilePicture())
                    .build();
            memberRepository.save(update);
            return true;
        }
        return false;
    }

    public Boolean modifyProfilePicture(long id, String profilePicture){

        Optional<Member> member = memberRepository.getMemberById(id);

        if(member.isPresent()){
            Member now = member.get();

            Member update = Member.builder()
                    .id(now.getId())
                    .email(now.getEmail())
                    .gender(now.getGender())
                    .birthday(now.getBirthday())
                    .name(now.getName())
                    .nickname(now.getNickname())
                    .role(now.getRole())
                    .profilePicture(profilePicture)
                    .build();
            memberRepository.save(update);
            return true;
        }
        return false;
    }

    public Boolean modifyNickname(long id, String nickname){

        Optional<Member> member = memberRepository.getMemberById(id);

        if(member.isPresent()){
            Member now = member.get();

            Member update = Member.builder()
                    .id(now.getId())
                    .email(now.getEmail())
                    .gender(now.getGender())
                    .birthday(now.getBirthday())
                    .name(now.getName())
                    .nickname(nickname)
                    .role(now.getRole())
                    .profilePicture(now.getProfilePicture())
                    .build();
            memberRepository.save(update);
            return true;
        }
        return false;
    }

}
