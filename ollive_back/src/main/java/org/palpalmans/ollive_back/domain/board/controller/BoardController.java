package org.palpalmans.ollive_back.domain.board.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.board.model.dto.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.service.BoardService;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static java.net.URI.create;

@RestController
@RequestMapping("/api/v1/boards")
@RequiredArgsConstructor
public class BoardController {
    private final BoardService boardService;

    @PostMapping
    public ResponseEntity<?> writeBoard(
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
}
