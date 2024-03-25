package org.palpalmans.ollive_back.domain.recipe.model.dto;

import org.palpalmans.ollive_back.domain.recipe.model.entity.Recipe;
import org.palpalmans.ollive_back.domain.recipe.model.entity.RecipeIngredient;
import org.palpalmans.ollive_back.domain.recipe.model.entity.RecipeProcess;

import java.util.List;

public class RecipeMapper {
    public static RecipeDto toRecipeDto(Recipe recipe){
        return new RecipeDto(
                recipe.getId(), recipe.getTitle(), recipe.getThumbnail_url(), recipe.getAmount(),
                recipe.getTime(), recipe.getDifficulty(), recipe.getScore()
        );
    }

    public static RecipeIngredientDto toRecipeIngredientDto(RecipeIngredient recipeIngredient){
        return new RecipeIngredientDto(
            recipeIngredient.getIngredient().getName(), recipeIngredient.getAmount()
        );
    }

    public static RecipeProcessDto toRecipeProcessDto(RecipeProcess recipeProcess){
        return new RecipeProcessDto(
            recipeProcess.getCookOrder(), recipeProcess.getContent(), recipeProcess.getImageUrl()
        );
    }

    public static RecipeDetailDto toRecipeDetailDto(RecipeDto recipe, List<RecipeIngredientDto> recipeIngredients, List<RecipeProcessDto> recipeProcesses){
        return new RecipeDetailDto(recipe, recipeIngredients, recipeProcesses);
    }
}
