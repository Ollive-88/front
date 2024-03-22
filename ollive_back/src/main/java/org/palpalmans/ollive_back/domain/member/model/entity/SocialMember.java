package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.status.SocialType;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SocialMember extends Member{
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private SocialType socialType;
}
