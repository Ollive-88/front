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

        this.setEmail(email);
        this.setGender(gender);
        this.setBirthday(birthday);
        this.setName(name);
        this.setNickname(nickname);
        this.setRole(role);
        this.setProfilepicture(profilepicture);
        this.password = password;
    }

}
