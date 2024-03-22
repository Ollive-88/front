package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class NormalMember extends Member{
    @Column(nullable = false)
    private String password;
}
