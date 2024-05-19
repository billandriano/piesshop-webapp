package com.unipi.cdsshop.controllers;

import com.unipi.cdsshop.email.Email;
import com.unipi.cdsshop.forms.FormRegister;
import com.unipi.cdsshop.models.User;
import com.unipi.cdsshop.models.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

import java.io.IOException;
import java.util.Set;
import java.util.UUID;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = UserDAO.getUserBySession(request.getSession().getId());
        request.getSession().setAttribute("user", user);

        // Create a CSRF token and store it in the session
        String csrfToken = UUID.randomUUID().toString();
        request.getSession().setAttribute("csrfToken", csrfToken);

        if (user != null) {
            // If the user is already logged in, redirect to a different page
            request.setAttribute("errors", "You are logged in so you cannot register for now.");
            getServletContext().getRequestDispatcher("/WEB-INF/templates/index.jsp")
                    .forward(request, response);
        } else {
            String code = request.getParameter("code");

            if (code == null) {
               
                getServletContext().getRequestDispatcher("/WEB-INF/templates/register.jsp")
                        .forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve the CSRF token from the session
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        // Retrieve the CSRF token from the request
        String requestToken = request.getParameter("csrfToken");

        // Validate the CSRF token
        if (sessionToken == null || !sessionToken.equals(requestToken)) {
            throw new ServletException("Invalid CSRF token");
        }
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String tel = request.getParameter("tel");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
    
        FormRegister formRegister = new FormRegister(fullName, email, tel, username, password, password2);
    
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<FormRegister>> errors = validator.validate(formRegister);
    
        if (errors.isEmpty()) {
            int id = UserDAO.storeUserVerified(formRegister);
            request.setAttribute("success", true);
            getServletContext().getRequestDispatcher("/WEB-INF/templates/register.jsp").forward(request, response);
        } else {
            StringBuilder errorMessage = new StringBuilder("<ul>");
            errorMessage.append("<p>The form contains the following errors:</p>");
            for (var error : errors) {
                errorMessage.append("<li>" + error.getMessage() + "</li>");
            }
            errorMessage.append("</ul>");
            request.setAttribute("errors", errorMessage.toString());
            request.setAttribute("formRegister", formRegister);
            getServletContext().getRequestDispatcher("/WEB-INF/templates/register.jsp").forward(request, response);
        }
    }
    
}
