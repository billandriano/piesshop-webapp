package com.unipi.cdsshop.controllers;

import com.unipi.cdsshop.forms.FormLogin;
import com.unipi.cdsshop.models.User;
import com.unipi.cdsshop.models.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

import java.io.IOException;
import java.util.Set;
import java.util.UUID;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = UserDAO.getUserBySession(request.getSession().getId());
        request.getSession().setAttribute("user", user);

        // Create a CSRF token and store it in the session
        String csrfToken = UUID.randomUUID().toString();
        request.getSession().setAttribute("csrfLoginToken", csrfToken);
        System.out.println("CSRF Token created and stored in session: " + csrfToken);



        if (user != null) {
            // Store user's session
            // We want to know where the user came from
            request.getSession().setAttribute("previouspage", request.getParameter("previouspage"));

            request.setAttribute("errors", "You are already logged in to the application.");

            getServletContext()
                    .getRequestDispatcher("/WEB-INF/templates/index.jsp")
                    .forward(request, response);
        } else {
            
            
            getServletContext()
                    .getRequestDispatcher("/WEB-INF/templates/login.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the CSRF token from the session
        String sessionToken = (String) request.getSession().getAttribute("csrfLoginToken");

        // Retrieve the CSRF token from the request
        String requestToken = request.getParameter("csrfLoginToken");
       

        // Validate the CSRF token
        if (sessionToken == null || !sessionToken.equals(requestToken)) {
            System.out.println("Invalid CSRF token");
            throw new ServletException("Invalid CSRF token");
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        FormLogin formLogin = new FormLogin(username, password);

        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<FormLogin>> errors = validator.validate(formLogin);

        if (errors.isEmpty()) { // No errors
            request.setAttribute("success", true);
            HttpSession session = request.getSession();

            UserDAO.storeSession(username, session.getId());

            User user = UserDAO.getUserByUsername(username);
            session.setAttribute("user", user);

            String previousPage = (String) request.getSession().getAttribute("previouspage");

            if (previousPage == null) {
                getServletContext()
                        .getRequestDispatcher("/WEB-INF/templates/index.jsp")
                        .forward(request, response);
            } else {
                response.sendRedirect("/" + previousPage);
            }
        } else { // Errors
            StringBuilder errorMessage = new StringBuilder("<ul>");
            errorMessage.append("<p>The form contains the following errors:</p>");
            for (var error : errors) {
                errorMessage.append("<li>").append(error.getMessage()).append("</li>");
            }
            errorMessage.append("</ul>");
            request.setAttribute("errors", errorMessage.toString());
            request.setAttribute("formLogin", formLogin);

            getServletContext()
                    .getRequestDispatcher("/WEB-INF/templates/login.jsp")
                    .forward(request, response);
        }
    }
}
