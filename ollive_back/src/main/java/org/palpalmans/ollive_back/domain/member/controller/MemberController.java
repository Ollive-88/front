package org.palpalmans.ollive_back.domain.member.controller;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.JoinRequest;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.status.JoinRequestStatus;
import org.palpalmans.ollive_back.domain.member.service.JoinService;
import org.palpalmans.ollive_back.domain.member.service.JwtService;
import org.palpalmans.ollive_back.domain.member.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class MemberController {

    private final JoinService joinService;
    private final MemberService memberService;
    private final JwtService jwtService;


    @PostMapping("/join") //todo : modify ResponseEntity type
    public ResponseEntity<?> join(@RequestBody JoinRequest joinRequest){


        JoinRequestStatus status = joinService.joinProcess(joinRequest);


        return switch(status){
            case JOIN_SUCCESS -> new ResponseEntity<>(HttpStatus.OK);
            case NULL_EXIST -> new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            case EMAIL_DUPLICATED -> new ResponseEntity<>(HttpStatus.CONFLICT);
        };
    }

    @GetMapping("/memberinfo") //todo : modify ResponseEntity type
    public ResponseEntity<?> getMyInfo(@RequestHeader(name = "Authorization") String accessToken){

        String atc = accessToken.split(" ")[1]; //todo : Change to Optional
        long id = jwtService.getMemberId(atc);

        //todo : Configure the appropriate Response DTO to avoid returning unnecessary information

        Member member = memberService.getMemberInfo(id); //todo : Set return values based on output results

        return ResponseEntity.ok(member);
    }

}
