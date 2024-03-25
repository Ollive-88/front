package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.*;
import org.palpalmans.ollive_back.domain.member.model.status.MemberRole;

@Entity
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class NormalMember extends Member{

    @Column(nullable = false)
    private String password;

}
