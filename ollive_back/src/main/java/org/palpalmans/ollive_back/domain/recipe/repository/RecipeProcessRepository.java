package org.palpalmans.ollive_back.domain.recipe.repository;

import org.palpalmans.ollive_back.domain.recipe.model.entity.RecipeProcess;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RecipeProcessRepository extends JpaRepository<RecipeProcess, Long> {
}
