package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.palpalmans.ollive_back.common.BaseTimeEntity;
import org.palpalmans.ollive_back.domain.member.model.status.MemberRole;

import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Setter(value = PROTECTED)
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Getter
@NoArgsConstructor(access = PROTECTED)
public class Member extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String gender;

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private String birthday;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, columnDefinition = "VARCHAR(255) default 'defaultUserNickname'")
    private String nickname;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MemberRole role;

    @Column(nullable = true)
    private String profilepicture;

    @Builder
    public Member(String email, String gender, String birthday, String name,
                  String nickname, MemberRole role, String profilepicture){
        this.email = email;
        this.gender = gender;
        this.birthday = birthday;
        this.name = name;
        this.nickname = nickname;
        this.role = role;
        this.profilepicture = profilepicture;
    }

}
