package org.palpalmans.ollive_back.domain.member.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    @Temporal(TemporalType.TIMESTAMP)
    private String createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    private String updatedAt;
}
