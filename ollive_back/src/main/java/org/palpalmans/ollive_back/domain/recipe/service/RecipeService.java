package org.palpalmans.ollive_back.domain.recipe.service;

import java.util.List;

import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeDetailDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeIngredientDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeMapper;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeProcessDto;
import org.palpalmans.ollive_back.domain.recipe.model.entity.Recipe;
import org.palpalmans.ollive_back.domain.recipe.repository.RecipeRepository;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RecipeService {
	private final RecipeRepository recipeRepository;

	public RecipeDetailDto getRecipe(Long recipeId) {
		//FIXME RuntimeException 변경 필요
		Recipe recipe = recipeRepository.findById(recipeId).orElseThrow(() -> new RuntimeException("존재하지 않는 레시피입니다."));
		RecipeDto recipeDto = RecipeMapper.toRecipeDto(recipe);
		List<RecipeIngredientDto> recipeIngredientDtos = recipe.getRecipeIngredients().stream()
			.map(RecipeMapper::toRecipeIngredientDto)
			.toList();

		List<RecipeProcessDto> recipeProcessDtos = recipe.getRecipeProcesses().stream()
			.map(RecipeMapper::toRecipeProcessDto).toList();

		return RecipeMapper.toRecipeDetailDto(recipeDto, recipeIngredientDtos, recipeProcessDtos);
	}
}
