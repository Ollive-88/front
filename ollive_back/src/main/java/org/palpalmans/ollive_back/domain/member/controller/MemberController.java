package org.palpalmans.ollive_back.domain.member.controller;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.JoinRequest;
import org.palpalmans.ollive_back.domain.member.model.dto.response.MemberInfoResponse;
import org.palpalmans.ollive_back.domain.member.model.status.JoinRequestStatus;
import org.palpalmans.ollive_back.domain.member.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.member.service.JoinService;
import org.palpalmans.ollive_back.domain.member.service.MemberService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class MemberController {

    private final JoinService joinService;
    private final MemberService memberService;


    @PostMapping("/join")
    public ResponseEntity<String> join(@RequestBody JoinRequest joinRequest){


        JoinRequestStatus status = joinService.joinProcess(joinRequest);


        return switch(status){
            case JOIN_SUCCESS -> ResponseEntity.status(HttpStatus.OK).body("회원가입이 성공적으로 완료되었습니다.");
            case NULL_EXIST -> ResponseEntity.status(HttpStatus.BAD_REQUEST).body("필수 입력 항목이 누락되었습니다.");
            case EMAIL_DUPLICATED -> ResponseEntity.status(HttpStatus.CONFLICT).body("이미 사용 중인 이메일입니다.");
            case INVALID_ROLE -> ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("유저 role이 잘못되었습니다");
        };
    }

    @GetMapping("/memberinfo")
    public ResponseEntity<MemberInfoResponse> getMyInfo(@AuthenticationPrincipal CustomMemberDetails customMemberDetails){

        long id = customMemberDetails.getId();

        MemberInfoResponse memberInfoResponse = memberService.getMemberInfo(id); //존재하지 않는 경우는 respository에서 예외처리

        return ResponseEntity.ok(memberInfoResponse);
    }

}
