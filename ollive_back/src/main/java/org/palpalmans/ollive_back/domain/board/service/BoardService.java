package org.palpalmans.ollive_back.domain.board.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.common.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.board.model.dto.request.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardDetailResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardResponse;
import org.palpalmans.ollive_back.domain.board.model.dto.response.GetBoardsResponse;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.board.model.entity.BoardTag;
import org.palpalmans.ollive_back.domain.board.model.entity.Tag;
import org.palpalmans.ollive_back.domain.board.repository.BoardQueryRepository;
import org.palpalmans.ollive_back.domain.board.repository.BoardRepository;
import org.palpalmans.ollive_back.domain.board.repository.BoardTagRepository;
import org.palpalmans.ollive_back.domain.image.service.ImageService;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
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
    private final BoardTagRepository boardTagRepository;

    @Transactional
    public Long writeBoard(WriteBoardRequest writeBoardRequest, Member member) {
        Board board = writeBoard(
                writeBoardRequest.getTitle(), writeBoardRequest.getContent(), member
        );

        List<Tag> savedTag = new ArrayList<>();

        imageService.saveImage(writeBoardRequest.getImages(), BOARD, board.getId());
        tagService.saveTags(writeBoardRequest.getTagNames(), savedTag);
        viewService.saveView(board, member);
        boardTagRepository.saveAll(savedTag.stream().map(tag -> new BoardTag(board, tag)).toList());

        return board.getId();
    }

    @Transactional(readOnly = true)
    public GetBoardsResponse getBoards(
            String keyword, Long lastIndex, int size, List<String> tagNames
    ) {
        List<Board> boards = boardQueryRepository.getBoardList(keyword, lastIndex, size, tagNames);
        List<GetBoardResponse> getBoardResponseList = new ArrayList<>();

        for (Board board : boards) {
            int viewCount = viewService.getViewCount(board);
            int likeCount = likeService.getLikeCount(board);

            getBoardResponseList.add(
                    toGetBoardResponse(board, viewCount, likeCount)
            );
            // TODO imageService.select()
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

        List<String> tags = board.getBoardTags()
                .stream()
                .map(boardTag -> boardTag.getTag().getName())
                .toList();

        return toGetBoardDetailResponse(
                board, customMemberDetails.getMember(),
                viewCount, likeCount,
                images, tags
        );
    }

    private Board writeBoard(String title, String content, Member member) {
        return boardRepository.save(new Board(title, content, member.getId()));
    }
}
