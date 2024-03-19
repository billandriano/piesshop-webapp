<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="formData" class="com.kazopidis.piesshop.forms.FormContact" scope="request" />

<!DOCTYPE html>
<html>

<%@ include file="/WEB-INF/segments/head.jspf"%>

<body>
<div class="container">
  <%@ include file="/WEB-INF/segments/header-pages.jspf"%>

  <main>
    <h1>Contact</h1>

    <article>
      <c:choose>
        <c:when test="${requestScope['success']}">
          <div class="success-message">
            We received your message, we will contact you soon!
          </div>
        </c:when>
        <c:otherwise>

          <c:if test="${requestScope['errors']!=null}">
            <div class="error-message">${requestScope['errors']} </div>
          </c:if>

          <form action="contact" method="POST" class="form contact">
            <label for="txtName">Full Name(*):</label>
            <input type="text" id="txtName" name="fullName" minlength="3" maxlength="40" size="40" value="${formData.fullName}" required>

            <label for="txtEmail">E-mail(*): </label>
            <input type="email" id="txtEmail" name="email" size="40" value="${formData.email}" required>

            <label for="txtTel">Phone: </label>
            <input type="tel" id="txtTel" name="tel" size="10" value="${formData.tel}">

            <label for="txtMessage">Message(*): </label>
            <textarea id="txtMessage" name="message" rows="6" cols="40" required></textarea>

            <span>(*) The fields are required</span>
            <input type="submit" value="Submit">
          </form>
        </c:otherwise>
      </c:choose>

      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6289.918171590941!2d23.729895121019716!3d37.97808412916098!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14a1bd07ede2000d%3A0x5253e5bfc6a0254!2zzqPPgM65z4TOuc66z4w!5e0!3m2!1sen!2sgr!4v1709574517517!5m2!1sen!2sgr" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

    </article>

    <%@ include file="/WEB-INF/segments/aside.jspf"%>
  </main>

  <%@ include file="/WEB-INF/segments/footer.jspf"%>
</div>
</body>


</html>
