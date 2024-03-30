package org.palpalmans.ollive_back.domain.fridge.repository;

import org.palpalmans.ollive_back.domain.fridge.model.entity.FridgeIngredient;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FridgeIngredientRepository extends JpaRepository<FridgeIngredient, Long> {
    List<FridgeIngredient> findByMemberIdOrderByEndAtAsc(long memberId);
}
