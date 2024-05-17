<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="formOrder" class="com.kazopidis.piesshop.forms.FormOrder" scope="request" />
<jsp:useBean id="user" class="com.kazopidis.piesshop.models.User" scope="session" />


<!DOCTYPE html>
<html>

<%@ include file="/WEB-INF/segments/head.jspf"%>

<script>
    // Function to check if cart contains a pie with the given name
    function isPieInCart(pieName) {
        const cartItems = JSON.parse(localStorage.getItem('cart')) || [];
        return cartItems.some(item => item.name === pieName);
    }

    // Function to create or update input fields for pies in cart
    function createPieInputs() {
        const pieInputContainer = document.querySelector('#pie-inputs');
        const cartItems = JSON.parse(localStorage.getItem('cart')) || [];

        if (cartItems.length > 0) {
            cartItems.forEach(item => {
                let input = document.querySelector('#txt' + item.name);
                let hiddenInput = document.querySelector('input[name="Order' + item.name + '_hidden"]');
                if (input) {
                    // Update the value of the existing input
                    input.value = item.quantity;
                } else {
                    // Create new input elements if they don't exist
                    const label = document.createElement('label');
                    label.htmlFor = 'txt' + item.name;
                    label.textContent = item.name + ': ';

                    input = document.createElement('input');
                    input.type = 'number';
                    input.id = 'txt' + item.name;
                    input.name = 'Order' + item.name;
                    input.min = 0;
                    input.max = 100;
                    input.value = item.quantity;

                    hiddenInput = document.createElement('input');
                    hiddenInput.type = 'hidden';
                    hiddenInput.name = 'Order' + item.name + '_hidden';
                    hiddenInput.value = 0;

                    pieInputContainer.appendChild(hiddenInput);
                    pieInputContainer.appendChild(label);
                    pieInputContainer.appendChild(input);
                    pieInputContainer.appendChild(document.createElement('br'));
                }
            });
        }
    }

    // Execute createPieInputs on page load
    window.onload = function() {
        createPieInputs();
    };
</script>

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
                            
                            <div id="pie-inputs">
                                <c:forEach var="pie" items="${requestScope['pies']}">
                                    <label for="txt${pie.name}">${pie.name}: </label>
                                    <input type="number" id="txt${pie.name}" name="Order${pie.name}" min="0" max="100" value="${empty formOrder.orderItems? (empty requestScope[pie.name]? 0: requestScope[pie.name]): formOrder.orderItems[pie.id-1].quantity}" >
                                    <script>
                                        if (isPieInCart('${pie.name}')) {
                                            document.querySelector('#txt${pie.name}').value = cartItems.find(item => item.name === '${pie.name}').quantity;
                                        }
                                    </script>
                                </c:forEach>
                            </div>

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
