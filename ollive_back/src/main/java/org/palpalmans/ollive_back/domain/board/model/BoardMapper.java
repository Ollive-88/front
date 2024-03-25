package org.palpalmans.ollive_back.domain.board.model;

import org.palpalmans.ollive_back.domain.board.model.dto.request.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardResponse;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;

public class BoardMapper {
    public static Board toBoard(WriteBoardRequest writeBoardRequest, Long memberId) {
        return new Board(
                writeBoardRequest.title(), writeBoardRequest.content(), memberId
        );
    }

    public static GetBoardResponse toGetBoardResponse(
            Board board, int views, int likes, boolean isViewed, boolean isLiked
    ) {
        return GetBoardResponse.builder()
                .title(board.getTitle())
                .content(board.getContent())
                .thumbnailAddress("thumbnailAddress") // TODO imageService 구현시 수정
                .commentCount(board.getComments().size())
                .likes(likes)
                .views(views)
                .isLiked(isLiked)
                .isViewed(isViewed)
                .createdAt(board.getCreatedAt())
                .tags(board.getBoardTags()
                        .stream()
                        .map(boardTag ->
                                boardTag.getTag()
                                        .getName())
                        .toList())
                .build();
    }
}
