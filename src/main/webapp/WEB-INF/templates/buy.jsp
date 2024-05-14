<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="formOrder" class="com.kazopidis.piesshop.forms.FormOrder" scope="request" />
<jsp:useBean id="user" class="com.kazopidis.piesshop.models.User" scope="session" />


<!DOCTYPE html>
<html>

<%@ include file="/WEB-INF/segments/head.jspf"%>

<body>
<div class="container">
    <%@ include file="/WEB-INF/segments/header-pages.jspf"%>

    <main>
        <h1>The pies</h1>
        <article>

            <c:choose>
                <c:when test="${requestScope['success']}">
                    <div class="success-message">
                        We have received your order and our pies will be with you soon!
                    </div>
                </c:when>
                <c:otherwise>
                    <p>
                        Welcome ${user.fullName}!
                    </p>
                    <ul>
                        <c:set var="cnt" value="0" scope="request"/>
                        <c:forEach var="order" items="${requestScope['previousOrders']}">
                            <li>
                                <a href="buy?previousorder=${cnt}">${order.stamp}: ${order.orderItems}</a>
                                <c:set var="cnt" value="${cnt + 1 }" scope="request"/>
                            </li>
                        </c:forEach>
                    </ul>
                   
                   

                    <c:if test="${requestScope['errors']!=null}">
                        <div class="error-message">${requestScope['errors']} </div>
                    </c:if>
                    <form action="buy" method="POST" class="form buy">
                        <section class="customer-info">
                            <h3>
                                Delivery Information:
                            </h3>
                            <label for="txtName">Full Name(*):</label>
                            <input type="text" id="txtName" name="name" minlength="3" maxlength="40" size="40" required
                                   value="${empty formOrder.fullName? user.fullName: formOrder.fullName}">

                            <label for="txtAddress">(Street - Number)(*):</label>
                            <input type="text" id="txtAddress" name="address" minlength="5" maxlength="40" size="40" required
                                   value="${empty formOrder.address? user.tel: formOrder.address}">

                            <label for="slArea"> Region(*):</label>
                            <select id="slArea" name="area" required>
                                <c:forEach var="item" items="${requestScope['areas']}">
                                    <option value="${item.id}" ${formOrder.areaId == item.id?"selected":""}>${item.description}</option>
                                </c:forEach>
                            </select>

                            <label for="txtEmail">E-mail(*): </label>
                            <input type="email" id="txtEmail" name="email" size="40" required
                                   value="${empty formOrder.email? user.email: formOrder.email}">

                            <label for="txtTel">Phone(*): </label>
                            <input type="tel" id="txtTel" name="tel" size="15" required
                                   value="${empty formOrder.tel? user.tel: formOrder.tel}">

                            <label for="txtMessage">Special Information for delivery: </label>
                            <textarea id="txtMessage" name="message" rows="6" cols="40">${formOrder.comments}</textarea>

                            <span>(*) The fields are required</span>
                        </section>

                        <section class="order">
                            <h3>
                                Order:
                            </h3>


                            <c:forEach var="pie" items="${requestScope['pies']}">
                                <label for="txt${pie.name}">${pie.name}: </label>
                                <input type="number" id="txt${pie.name}" name="Order${pie.name}" min="0" max="100" value="${empty formOrder.orderItems? (empty requestScope[pie.name]? 0: requestScope[pie.name]): formOrder.orderItems[pie.id-1].quantity}" >
                            </c:forEach>

                        </section>

                        <div class="buttons">
                            <input type="submit" value="Submit">
                        
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </article>

        <%@ include file="/WEB-INF/segments/aside.jspf"%>
    </main>

    <%@ include file="/WEB-INF/segments/footer.jspf"%>
</div>
</body>


</html>
