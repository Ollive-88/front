package org.palpalmans.ollive_back.domain.board.model.dto.response;

import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;

@Builder
public record GetBoardDetailResponse(
        String title,
        String content,
        LocalDateTime createdAt,
        int viewCount,
        int likeCount,
        List<String> images,
        List<GetCommentResponse> comments
) {
}
