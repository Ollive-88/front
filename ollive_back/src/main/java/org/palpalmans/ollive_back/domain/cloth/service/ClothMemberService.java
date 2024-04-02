package org.palpalmans.ollive_back.domain.cloth.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.cloth.model.entity.Cloth;
import org.palpalmans.ollive_back.domain.cloth.model.entity.ClothMember;
import org.palpalmans.ollive_back.domain.cloth.respository.ClothMemberRepository;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ClothMemberService {
    private final ClothMemberRepository clothMemberRepository;

    @Transactional
    public List<ClothMember> getSeenCloth(Member member) {
        return clothMemberRepository.findAllByMember(member);
    }

    @Transactional(readOnly = true)
    public Optional<ClothMember> findClothMember(Cloth cloth, Member member){
        return clothMemberRepository.findByClothAndMember(cloth, member);
    }

    @Transactional
    public void saveClothMember(Cloth cloth, Member member) {
        clothMemberRepository.save(new ClothMember(cloth, member));
    }
}
