<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="formOrder" class="com.unipi.cdsshop.forms.FormOrder" scope="request" />
<jsp:useBean id="user" class="com.unipi.cdsshop.models.User" scope="session" />

<!DOCTYPE html>
<html>

<%@ include file="/WEB-INF/segments/head.jspf"%>

<body>
<div class="container">
    <%@ include file="/WEB-INF/segments/header-pages.jspf"%>

    <main>
        <h1>The cds</h1>
        <article>

            <c:choose>
                <c:when test="${requestScope['success']}">
                    <div class="success-message">
                        We have received your order and our cds will be with you soon!
                    </div>
                </c:when>
                <c:otherwise>
                    <p>
                        Welcome <c:out value="${user.fullName}"/>!
                    </p>

                    <c:if test="${requestScope['errors']!=null}">
                        <div class="error-message"><c:out value="${requestScope['errors']}" escapeXml="false"/></div>
                    </c:if>
                    <form action="buy" method="POST" class="form buy">
                        <section class="customer-info">
                            <h3>
                                Delivery Information:
                            </h3>
                            <label for="txtName">Full Name(*):</label>
                            <input type="text" id="txtName" name="name" minlength="3" maxlength="40" size="40" required
                                   value="<c:out value='${empty formOrder.fullName ? user.fullName : formOrder.fullName}'/>">

                            <label for="txtAddress">(Street - Number)(*):</label>
                            <input type="text" id="txtAddress" name="address" minlength="5" maxlength="40" size="40" required
                                   value="<c:out value='${empty formOrder.address ? user.tel : formOrder.address}'/>">

                            <label for="slArea"> Region(*):</label>
                            <select id="slArea" name="area" required>
                                <c:forEach var="item" items="${requestScope['areas']}">
                                    <option value="<c:out value='${item.id}'/>" <c:if test="${formOrder.areaId == item.id}">selected</c:if>><c:out value="${item.description}"/></option>
                                </c:forEach>
                            </select>

                            <label for="txtEmail">E-mail(*): </label>
                            <input type="email" id="txtEmail" name="email" size="40" required
                                   value="<c:out value='${empty formOrder.email ? user.email : formOrder.email}'/>">

                            <label for="txtTel">Phone(*): </label>
                            <input type="tel" id="txtTel" name="tel" size="15" required
                                   value="<c:out value='${empty formOrder.tel ? user.tel : formOrder.tel}'/>">

                            <label for="txtMessage">Special Information for delivery: </label>
                            <textarea id="txtMessage" name="message" rows="6" cols="40"><c:out value="${formOrder.comments}"/></textarea>

                            <span>(*) The fields are required</span>
                            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                        </section>

                        <section class="order">
                            <h3>
                                Order:
                            </h3>

                            <div id="cd-inputs">
                                <c:forEach var="cd" items="${requestScope['cds']}" varStatus="loop">
                                    <br>
                                    <label for="txt${loop.index}"><c:out value="${cd.name}"/>: </label>
                                    <br>
                                    <input type="number" id="txt${loop.index}" name="Order<c:out value='${cd.name}'/>" min="0" max="100" value="<c:out value='${empty formOrder.orderItems ? (empty requestScope[cd.name] ? 0 : requestScope[cd.name]) : formOrder.orderItems[cd.id-1].quantity}'/>">
                                </c:forEach>
                            </div>
                        </section>
                        <script>
                            function removeSpaces(str) {
                                return str.split(' ').join('');
                            }

                            function createCdInputs(loopIndex, cdName) {
                                const cartItems = JSON.parse(localStorage.getItem('cart')) || [];

                                cartItems.forEach(item => {
                                    let input = document.querySelector('#txt' + loopIndex);
                                    if (item.name === cdName) {
                                        input.value = item.quantity;
                                    }
                                });
                            }

                            function isCdInCart(cdName) {
                                const cartItems = JSON.parse(localStorage.getItem('cart')) || [];
                                return cartItems.some(item => item.name === cdName);
                            }

                            // Call createCdInputs() when the page loads
                            window.onload = function() {
                                <c:forEach var="cd" items="${requestScope['cds']}" varStatus="loop">
                                if (isCdInCart('<c:out value="${cd.name}"/>')) {
                                    createCdInputs(${loop.index}, '<c:out value="${cd.name}"/>');
                                }
                                </c:forEach>
                            };
                        </script>

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
