package org.palpalmans.ollive_back.domain.member.controller;


import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.member.model.dto.request.AccessCreateRequest;
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
    public ResponseEntity<?> accesstoken(@RequestBody AccessCreateRequest accessCreateRequest){


        String atc = jwtService.generateAccessToken(accessCreateRequest);

        // Authorization 헤더에 토큰 추가
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + atc);

        // 클라이언트에게 ResponseEntity 반환
        return ResponseEntity.ok()
                .headers(headers)
                .body("토큰생성이 완료되었습니다");

    }

}
