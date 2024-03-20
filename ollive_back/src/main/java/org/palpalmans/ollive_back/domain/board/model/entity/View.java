package org.palpalmans.ollive_back.domain.board.model.entity;

import static jakarta.persistence.CascadeType.*;
import static jakarta.persistence.FetchType.*;
import static jakarta.persistence.GenerationType.*;
import static lombok.AccessLevel.*;

import org.palpalmans.ollive_back.domain.member.model.entity.Member;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Table(name = "views")
@Getter
@Entity
@NoArgsConstructor(access = PROTECTED)
public class View {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	private Long id;

	@ManyToOne(fetch = LAZY, cascade = PERSIST)
	@JoinColumn(name = "board_id", nullable = false)
	private Board board;

	@ManyToOne(fetch = LAZY, cascade = PERSIST)
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;

	public View(Long id, Board board, Member member) {
		this.id = id;
		this.board = board;
		this.member = member;
	}

	public View(Board board, Member member) {
		this.board = board;
		this.member = member;
	}
}
