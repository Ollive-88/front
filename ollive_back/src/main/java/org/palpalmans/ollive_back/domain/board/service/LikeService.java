package org.palpalmans.ollive_back.domain.board.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.board.model.entity.Like;
import org.palpalmans.ollive_back.domain.board.repository.LikeRepository;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class LikeService {
    private final LikeRepository likeRepository;

    @Transactional
    public void saveLike(Board board, Member member) {
        likeRepository.save(new Like(board, member));
    }

    @Transactional(readOnly = true)
    public int getLikeCount(Board board) {
        return likeRepository.countLikesByBoard(board);
    }

   @Transactional(readOnly = true)
    public boolean isLikedMember(Board board, Member member) {
        return likeRepository.existsLikeByBoardAndMember(board, member);
    }
}
