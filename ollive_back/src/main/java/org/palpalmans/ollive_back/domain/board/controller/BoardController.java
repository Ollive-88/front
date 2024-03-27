package org.palpalmans.ollive_back.domain.board.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.board.model.dto.request.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardsResponse;
import org.palpalmans.ollive_back.domain.board.service.BoardService;
import org.palpalmans.ollive_back.domain.member.security.details.CustomMemberDetails;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

import static java.net.URI.create;

@RestController
@RequestMapping("/api/v1/boards")
@RequiredArgsConstructor
public class BoardController {
    private final BoardService boardService;

    @PostMapping
    public ResponseEntity<Void> writeBoard(
            HttpServletRequest httpServletRequest,
            @Validated
            WriteBoardRequest writeBoardRequest
    ) {
        //TODO 로그인 완료시 member 조회 하기
        Long boardId = boardService.writeBoard(writeBoardRequest, 1L);
        return ResponseEntity.created(
                create(httpServletRequest.getRequestURI()).resolve(String.valueOf(boardId))
        ).build();
    }

    @GetMapping
    public ResponseEntity<GetBoardsResponse> getBoards(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false, defaultValue = "0") Long lastIndex,
            @RequestParam(required = false, defaultValue = "10") int size,
            @RequestParam(required = false) List<String> tags,
            @AuthenticationPrincipal CustomMemberDetails customMemberDetails
    ) {
        System.out.println("customMemberDetails = " + customMemberDetails);

        if (keyword != null && keyword.isBlank())
            throw new IllegalArgumentException("keyword는 공백일 수 없습니다!");
        if (tags == null)
            tags = Collections.emptyList();
        return ResponseEntity.ok(boardService.getBoards(keyword, lastIndex, size, tags));
    }
}
