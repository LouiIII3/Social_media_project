package com.example.social.controller;

import com.example.social.controller.Article;
import org.springframework.data.repository.CrudRepository;

public interface ArticleRepository extends CrudRepository<Article, Long> {
  //추후 추가 예정
}
