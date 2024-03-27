package org.palpalmans.ollive_back.domain.member.security.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.entity.NormalMember;
import org.palpalmans.ollive_back.domain.member.model.status.MemberRole;
import org.palpalmans.ollive_back.domain.member.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.member.security.service.JwtService;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@RequiredArgsConstructor
@Component
public class JwtFilter extends OncePerRequestFilter {

    private final JwtService jwtService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        String atc= request.getHeader("Authorization");
        log.info("atc is {}", atc);

        if (!StringUtils.hasText(atc)) {
            log.info("Authorization head is blank");
            filterChain.doFilter(request, response);
            return;
        }

        if (!atc.startsWith("Bearer ")) {

            filterChain.doFilter(request, response);

            return;
        }

        log.info("atc = {} ", atc);

        String token = atc.split(" ")[1];

        log.info("token = {} ", token);

        if (jwtService.isExpired(token)) {
            log.info("access token expired");

            if(request.getHeader("Refresh") != null){

                filterChain.doFilter(request, response);
                return;
            }

            response.setStatus(HttpServletResponse.SC_EXPECTATION_FAILED);
            return;

        }

        long memberId = jwtService.getId(token);
        String memberRole = jwtService.getRole(token);

        MemberRole role = MemberRole.valueOf(memberRole);

        Member member = Member.builder()
                .id(memberId)
                .role(role)
                .build();

        log.info("member.role ={}", member.getRole().name());

        NormalMember nm = new NormalMember(member, "hack");

        CustomMemberDetails customMemberDetails = new CustomMemberDetails(nm);

        Authentication auth = new UsernamePasswordAuthenticationToken(customMemberDetails, null, customMemberDetails.getAuthorities());

        SecurityContextHolder.getContext().setAuthentication(auth);

        filterChain.doFilter(request, response);

    }
}

