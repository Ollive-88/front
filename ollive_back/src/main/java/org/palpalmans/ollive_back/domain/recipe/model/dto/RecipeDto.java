package org.palpalmans.ollive_back.domain.recipe.model.dto;

public record RecipeDto(
        String title, String thumbnail_url, String amount, String time, String difficulty
) {
}
