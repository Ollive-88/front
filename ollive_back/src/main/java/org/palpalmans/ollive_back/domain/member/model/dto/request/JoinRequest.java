package org.palpalmans.ollive_back.domain.member.model.dto.request;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class JoinRequest {

    private String email;
    private String password;
    private String gender;
    private String birthday;
    private String name;
    private String nickname;
    private String profilepicture;
}
