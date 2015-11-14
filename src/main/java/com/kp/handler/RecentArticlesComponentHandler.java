package com.kp.handler;


import com.kp.domain.Article;
import com.kp.service.article.ArticleService;
import org.apache.commons.lang3.math.NumberUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by tcan on 17/10/15.
 */
@Controller
public class RecentArticlesComponentHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(RecentArticlesComponentHandler.class);

    @Autowired
    private ArticleService articleService;

    @RequestMapping(value = "/recent-articles-{articleId:\\d+$}", method = RequestMethod.GET)
    public
    @ResponseBody
    ModelAndView listRecentArticles(@PathVariable String articleId, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/contents/commons/recent-articles");
        LOGGER.info("articleId :  {} : uri {}", articleId, request.getRequestURI());
        if (!NumberUtils.isNumber(articleId)) {
            LOGGER.info("currentArticle1 : ", articleId);
            return mav;
        }
        final Article currentArticle = articleService.findBy(Long.valueOf(articleId));
        if (currentArticle == null) {
            LOGGER.info("currentArticle2 : ", articleId);
            return mav;
        }
        final List<Article> recentArticles = articleService.findRecentArticles(currentArticle, Article.RECENT_ARTICLE_LIMIT);
        mav.addObject("recentArticles", recentArticles);
        return mav;
    }
}
