package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.status.MemberRole;
import org.palpalmans.ollive_back.domain.member.model.status.SocialType;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SocialMember extends Member{
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private SocialType socialType;

    @Builder
    public SocialMember(String email, SocialType socialType, String gender, String birthday,
                        String name, String nickname, MemberRole role, String profilepicture) {
        this.setEmail(email);
        this.setGender(gender);
        this.setBirthday(birthday);
        this.setName(name);
        this.setNickname(nickname);
        this.setRole(role);
        this.setProfilepicture(profilepicture);
        this.socialType = socialType;
    }
}
