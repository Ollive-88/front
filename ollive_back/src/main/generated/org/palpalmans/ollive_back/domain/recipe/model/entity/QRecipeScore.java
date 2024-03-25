package org.palpalmans.ollive_back.domain.recipe.model.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QRecipeScore is a Querydsl query type for RecipeScore
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QRecipeScore extends EntityPathBase<RecipeScore> {

    private static final long serialVersionUID = 237114384L;

    public static final QRecipeScore recipeScore = new QRecipeScore("recipeScore");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final NumberPath<Long> memberId = createNumber("memberId", Long.class);

    public final NumberPath<Long> recipeId = createNumber("recipeId", Long.class);

    public final NumberPath<Integer> score = createNumber("score", Integer.class);

    public QRecipeScore(String variable) {
        super(RecipeScore.class, forVariable(variable));
    }

    public QRecipeScore(Path<? extends RecipeScore> path) {
        super(path.getType(), path.getMetadata());
    }

    public QRecipeScore(PathMetadata metadata) {
        super(RecipeScore.class, metadata);
    }

}

