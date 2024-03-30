package org.palpalmans.ollive_back.domain.ingredient.repository;

import org.palpalmans.ollive_back.domain.ingredient.model.entity.DislikeIngredient;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DislikeIngredientRepository extends JpaRepository<DislikeIngredient, Long> {
}
