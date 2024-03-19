package org.palpalmans.ollive_back.domain.member.model.dto.response;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class MemberInfoResponse {

    private String email;
    private String gender;
    private String birthday;
    private String name;
    private String nickname;

}
