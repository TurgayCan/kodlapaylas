<%--
  Created by IntelliJ IDEA.
  User: tcan
  Date: 13/10/15
  Time: 01:40
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <h2 class="heading">Yeni Fırından Çıktı!</h2>

    <div class="row">
        <div class="col-md-9 col-lg-9">
            <article class="post">
                <div class="post-type post-img"><a href="<c:url value="/${lastArticle.buildUrl()}" />" title="${lastArticle.title}"><img
                        src="<c:url value='/resources/static/img/${fn:toLowerCase(lastArticle.buildResizedImageUrl("800_400"))}' />"
                        class="img-responsive" style="height: 400px !important;"
                        alt="${fn:toLowerCase(lastArticle.categoryName)}"/></a></div>
                <div class="author-info">
                    <ul class="list-inline">
                        <li>
                            <div class="icon-box" style="width: auto;"><img
                                    src="<c:url value='/resources/static/img/tcan_min.png' />"
                                    class="img-responsive" style="width: 100px !important;"
                                    alt="image post"/></div>
                            <div class="info">
                                <p>Yazar :</p>
                                <a href="<c:url value='/hakkimda' />">${lastArticle.getUserFullname()}</a></div>
                        </li>
                        <li>
                            <div class="icon-box"><i class="fa fa-calendar"></i></div>
                            <div class="info">
                                <p>Tarih :</p>
                                <strong> <fmt:formatDate value="${lastArticle.createdate}" type="both"
                                                         pattern="dd MMM, yyyy"/></strong></div>
                        </li>
                        <li>
                            <div class="icon-box"><i class="fa fa-comments-o"></i></div>
                            <div class="info">
                                <p>Yorum</p>
                                <strong>${lastArticle.commentListSize}</strong></div>
                        </li>
                        <li>
                            <div class="icon-box"><i class="fa fa-eye"></i></div>
                            <div class="info">
                                <p>Görüntüleme</p>
                                <strong>${lastArticle.viewNumber}</strong></div>
                        </li>
                        <li>
                            <div class="icon-box"><i class="fa fa-eye"></i></div>
                            <div class="info">
                                <p>İndirme</p>
                                <strong>${lastArticle.downloadNumber}</strong></div>
                        </li>
                    </ul>
                </div>
                <div class="caption">
                    <h3><a title="${lastArticle.title}"
                           href="<c:url value="/${lastArticle.buildUrl()}" />">${lastArticle.title}</a></h3>

                    <p>${fn:substring(lastArticle.content, 0, 300).contains("<code>") ? '' : fn:substring(lastArticle.content, 0, 300)}</p>

                    <div class="post-category"><a title="${fn:toLowerCase(lastArticle.categoryName)}"
                                                  href="<c:url value="/kategori/${fn:toLowerCase(lastArticle.categoryName)}" />"><span>&nbsp;</span> ${lastArticle.categoryName}
                    </a></div>
                    <ul class="list-inline tags">
                        <c:forEach items="${lastArticle.articleTags}" var="tag">
                            <li><a title="${tag}" href="<c:url value="/${tag}" />">${tag}</a></li>
                        </c:forEach>
                    </ul>
                    <a class="btn btn-default btn-lg" title="<c:url value="/${lastArticle.buildUrl()}"/>"
                       href="<c:url value="/${lastArticle.buildUrl()}" />" role="button">Daha Fazla..</a></div>
            </article>
            <div class="clearfix"></div>
        </div>
        <aside class="col-md-3 col-lg-3">
            <div class="row">
                <script type="text/javascript">
                    $.get("/recent-articles",
                            async = true,
                            function (data, status) {
                                $('#recent-articles').append("" + data);
                            });

                </script>
                <div id="recent-articles"></div>

                <script type="text/javascript">
                    $.get("/root-categories",
                            async = true,
                            function (data, status) {
                                $('#root-categories').append("" + data);
                            });

                </script>
                <div id="root-categories"></div>

            </div>
        </aside>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="parallax-1" class="bgParallax" data-speed="15">
                <div class="color-overlay black">
                    <c:forEach var="event" items="${latestEvents}">
                        <h3 style="padding-left: 20px !important;"><span>Sıcak Etkinlikler :</span>
                                ${event.title}
                            <a style="padding-left: 20px;" href="<c:url value="/${event.buildUrl()}" />"
                               title="${event.title}"> --> detay için..</a></h3>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <h2 class="heading">Programlama</h2>

    <div class="row">
        <div class="col-md-8 col-lg-8">
            <div class="row">
                <c:forEach var="vArticle" items="${mostViewsOfProgramming}">
                    <%@include file="vertical-article.jsp" %>
                </c:forEach>
            </div>
            <div class="clearfix"></div>
        </div>
        <aside class="col-md-4 col-lg-4">
            <div class="row">
                <div class="col-sm-6 col-md-12 col-lg-12">
                    <div class="panel panel-default theme-panel">
                        <div class="panel-heading">Search Post</div>
                        <div class="panel-body">
                            <form action="#" method="post">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
                    </span></div>
                            </form>
                        </div>
                    </div>
                </div>
                <%@include file="archive.jsp" %>
            </div>
        </aside>
    </div>
    <h2 class="heading">Database</h2>

    <div class="row">
        <div class="col-md-8 col-lg-8">
            <c:forEach var="article" items="${mostViewsOfDatabase}">
                <%@include file="horizontal-article.jsp" %>
            </c:forEach>
            <div class="pagination-wrap">
                <ul class="pagination">
                    <li class="disabled"><a href="#" aria-label="Previous"> <span aria-hidden="true">Previous</span>
                    </a></li>
                    <li class="active"><a href="<c:url value="/kategori/kp" />">1</a></li>
                    <li><a href="<c:url value="/kategori/kp/p2" />">2</a></li>
                    <li><a href="<c:url value="/kategori/kp" />">...</a></li>
                    <li><a href="<c:url value="/kategori/kp/p61" />" aria-label="Next"> <span
                            aria-hidden="true">Next</span> </a></li>
                </ul>
            </div>
            <div class="clearfix"></div>
        </div>
        <aside class="col-md-4 col-lg-4">
            <div class="row">
                <%@include file="subscribeus.jsp" %>
                <%@include file="../commons/tags.jsp" %>
            </div>
        </aside>
    </div>
</div>
