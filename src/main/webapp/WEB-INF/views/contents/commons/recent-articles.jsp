<%--
  Created by IntelliJ IDEA.
  User: turgaycan
  Date: 9/28/15
  Time: 12:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-sm-6 col-md-12 col-lg-12">

    <div class="panel panel-default theme-panel">

        <div class="panel-heading">Son Yazılar..</div>

        <div class="panel-body nopadding">

            <c:forEach items="${recentArticles}" var="each">
                <div class="media">
                    <!--loop -->
                    <div class="media-left">
                        <a title="${each.title}" href="<c:url value="/${each.buildUrl()}" />">
                            <img src="<c:url value='/resources/static/img/${fn:toLowerCase(each.mainImageUrl)}' />"
                                 alt="${each.getUserFullname()}"/>
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading"><a title="${each.title}" href="<c:url value="/${each.buildUrl()}" />">${each.title}</a>
                        </h4>

                        <p>
                            <a title="${fn:toLowerCase(each.categoryName)}" href="<c:url value="/kategori/${fn:toLowerCase(each.categoryName)}" />">${each.categoryName}</a> &bull;
                            <fmt:formatDate value="${each.createdate}" type="both" timeZone="tr"
                                            pattern="dd MMM, yyyy"/>
                        </p>
                    </div>
                </div>
            </c:forEach>

        </div>

    </div>

</div>