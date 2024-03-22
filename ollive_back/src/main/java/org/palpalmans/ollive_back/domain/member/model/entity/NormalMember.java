package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.status.MemberRole;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class NormalMember extends Member{

    @Column(nullable = false)
    private String password;

    @Builder
    public NormalMember(String email, String password, String gender, String birthday,
                        String name, String nickname, MemberRole role, String profilepicture) {
        super(email, gender, birthday, name, nickname, role, profilepicture);
        this.password = password;
    }

}
