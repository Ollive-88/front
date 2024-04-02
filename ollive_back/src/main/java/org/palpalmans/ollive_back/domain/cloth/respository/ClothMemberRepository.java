package org.palpalmans.ollive_back.domain.cloth.respository;

import org.palpalmans.ollive_back.domain.cloth.model.entity.Cloth;
import org.palpalmans.ollive_back.domain.cloth.model.entity.ClothMember;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ClothMemberRepository extends JpaRepository<ClothMember, Long> {
    Optional<ClothMember> findByClothAndMember(Cloth cloth, Member member);

    @Query(value = "select c from ClothMember c where c.member = :member order by c.createdAt")
    List<ClothMember> findAllByMember(Member member);
}
