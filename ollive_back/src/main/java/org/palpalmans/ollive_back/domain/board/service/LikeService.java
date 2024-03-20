package org.palpalmans.ollive_back.domain.board.service;

import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.board.model.entity.Like;
import org.palpalmans.ollive_back.domain.board.repository.LikeRepository;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LikeService {
	private final LikeRepository likeRepository;

	@Transactional
	public void saveLike(Board board, Member memeber) {
		likeRepository.save(new Like(board, memeber));
	}
}
