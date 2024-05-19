<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="bean" scope="request" class="com.unipi.cdsshop.models.Cd"/>
<!DOCTYPE html>
<html>

<%@include file="/WEB-INF/segments/head.jspf"%>

<body>

<div class="container">

    <%@include file="/WEB-INF/segments/header-pages.jspf"%>

    <main>
        <h1><c:out value="${bean.name}"/></h1>

        <div class="cd">
            <img src="<c:out value="${bean.fileName}"/>" alt="Image - <c:out value="${bean.name}"/>"/>
            <p>Ingredients: <c:out value="${bean.ingredients}"/></p>
            <p>Price: <c:out value="${bean.price}"/> €</p>
            <p>Description: <c:out value="${bean.description}"/></p>
        </div>

        <%@include file="/WEB-INF/segments/aside.jspf"%>
    </main>

    <%@include file="/WEB-INF/segments/footer.jspf"%>
</div>

</body>
</html>
