package org.palpalmans.ollive_back.domain.board.model;

import org.palpalmans.ollive_back.domain.board.model.dto.response.GetCommentResponse;
import org.palpalmans.ollive_back.domain.board.model.entity.Comment;

public class CommentMapper {
    public static GetCommentResponse toGetCommentResponse(
            Comment comment
    ) {
        return GetCommentResponse.builder()
                .commentId(comment.getId())
                .content(comment.getContent())
                .memberId(comment.getMember().getId())
                .nickname(comment.getMember().getNickname())
                .memberProfile(comment.getMember().getProfilePicture())
                .createdAt(comment.getCreatedAt())
                .build();
    }
}
