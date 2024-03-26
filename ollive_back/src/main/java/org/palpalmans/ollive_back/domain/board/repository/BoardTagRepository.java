package org.palpalmans.ollive_back.domain.board.repository;

import org.palpalmans.ollive_back.domain.board.model.entity.BoardTag;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BoardTagRepository extends JpaRepository<BoardTag, Long> {
}
