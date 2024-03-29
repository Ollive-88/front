package org.palpalmans.ollive_back.domain.recipe.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeMapper;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeSummaryDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeRecommendRequest;
import org.palpalmans.ollive_back.domain.recipe.model.entity.RecipeScore;
import org.palpalmans.ollive_back.domain.recipe.repository.RecipeRepository;
import org.palpalmans.ollive_back.domain.recipe.repository.RecipeScoreRepository;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class RecipeRecommendService {
    private final RecipeScoreRepository recipeScoreRepository;
    private final RecipeRepository recipeRepository;

    public List<RecipeSummaryDto> getRecommendCandidates(RecipeRecommendRequest request){
        //FIXME memberId를 컨트롤러에서부터 받아오게끔 변경 필요
        Long memberId = 1L;

        List<Long> scoredRecipeIds = recipeScoreRepository.findByMemberId(memberId).stream().map(RecipeScore::getRecipeId).toList();

        return recipeRepository.findRecipesByIngredientsAndScoredRecipeIds(request, scoredRecipeIds)
                .stream()
                .map(RecipeMapper::toRecipeSummaryDto)
                .toList();
    }

    public List<RecipeSummaryDto> recommendRecipes(List<RecipeSummaryDto> candidates) {
        Map<Long, Double> scores = new HashMap<>();

        for (RecipeSummaryDto candidate : candidates) {
            double score = predictScoreForUnScoredRecipe(candidate.recipeId());
            scores.put(candidate.recipeId(), score);
        }

        System.out.println(candidates);

        candidates.sort(new Comparator<>() {
            @Override
            public int compare(RecipeSummaryDto o1, RecipeSummaryDto o2) {
                return Double.compare(scores.get(o2.recipeId()), scores.get(o1.recipeId()));
            }
        });

        return candidates.subList(0, 10);
    }

    public double predictScoreForUnScoredRecipe(Long unScoredRecipeId) {
        List<RecipeScore> allScores = recipeScoreRepository.findAll();
        Map<Long, Double> averageDeviations = new HashMap<>();
        Map<Long, Integer> countMap = new HashMap<>();

        // 각 아이템에 대한 평균 편차 계산
        for (RecipeScore outerScore : allScores) {
            for (RecipeScore innerScore : allScores) {
                if (!outerScore.getRecipeId().equals(innerScore.getRecipeId()) && outerScore.getMemberId().equals(innerScore.getMemberId())) {
                    double deviation = outerScore.getScore() - innerScore.getScore();
                    averageDeviations.merge(outerScore.getRecipeId(), deviation, Double::sum);
                    countMap.merge(outerScore.getRecipeId(), 1, Integer::sum);
                }
            }
        }

        averageDeviations.forEach((key, value) -> averageDeviations.put(key, value / countMap.get(key)));

        // 새 아이템에 대한 예상 선호도 계산
        double numerator = 0.0;
        double denominator = 0.0;
        for (Map.Entry<Long, Double> entry : averageDeviations.entrySet()) {
            if (entry.getKey().equals(unScoredRecipeId)) continue;
            List<RecipeScore> itemScores = recipeScoreRepository.findByRecipeId(entry.getKey());
            for (RecipeScore score : itemScores) {
                numerator += (score.getScore() + entry.getValue()) * countMap.get(entry.getKey());
                denominator += countMap.get(entry.getKey());
            }
        }

        return numerator / denominator;
    }
}
