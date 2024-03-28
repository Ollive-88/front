package org.palpalmans.ollive_back.domain.member.model.dto.request;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@ToString
@Getter
@Setter
public class JoinRequest {

    private String email;
    private String password;
    private String name;
    private Date birthday;
    private String gender;
    private String role;
}
