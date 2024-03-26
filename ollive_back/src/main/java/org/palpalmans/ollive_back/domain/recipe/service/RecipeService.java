package org.palpalmans.ollive_back.domain.recipe.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeMapper;
import org.palpalmans.ollive_back.domain.recipe.model.entity.Recipe;
import org.palpalmans.ollive_back.domain.recipe.repository.RecipeRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RecipeService {
    private final RecipeRepository recipeRepository;

	public RecipeDto getRecipe(Long recipeId) {
		Recipe recipe = recipeRepository.findByRecipeId(recipeId).orElseThrow(() -> new RuntimeException("존재하지 않는 레시피 입니다."));
		return RecipeMapper.toRecipeDto(recipe);
	}
}
