<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" class="com.unipi.cdsshop.models.User" scope="session" />
<!DOCTYPE html>
<html>

<%@ include file="/WEB-INF/segments/head.jspf" %>

<body>

<div class="container">

    <%@include file="/WEB-INF/segments/header-index.jspf"%>

    <main>
        <h1>Login on the page</h1>
        <article>

            <c:choose>

                <c:when test="${requestScope['success']}">
                    <div class="success-message">
                        Successful Connection! Continue browsing the page!
                    </div>
                </c:when>

                <c:otherwise>

                    <c:if test="${requestScope['errors'] != null}">
                        <div class="error-message">
                                ${requestScope['errors']}
                        </div>
                    </c:if>


                    <form action="login" method="POST" class="form contact">
                        <input type="hidden" name="csrfLoginToken" value="${sessionScope.csrfLoginToken}">
                        <label for="txtUsername">Username(*): </label>
                        <input type="text" id="txtUsername" name="username" size="10" value="${formLogin.username}">

                        <label for="txtPassword">Password(*): </label>
                        <input type="password" id="txtPassword" name="password" maxlength="30">

                        <span>(*) The fields are required</span>

                        
                        <input type="submit" value="Submit">
                        
                    </form>




                </c:otherwise>

            </c:choose>

        </article>


    </main>

    <%@include file="/WEB-INF/segments/footer.jspf"%>

</div>
</body>
</html>
