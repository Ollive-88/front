package org.palpalmans.ollive_back.domain.recipe.repository;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeSearchRequest;
import org.palpalmans.ollive_back.domain.recipe.model.entity.Recipe;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Repository
@RequiredArgsConstructor
public class CustomRecipeRepositoryImpl implements CustomRecipeRepository {

    private final MongoTemplate mongoTemplate;

    @Override
    public List<Recipe> findRecipesByCriteriaWithPaging(RecipeSearchRequest recipeSearchRequest) {
        Long lastRecipeId = recipeSearchRequest.lastRecipeId();
        String recipeCase = recipeSearchRequest.recipeCase();
        String recipeCategory = recipeSearchRequest.recipeCategory();
        List<String> havingIngredients = recipeSearchRequest.havingIngredients();
        List<String> dislikeIngredients = recipeSearchRequest.dislikeIngredients();
        int size = recipeSearchRequest.size();

        // 기본 조건
        Criteria criteria = Criteria.where("recipeId").gt(lastRecipeId)
                .and("categories").elemMatch(Criteria.where("recipe_case_name").is(recipeCase).and("name").is(recipeCategory));

        List<Criteria> andCriteriaList = new ArrayList<>();

        // 필수 재료 포함
        if (!havingIngredients.isEmpty()) {
            andCriteriaList.addAll(havingIngredients.stream()
                    .map(ingredient -> Criteria.where("ingredients.name").regex(Pattern.quote(ingredient), "i"))
                    .collect(Collectors.toList()));
        }

        // 제외 재료 필터링
        if (!dislikeIngredients.isEmpty()) {
            Criteria notCriteria = Criteria.where("ingredients.name").nin(dislikeIngredients);
            andCriteriaList.add(notCriteria);
        }

        // andCriteriaList에 조건이 있다면, criteria에 추가
        if (!andCriteriaList.isEmpty()) {
            criteria = criteria.andOperator(andCriteriaList.toArray(new Criteria[0]));
        }


        Query query = Query.query(criteria).limit(size);
        return mongoTemplate.find(query, Recipe.class);
    }
}
