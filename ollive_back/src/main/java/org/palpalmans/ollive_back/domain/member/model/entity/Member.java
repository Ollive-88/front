package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.*;
import lombok.*;
import org.palpalmans.ollive_back.common.BaseTimeEntity;

import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@NoArgsConstructor(access = PROTECTED)
public class Member extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private long id;

    @Column(nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(nullable = false)
    private String gender;

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private String birthday;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, columnDefinition = "VARCHAR(255) default 'defaultUserNickname'")
    private String nickname;

    @Column(nullable = false)
    private String role;

    @Builder
    public Member(String email, String password, String gender, String birthday, String name, String nickname, String role){
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.birthday = birthday;
        this.name = name;
        this.nickname = nickname;
        this.role = role;
    }

}
