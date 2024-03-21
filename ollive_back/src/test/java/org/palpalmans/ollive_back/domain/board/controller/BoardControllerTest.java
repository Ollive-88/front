package org.palpalmans.ollive_back.domain.board.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import java.nio.charset.StandardCharsets;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.multipart;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(SpringExtension.class)
@SpringBootTest
@AutoConfigureMockMvc
class BoardControllerTest {
    @Autowired
    MockMvc mockMvc;

    @Autowired
    ObjectMapper objectMapper;

    @Test
    @DisplayName("write board controller test")
    @Transactional
    void writeBoard() throws Exception {
        MockMultipartFile mockImage1 = new MockMultipartFile("images", "test1".getBytes(StandardCharsets.UTF_8));
        MockMultipartFile mockImage2 = new MockMultipartFile("images", "test2".getBytes(StandardCharsets.UTF_8));

        mockMvc.perform(multipart("/api/v1/boards")
                        .file(mockImage1)
                        .file(mockImage2)
                        .content("content")
                        .param("title", "title")
                        .param("content", "content")
                        .param("tagNames", "tagName1")
                        .param("tagNames", "tagName2")
                )
                .andExpect(status().isCreated())
                .andDo(print());
    }
}