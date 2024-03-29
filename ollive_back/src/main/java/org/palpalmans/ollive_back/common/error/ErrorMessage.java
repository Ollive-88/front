package org.palpalmans.ollive_back.common.error;

import lombok.Getter;

@Getter
public enum ErrorMessage {
    BOARD_NOT_FOUND("해당하는 게시글이 존재하지 않습니다."),
    NOT_BLANK("공백일 수 없습니다.");

    private final String message;

    ErrorMessage(String message) {
        this.message = message;
    }
}
