package org.palpalmans.ollive_back.domain.board.repository;

import org.palpalmans.ollive_back.domain.board.model.entity.Tag;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TagRepository extends JpaRepository<Tag, Long> {
}
