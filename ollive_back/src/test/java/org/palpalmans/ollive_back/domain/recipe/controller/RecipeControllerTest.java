package org.palpalmans.ollive_back.domain.recipe.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeSearchRequest;
import org.palpalmans.ollive_back.domain.recipe.service.RecipeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.notNullValue;
import static org.springframework.http.MediaType.APPLICATION_JSON;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class RecipeControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private RecipeService recipeService;

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

    private RecipeSearchRequest recipeSearchRequestWithNoCategory() {
        List<String> havingIngredients = new ArrayList<>();
        List<String> dislikeIngredient = new ArrayList<>();
        havingIngredients.add("후추");
        havingIngredients.add("돼지고기");

        return new RecipeSearchRequest(
                "종류별", "", 0L, 10, havingIngredients, dislikeIngredient
        );
    }

    private String objectToJson(Object object) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(object);
    }

    @Test
    void getRecipeTest() throws Exception {
        //given

        //when
        ResultActions result = mockMvc.perform(MockMvcRequestBuilders.get("/recipes/1"));

        //then
        result.andExpect(status().isOk())
                .andExpect(jsonPath("$.id", notNullValue()))
                .andExpect(jsonPath("$.title", notNullValue()))
                .andExpect(jsonPath("$.thumbnail_url", notNullValue()))
                .andDo(print());
    }

    @Test
    void getRecipesTest() throws Exception {
        //given
        RecipeSearchRequest request = recipeSearchRequest();

        //when
        ResultActions result = mockMvc.perform(
                MockMvcRequestBuilders.post("/recipes")
                        .contentType(APPLICATION_JSON)
                        .content(objectToJson(request))
        );

        //then
        result.andExpect(status().isOk())
                .andDo(print());

    }


    @Test
    void getRecipesWithNoCategoryTest() throws Exception {
        //given
        RecipeSearchRequest request = recipeSearchRequestWithNoCategory();

        //when
        ResultActions result = mockMvc.perform(
                MockMvcRequestBuilders.post("/recipes")
                        .contentType(APPLICATION_JSON)
                        .content(objectToJson(request))
        );

        //then
        result.andExpect(status().isOk())
                .andDo(print());
    }
}