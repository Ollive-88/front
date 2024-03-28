package org.palpalmans.ollive_back.domain.recipe.model.dto.request;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record RecipeScoreRequest(
        @NotNull
        Long recipeId,
        @Positive
        int score
) {
}
