package org.palpalmans.ollive_back.domain.recipe.repository;

import org.junit.jupiter.api.Test;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeSearchRequest;
import org.palpalmans.ollive_back.domain.recipe.model.entity.Recipe;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertNotEquals;

@SpringBootTest
class RecipeRepositoryTest {
    @Autowired
    private RecipeRepository recipeRepository;

    private RecipeSearchRequest recipeSearchRequest() {
        List<String> havingIngredients = new ArrayList<>();
        List<String> dislikeIngredient = new ArrayList<>();
        havingIngredients.add("후추");
        havingIngredients.add("돼지고기");
        dislikeIngredient.add("오이");
        return new RecipeSearchRequest(
                "상황별", "일상", 0L, 10, havingIngredients, dislikeIngredient
        );
    }

    @Test
    void dislikeIngredientCheckTest() {
        //given
        RecipeSearchRequest request = recipeSearchRequest();

        //when
        List<Recipe> recipes = recipeRepository.findRecipesByCriteriaWithPaging(request);

        //then
        for (Recipe recipe : recipes) {
            for (Recipe.Ingredient ingredient : recipe.getIngredients()) {
                assertNotEquals("오이", ingredient.getName());
            }
        }
    }
}