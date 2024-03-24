package org.palpalmans.ollive_back.domain.recipe.model.dto;

import java.util.List;

public record RecipeDetailDto(RecipeDto recipe, List<RecipeIngredientDto> recipeIngredients, List<RecipeProcessDto> recipeProcesses) {
}
