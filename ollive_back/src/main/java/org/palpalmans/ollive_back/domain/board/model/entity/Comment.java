package org.palpalmans.ollive_back.domain.board.model.entity;

import static jakarta.persistence.FetchType.*;
import static jakarta.persistence.GenerationType.*;
import static lombok.AccessLevel.*;

import org.palpalmans.ollive_back.domain.member.model.entity.Member;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@Table(name = "comments")
@NoArgsConstructor(access = PROTECTED)
public class Comment {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	private Long id;

	@Column(columnDefinition = "TEXT")
	private String content;

	@ManyToOne(fetch = LAZY)
	@JoinColumn(name = "board_id")
	private Board board;

	@ManyToOne
	@JoinColumn(name = "member_id")
	private Member member;
}
