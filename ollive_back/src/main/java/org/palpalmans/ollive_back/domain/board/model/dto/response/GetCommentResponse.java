package org.palpalmans.ollive_back.domain.board.model.dto.response;

import lombok.Builder;

import java.time.LocalDateTime;

@Builder
public record GetCommentResponse(
        Long commentId,
        String content,
        Long memberId,
        String nickname,
        String memberProfile,
        LocalDateTime createdAt
) {
}
