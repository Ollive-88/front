package org.palpalmans.ollive_back.domain.recipe.repository;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.repository.MemberRepository;
import org.palpalmans.ollive_back.domain.recipe.model.entity.RecipeScore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.Date;

import static org.assertj.core.api.Assertions.assertThat;
import static org.palpalmans.ollive_back.domain.member.model.status.MemberRole.ROLE_REGISTERED_MEMBER;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

@ExtendWith(SpringExtension.class)
@DataJpaTest
@AutoConfigureTestDatabase(replace = NONE)
public class RecipeScoreRepositoryTest {
    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private RecipeScoreRepository recipeScoreRepository;

    private Member member() {
        return Member.builder()
                .id(1)
                .email("doongdang@mevc.com")
                .gender("Male")
                .birthday(new Date())
                .name("조석현")
                .nickname("조석현")
                .role(ROLE_REGISTERED_MEMBER)
                .build();
    }

    @Test
    void updateRecipeScoreTest() {
        //given
        Member member = member();
        memberRepository.save(member);

        RecipeScore recipeScore = RecipeScore.builder()
                .score(1)
                .recipeId(1L)
                .memberId(1L)
                .build();

        RecipeScore oldRecipeScore = recipeScoreRepository.save(recipeScore);

        //when
        oldRecipeScore.updateScore(5);
        RecipeScore newRecipeScore = recipeScoreRepository.save(oldRecipeScore);

        //then
        assertThat(newRecipeScore.getScore()).isEqualTo(5);
    }
}
