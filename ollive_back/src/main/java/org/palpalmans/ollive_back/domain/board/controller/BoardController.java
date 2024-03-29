package org.palpalmans.ollive_back.domain.board.controller;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.common.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.board.model.dto.request.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardDetailResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardsResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.WriteBoardResponse;
import org.palpalmans.ollive_back.domain.board.service.BoardService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

import static org.palpalmans.ollive_back.domain.board.model.BoardMapper.toWriteBoardResponse;
import static org.springframework.http.HttpStatus.CREATED;

@RestController
@RequestMapping("/api/v1/boards")
@RequiredArgsConstructor
public class BoardController {
    private final BoardService boardService;

    @PostMapping
    public ResponseEntity<WriteBoardResponse> writeBoard(
            @Validated
            WriteBoardRequest writeBoardRequest,
            @AuthenticationPrincipal CustomMemberDetails customMemberDetails
    ) {
        Long boardId = boardService.writeBoard(
                writeBoardRequest, customMemberDetails.getMember()
        );
        return ResponseEntity.status(CREATED)
                .body(toWriteBoardResponse(boardId));
    }

    @GetMapping
    public ResponseEntity<GetBoardsResponse> getBoards(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false, defaultValue = "0") Long lastIndex,
            @RequestParam(required = false, defaultValue = "10") int size,
            @RequestParam(required = false) List<String> tags
    ) {
        if (keyword != null && keyword.isBlank())
            throw new IllegalArgumentException("keyword는 공백일 수 없습니다!");
        if (tags == null)
            tags = Collections.emptyList();
        return ResponseEntity.ok(boardService.getBoards(keyword, lastIndex, size, tags));
    }

    @GetMapping("/{boardId}")
    public ResponseEntity<GetBoardDetailResponse> getBoardDetail(
            @PathVariable(value = "boardId") Long boardId,
            @AuthenticationPrincipal CustomMemberDetails customMemberDetails
    ) {
        return ResponseEntity.ok(boardService.getBoardDetail(boardId, customMemberDetails));
    }
}
