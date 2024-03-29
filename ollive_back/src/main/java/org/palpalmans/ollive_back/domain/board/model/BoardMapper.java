package org.palpalmans.ollive_back.domain.board.model;

import org.palpalmans.ollive_back.domain.board.model.dto.request.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardDetailResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetCommentResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.Writer;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;

import java.util.Comparator;
import java.util.List;

public class BoardMapper {
    public static Board toBoard(WriteBoardRequest writeBoardRequest, Long memberId) {
        return new Board(
                writeBoardRequest.title(), writeBoardRequest.content(), memberId
        );
    }

    public static GetBoardResponse toGetBoardResponse(
            Board board, int views, int likes
    ) {
        return GetBoardResponse.builder()
                .boardId(board.getId())
                .title(board.getTitle())
                .content(board.getContent())
                .thumbnailAddress("thumbnailAddress") // TODO imageService 구현시 수정
                .commentCount(board.getComments().size())
                .likes(likes)
                .views(views)
                .createdAt(board.getCreatedAt())
                .tags(board.getBoardTags()
                        .stream()
                        .map(boardTag ->
                                boardTag.getTag()
                                        .getName())
                        .toList())
                .build();
    }

    public static GetBoardDetailResponse toGetBoardDetailResponse(
            Board board, Member member,
            int viewCount, int likeCount,
            List<String> images, List<String> tags
    ) {
        return GetBoardDetailResponse.builder()
                .boardId(board.getId())
                .title(board.getTitle())
                .content(board.getContent())
                .writer(new Writer(member.getNickname(), member.getProfilePicture()))
                .isMine(board.getMemberId() == member.getId())
                .createdAt(board.getCreatedAt())
                .viewCount(viewCount)
                .likeCount(likeCount)
                .images(images)
                .tags(tags)
                .comments(board.getComments()
                        .stream()
                        .map(CommentMapper::toGetCommentResponse)
                        .sorted(Comparator.comparing(GetCommentResponse::createdAt).reversed())
                        .toList()
                ).build();
    }
}
