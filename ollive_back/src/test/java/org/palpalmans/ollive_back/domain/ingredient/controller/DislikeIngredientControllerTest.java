package org.palpalmans.ollive_back.domain.ingredient.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.palpalmans.ollive_back.domain.ingredient.model.dto.request.DislikeIngredientRegisterRequest;
import org.palpalmans.ollive_back.domain.ingredient.model.entity.DislikeIngredient;
import org.palpalmans.ollive_back.domain.ingredient.repository.DislikeIngredientRepository;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.palpalmans.ollive_back.domain.member.model.entity.NormalMember;
import org.palpalmans.ollive_back.domain.member.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.TestExecutionEvent;
import org.springframework.security.test.context.support.WithUserDetails;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Date;
import java.util.List;

import static org.palpalmans.ollive_back.domain.member.model.status.MemberRole.ROLE_ADMIN;
import static org.springframework.http.MediaType.APPLICATION_JSON;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(SpringExtension.class)
@SpringBootTest
@AutoConfigureMockMvc
class DislikeIngredientControllerTest {
    @Autowired
     MockMvc mockMvc;


    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private DislikeIngredientRepository dislikeIngredientRepository;

    Member member;
    NormalMember normalMember;

    private String objectToJson(Object object) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(object);
    }

    private DislikeIngredientRegisterRequest request(){
        return new DislikeIngredientRegisterRequest("오이");
    }

    void dislikeIngredientSetup(List<DislikeIngredient> list) {

    }

    void dislikeIngredientTearDown() {
        dislikeIngredientRepository.deleteAll();
    }

    @BeforeEach
    void setUp() {
        member = Member.builder()
                .email("test@naver.com")
                .name("name")
                .nickname("nickname")
                .birthday(new Date())
                .profilePicture("profilePicture")
                .role(ROLE_ADMIN)
                .gender("male")
                .build();

        normalMember = new NormalMember(member, "1234");
        memberRepository.save(normalMember);
    }

    @AfterEach
    void tearDown() {
        memberRepository.deleteAll();
    }

    @DisplayName("냉장고 재료 저장 테스트")
    @Test
    @WithUserDetails(value = "test@naver.com",
            userDetailsServiceBeanName = "customMemberDetailsService",
            setupBefore = TestExecutionEvent.TEST_EXECUTION
    )
    void registerFridgeIngredientTest() throws Exception {
        //given
        DislikeIngredientRegisterRequest request = request();

        //when
        mockMvc.perform(post("/dislike-ingredients").contentType(APPLICATION_JSON).content(objectToJson(request)))
                .andExpect(status().isOk())
                .andDo(print());

        //then
        dislikeIngredientTearDown();
    }

}