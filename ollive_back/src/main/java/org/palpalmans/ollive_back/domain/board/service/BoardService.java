package org.palpalmans.ollive_back.domain.board.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.board.model.dto.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.board.repository.BoardRepository;
import org.palpalmans.ollive_back.domain.image.service.ImageService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static org.palpalmans.ollive_back.domain.image.model.ImageType.BOARD;

@Service
@RequiredArgsConstructor
public class BoardService {
    private final ImageService imageService;
    private final TagService tagService;
    private final LikeService likeService;
    private final ViewService viewService;

    private final BoardRepository boardRepository;

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

    private Board writeBoard(String title, String content, Long memberId) {
        return boardRepository.save(new Board(title, content, memberId));
    }
}
