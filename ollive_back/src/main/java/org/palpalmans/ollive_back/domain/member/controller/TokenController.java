package org.palpalmans.ollive_back.domain.member.controller;


import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.TokenCreateRequest;
import org.palpalmans.ollive_back.domain.member.service.JwtService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class TokenController {

    private final JwtService jwtService;

    @PostMapping("/accesstoken")
    public ResponseEntity<?> accesstoken(@RequestBody TokenCreateRequest tokenCreateRequest){

        //주어진 정보로 access token 발급
        String atc = jwtService.generateAccessToken(tokenCreateRequest);

        // Authorization 헤더에 토큰 추가
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + atc);

        // 클라이언트에게 ResponseEntity 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body("access토큰 생성이 완료되었습니다");

    }

    @PostMapping("/refreshtoken")
    public ResponseEntity<?> refreshtoken(@RequestBody TokenCreateRequest tokenCreateRequest){

        //주어진 정보로 refresh token 발급
        String rtc = jwtService.generateRefreshToken(tokenCreateRequest);

        // Authorization 헤더에 토큰 추가
        HttpHeaders headers = new HttpHeaders();
        headers.set("Refresh", "Bearer " + rtc);

        // 클라이언트에게 ResponseEntity 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body("refresh토큰 생성이 완료되었습니다");

    }



}
