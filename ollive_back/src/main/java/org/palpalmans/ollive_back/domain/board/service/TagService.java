package org.palpalmans.ollive_back.domain.board.service;

import org.palpalmans.ollive_back.domain.board.repository.TagRepository;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TagService {
	private final TagRepository tagRepository;
}
