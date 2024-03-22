package org.palpalmans.ollive_back.domain.board.model;

import org.palpalmans.ollive_back.domain.board.model.dto.request.WriteBoardRequest;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;

public class BoardMapper {
	public static Board toBoard(WriteBoardRequest writeBoardRequest, Long memberId) {
		return new Board(
			writeBoardRequest.title(), writeBoardRequest.content(), memberId
		);
	}
}
