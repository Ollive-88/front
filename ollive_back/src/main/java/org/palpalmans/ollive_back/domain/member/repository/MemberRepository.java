package org.palpalmans.ollive_back.domain.member.repository;

import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MemberRepository extends JpaRepository<Member, Long> { // JPA 레포지토리 상속받고, 엔티티와 id의 레퍼런스 타입 입력받기

    Boolean existsByEmail(String email);


}