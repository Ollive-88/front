package org.palpalmans.ollive_back.domain.member.security.service;

import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.dto.GeneratedToken;
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

    private final SecretKey secretKey;

    public JwtService(@Value("${spring.jwt.secret}") String secret) {


        secretKey = new SecretKeySpec(secret.getBytes(StandardCharsets.UTF_8), Jwts.SIG.HS256.key().build().getAlgorithm());
    }

    public GeneratedToken generateToken(TokenCreateRequest tokenCreateRequest){
        String accessToken = generateAccessToken(tokenCreateRequest);
        String refreshToken = generateRefreshToken(tokenCreateRequest);

        return GeneratedToken.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }


    //AccessToken 생성
    public String generateAccessToken(TokenCreateRequest tokenCreateRequest) {
        long tokenPeriod = 1000L * 60L * 10L; // 10분
//        long tokenPeriod = 1000L * 60L * 60L * 24L * 14; // 2주

        return makeToken(tokenCreateRequest, tokenPeriod);
    }

    //RefreshToken 생성
    public String generateRefreshToken(TokenCreateRequest tokenCreateRequest) {

        //        long tokenPeriod = 1000L * 60L * 10L; // 10분
        long tokenPeriod = 1000L * 60L * 60L * 24L * 14; // 2주

        return makeToken(tokenCreateRequest, tokenPeriod);
    }

    private String makeToken(TokenCreateRequest tokenCreateRequest, long tokenPeriod) {
        long id = tokenCreateRequest.getId();
        String email = tokenCreateRequest.getEmail();
        String role = tokenCreateRequest.getRole();

        return Jwts.builder()
                .claim("id", id)
                .claim("email", email) //멤버 이름
                .claim("role", role)
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + tokenPeriod))
                .signWith(secretKey)
                .compact();
    }

    public long getMemberId(String token){
       return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().get("id", Integer.class);
    }

    public Boolean isExpired(String token) {

        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload().getExpiration().before(new Date());
    }

}
