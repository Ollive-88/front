package org.palpalmans.ollive_back.domain.image.repository;

import org.palpalmans.ollive_back.domain.image.model.entity.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
}
