package org.palpalmans.ollive_back.domain.board.repository;

import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardRepository extends JpaRepository<Board, Long> {
}