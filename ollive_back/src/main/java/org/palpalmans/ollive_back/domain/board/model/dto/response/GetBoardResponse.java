package org.palpalmans.ollive_back.domain.board.model.dto.response;

import lombok.Builder;

import java.time.LocalDateTime;
import java.util.List;

@Builder
public record GetBoardResponse(
        String title,
        String content,
        String thumbnailAddress,
        int commentCount,
        int likes,
        int views,
        boolean isLiked,
        boolean isViewed,
        List<String> tags,
        LocalDateTime createdAt
) {
}
