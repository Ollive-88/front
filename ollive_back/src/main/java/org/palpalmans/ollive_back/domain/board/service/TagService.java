package org.palpalmans.ollive_back.domain.board.service;

import java.util.List;

import org.palpalmans.ollive_back.domain.board.model.entity.Tag;
import org.palpalmans.ollive_back.domain.board.repository.TagRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TagService {
	private final TagRepository tagRepository;

	@Transactional
	public void saveTags(List<String> tagNames) {
		tagRepository.saveAll(
			tagNames.stream()
				.map(Tag::new)
				.toList()
		);
	}
}
