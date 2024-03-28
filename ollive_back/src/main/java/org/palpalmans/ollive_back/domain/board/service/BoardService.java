package org.palpalmans.ollive_back.domain.board.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.board.model.dto.request.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardDetailResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardsResponse;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.board.repository.BoardQueryRepository;
import org.palpalmans.ollive_back.domain.board.repository.BoardRepository;
import org.palpalmans.ollive_back.domain.image.service.ImageService;
import org.palpalmans.ollive_back.domain.member.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.member.service.MemberService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static org.palpalmans.ollive_back.common.error.ErrorMessage.BOARD_NOT_FOUND;
import static org.palpalmans.ollive_back.domain.board.model.BoardMapper.toGetBoardDetailResponse;
import static org.palpalmans.ollive_back.domain.board.model.BoardMapper.toGetBoardResponse;
import static org.palpalmans.ollive_back.domain.image.model.ImageType.BOARD;

@Service
@RequiredArgsConstructor
public class BoardService {
    private final ImageService imageService;
    private final MemberService memberService;

    private final TagService tagService;
    private final LikeService likeService;
    private final ViewService viewService;

    private final BoardRepository boardRepository;
    private final BoardQueryRepository boardQueryRepository;

    @Transactional
    public Long writeBoard(WriteBoardRequest writeBoardRequest, Long memberId) {
        Board board = writeBoard(writeBoardRequest.title(), writeBoardRequest.content(), memberId);

        imageService.saveImage(writeBoardRequest.images(), BOARD, board.getId());
        tagService.saveTags(writeBoardRequest.tagNames());

        // TODO 로그인 구현 완료시 로그인 한 사용자에서 가져올 예정
        //		Member member = new Member();
        //		member.setId();
        //		likeService.saveLike(board, member);
        //		viewService.saveView(board, null);
        return board.getId();
    }

    @Transactional(readOnly = true)
    public GetBoardsResponse getBoards(String keyword, Long lastIndex, int size, List<String> tagNames) {
        List<Board> boards = boardQueryRepository.getBoardList(keyword, lastIndex, size, tagNames);
        List<GetBoardResponse> getBoardResponseList = new ArrayList<>();

        for (Board board : boards) {
            int viewCount = viewService.getViewCount(board);
            int likeCount = likeService.getLikeCount(board);

            getBoardResponseList.add(
                    toGetBoardResponse(
                            board, viewCount, likeCount, false, false
                    )
                    // TODO login 완료시 : Member 가져오기
            );
        }
        return new GetBoardsResponse(getBoardResponseList, boards.size() < size);
    }

    @Transactional(readOnly = true)
    public GetBoardDetailResponse getBoardDetail(Long boardId, CustomMemberDetails customMemberDetails) {
        Board board = boardRepository.findByIdWithComments(boardId)
                .orElseThrow(() -> new EntityNotFoundException(BOARD_NOT_FOUND.getMessage()));
        int viewCount = viewService.getViewCount(board);
        int likeCount = likeService.getLikeCount(board);

        //TODO imageService 구현 완료시 이미지 조회 해오기
        // imageService.getImage();
        List<String> images = new ArrayList<>();
        return toGetBoardDetailResponse(board, customMemberDetails.getMember(), viewCount, likeCount, images);
    }

    private Board writeBoard(String title, String content, Long memberId) {
        return boardRepository.save(new Board(title, content, memberId));
    }
}
