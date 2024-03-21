package org.palpalmans.ollive_back.domain.board.repository;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.board.model.entity.View;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace.NONE;

@DataJpaTest
@AutoConfigureTestDatabase(replace = NONE)
class ViewRepositoryTest {
    @Autowired
    private ViewRepository viewRepository;

    @Test
    @DisplayName("save view test")
    @Transactional
    void saveView() {
        Board board = new Board("title", "content", 1L);
        Member member = Member.builder()
                .name("name")
                .nickname("nickname")
                .email("email")
                .birthday("birthday")
                .gender("gender")
                .password("password")
                .role("role")
                .build();

        View view = viewRepository.save(new View(board, member));
        List<View> views = viewRepository.findAll();
        View foundView = views.get(0);

        assertThat(views.size()).isEqualTo(1L);
        assertThat(foundView).usingRecursiveAssertion().isEqualTo(view);
    }
}