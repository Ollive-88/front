package org.palpalmans.ollive_back.domain.member.controller;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.JoinRequest;
import org.palpalmans.ollive_back.domain.member.model.status.JoinRequestStatus;
import org.palpalmans.ollive_back.domain.member.service.JoinService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class MemberController {

    private final JoinService joinService;


    @PostMapping("/join")
    public ResponseEntity<?> join(@RequestBody JoinRequest joinRequest){


        JoinRequestStatus status = joinService.joinProcess(joinRequest);


        return switch(status){
            case JOIN_SUCCESS -> new ResponseEntity<>(HttpStatus.OK);
            case NULL_EXIST -> new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            case EMAIL_DUPLICATED -> new ResponseEntity<>(HttpStatus.CONFLICT);
        };
    }

}
