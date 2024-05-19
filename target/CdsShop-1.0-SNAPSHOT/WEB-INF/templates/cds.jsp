<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/segments/head.jspf"%>
<script>
  class Cart {
    constructor() {
      this.items = JSON.parse(localStorage.getItem('cart')) || [];
      console.log('Cart initialized with items:', this.items);
    }

    addToCart(cdName) {
      const found = this.items.find(item => item.name === cdName);
      if (!found) {
        this.items.push({ name: cdName, quantity: 1 });
      } else {
        found.quantity += 1;
      }
      console.log('Item added to cart:', this.items);
      this.saveCart();
    }

    saveCart() {
      localStorage.setItem('cart', JSON.stringify(this.items));
      console.log('Cart saved to localStorage:', this.items);
      this.updateCartDisplay();
    }

    updateCartDisplay() {
      const display = document.querySelector('#cart-items');
      if (display) {
        display.innerHTML = ''; // Clear existing items
        if (this.items.length > 0) {
          this.items.forEach(item => {
            display.innerHTML += "<br>" + item.name + " - Quantity: " + item.quantity + "</br>";
          });

        } else {
          display.innerHTML = 'Cart is empty';
        }
        console.log('Cart display updated:', display.innerHTML);
      } else {
        console.error('Cart display element not found');
      }
    }

    clearCart() {
      localStorage.removeItem('cart');
      this.items = [];
      console.log('Cart cleared');
      this.updateCartDisplay();
    }
  }

  const cart = new Cart(); // Instantiate the cart object

  window.onload = () => {
    console.log('Window loaded');
    cart.updateCartDisplay(); // Update cart display on page load
  }

  // Expose addToCart and clearCart functions to the global scope to be accessed by HTML buttons
  function addToCart(cdName) {
    console.log('addToCart called with:', cdName);
    cart.addToCart(cdName);
  }

  function clearCart() {
    console.log('clearCart called');
    cart.clearCart();
  }
</script>

<body>
  <div class="container">
    <%@include file="/WEB-INF/segments/header-pages.jspf"%>

    <main>
      <h1>The cds</h1>
    
      <article>
        <c:choose>
            <c:when test="${not empty param.searchQuery}">
                <p>You searched for: <strong><c:out value="${param.searchQuery}" /></strong></p>
            </c:when>
            <c:otherwise>
                <p>Every item is displayed.</p>
            </c:otherwise>
        </c:choose>
        <form action="cds" method="get"> 
          <input type="text" name="searchQuery" placeholder="Search cds..." value="<c:out value="${param.searchQuery}" />" />
          <button type="submit">Search</button>
        </form>
        <table class="table-cds">
          <caption>Our cds</caption>
          <thead>
            <tr>
              <th></th>
              <th>cd</th>
              <th>Price/slice</th>
              <th>Action</th> 
            </tr>
          </thead>
          <tbody>
            <c:forEach var="cd" items="${requestScope['cds']}">
              <tr>
                <td><img src="${pageContext.request.contextPath}/${cd.fileName}" alt="<c:out value="${cd.name}" />" style="max-width: 100px; max-height: 100px;"></td>
                <td><a href="${pageContext.request.contextPath}/cd?id=${cd.id}"><c:out value="${cd.name}" /></a></td>
                <td>${cd.price} €</td>
                <td><button type="button" onclick="addToCart('<c:out value="${cd.name}" />')">Add to Cart</button></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </article>

      <%@include file="/WEB-INF/segments/aside.jspf"%>

    </main>

    <%@include file="/WEB-INF/segments/footer.jspf"%>

  </div>
</body>
</html>
