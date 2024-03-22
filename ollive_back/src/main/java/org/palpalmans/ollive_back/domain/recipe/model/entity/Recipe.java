package org.palpalmans.ollive_back.domain.recipe.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@NoArgsConstructor(access = PROTECTED)
public class Recipe {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    @Column(length = 255, nullable = false)
    private String title;

    @Column(length = 255, nullable = false)
    private String thumbnail_url;

    @Column(length = 255)
    private String amount;

    @Column(length = 255)
    private String time;

    @Column(length = 255)
    private String difficulty;

    @OneToMany
    @JoinColumn(name = "recipe_id")
    List<RecipeProcess> recipeProcesses = new ArrayList<>();

}
