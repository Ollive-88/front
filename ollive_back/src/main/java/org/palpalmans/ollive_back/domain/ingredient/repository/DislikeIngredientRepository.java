package org.palpalmans.ollive_back.domain.ingredient.repository;

import org.palpalmans.ollive_back.domain.ingredient.model.entity.DislikeIngredient;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DislikeIngredientRepository extends JpaRepository<DislikeIngredient, Long> {
    List<DislikeIngredient> findByMemberId(long memberId);
}