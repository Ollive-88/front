package org.palpalmans.ollive_back.domain.member.service;

import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.dto.request.TokenCreateRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Date;

@Service
@Slf4j
public class JwtService {

    private SecretKey secretKey;

    public JwtService(@Value("${spring.jwt.secret}") String secret) {


        secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
    }

    //AccessToken 생성
    public String generateAccessToken(TokenCreateRequest tokenCreateRequest) {

        long id = tokenCreateRequest.getId();
        String email = tokenCreateRequest.getEmail();

        long tokenPeriod = 1000L * 60L * 10L; // 10분
//        long tokenPeriod = 1000L * 60L * 60L * 24L * 14; // 2주
        return Jwts.builder()
                .claim("id", id)
                .claim("email", email) //멤버 이름
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + tokenPeriod))
                .signWith(secretKey)
                .compact();
    }

    //RefreshToken 생성
    public String generateRefreshToken(TokenCreateRequest tokenCreateRequest) {

        long id = tokenCreateRequest.getId();
        String email = tokenCreateRequest.getEmail();

//        long tokenPeriod = 1000L * 60L * 10L; // 10분
        long tokenPeriod = 1000L * 60L * 60L * 24L * 14; // 2주
        return Jwts.builder()
                .claim("id", id)
                .claim("email", email) //멤버 이름
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + tokenPeriod))
                .signWith(secretKey)
                .compact();
    }

}
