package org.palpalmans.ollive_back.domain.fridge.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.palpalmans.ollive_back.domain.fridge.model.dto.request.FridgeIngredientRequest;
import org.palpalmans.ollive_back.domain.fridge.model.entity.FridgeIngredient;
import org.palpalmans.ollive_back.domain.fridge.repository.FridgeIngredientRepository;
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

import java.time.LocalDate;
import java.util.Date;

import static org.palpalmans.ollive_back.domain.member.model.status.MemberRole.ROLE_ADMIN;
import static org.springframework.http.MediaType.APPLICATION_JSON;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(SpringExtension.class)
@SpringBootTest
@AutoConfigureMockMvc
class FridgeIngredientControllerTest {
    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private FridgeIngredientRepository fridgeIngredientRepository;

    Member member;
    NormalMember normalMember;

    private String objectToJson(Object object) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(object);
    }

    private FridgeIngredientRequest request(){
        return new FridgeIngredientRequest("감자", "2022-03-10");
    }

    void fridgeIngredientSetup() {
        fridgeIngredientRepository.save(new FridgeIngredient(normalMember.getId(), "감자", LocalDate.of(2024, 4, 1)));
        fridgeIngredientRepository.save(new FridgeIngredient(normalMember.getId(), "가지", LocalDate.of(2024, 4, 2)));
        fridgeIngredientRepository.save(new FridgeIngredient(normalMember.getId(), "소고기", LocalDate.of(2024, 4, 3)));
        fridgeIngredientRepository.save(new FridgeIngredient(normalMember.getId(), "양파", LocalDate.of(2024, 4, 4)));
    }

    void fridgeIngredientTearDown() {
        fridgeIngredientRepository.deleteAll();
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

    @DisplayName("냉장고 재료 목록 조회 테스트")
    @Test
    @WithUserDetails(value = "test@naver.com",
            userDetailsServiceBeanName = "customMemberDetailsService",
            setupBefore = TestExecutionEvent.TEST_EXECUTION
    )
    void getFridgeIngredientsTest() throws Exception{
        //given
        fridgeIngredientSetup();

        //when
        mockMvc.perform(get("/fridge-ingredients"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].fridgeIngredientId").value(1))
                .andExpect(jsonPath("$[0].name").value("감자"))
                .andExpect(jsonPath("$[1].fridgeIngredientId").value(2))
                .andExpect(jsonPath("$[1].name").value("가지"))
                .andExpect(jsonPath("$[2].fridgeIngredientId").value(3))
                .andExpect(jsonPath("$[2].name").value("소고기"))
                .andExpect(jsonPath("$[3].fridgeIngredientId").value(4))
                .andExpect(jsonPath("$[3].name").value("양파"))
                .andDo(print());

        //then
        fridgeIngredientTearDown();
    }



    @DisplayName("냉장고 재료 저장 테스트")
    @Test
    @WithUserDetails(value = "test@naver.com",
            userDetailsServiceBeanName = "customMemberDetailsService",
            setupBefore = TestExecutionEvent.TEST_EXECUTION
    )
    void registerFridgeIngredientTest() throws Exception {
        //given
        FridgeIngredientRequest request = request();

        //when
        mockMvc.perform(post("/fridge-ingredients").contentType(APPLICATION_JSON).content(objectToJson(request)))
                .andExpect(status().isOk())
                .andDo(print());
        //then
    }
}