package com.kp.repository;

import com.kp.domain.Article;
import com.kp.domain.Category;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;


/**
 * Created by turgaycan on 9/26/15.
 */
public interface ArticleRepository extends JpaRepository<Article, Long> {

    @Query("FROM Article a LEFT JOIN FETCH  a.user u LEFT JOIN FETCH a.category at WHERE a.id =(:id)")
    Article findArticleById(@Param("id") Long id);

    @Query(value = "SELECT a From Article a LEFT JOIN a.user u LEFT JOIN a.category cat WHERE a.category.id = (:categoryId) ORDER BY a.createdate DESC",
            countQuery = "SELECT count(a) FROM Article a LEFT JOIN a.user u LEFT JOIN a.category cat WHERE a.category.id = (:categoryId)")
    Page<Article> findByCategoryPageable(@Param("categoryId") long categoryId, Pageable page);

    Page<Article> findByCategoryOrTitleLike(Category category, String title, Pageable page);

    Page<Article> findByCategory(Category category, Pageable page);

    Page<Article> findByCategoryIn(List<Category> category, Pageable page);


    Page<Article> findByCreatedateAfterAndCreatedateBefore(Date startDate, Date endDate, Pageable page);

    @Query(value = "SELECT a From Article a LEFT JOIN a.user u LEFT JOIN a.category cat ORDER BY a.createdate DESC")
    Page<Article> findPageableOrderByCreatedateDesc(Pageable page);

    @Query(value = "select * from kp.article a left join kp.user u on u.id = a.user_id left join kp.category cat on cat.id = a.category_id where a.id = (:id)",
            nativeQuery = true)
    Article findById(@Param("id") Long id);

    @Query(value = "SELECT * FROM kp.article a left join kp.category cat on cat.id = a.category_id left join kp.user u on u.id = a.user_id WHERE  a.category_id IN (:category_id) order by view_number desc LIMIT 2",
            nativeQuery = true)
    List<Article> findByCategoryId(@Param("category_id") Long[] parentIds);

    Page<Article> findByTagsContaining(String tag, Pageable page);



}
