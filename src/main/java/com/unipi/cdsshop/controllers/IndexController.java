package com.kazopidis.cdsshop.controllers;

import java.io.*;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(urlPatterns = {"","/index"})
public class IndexController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // Create a CSRF token and store it in the session
        String csrfToken = UUID.randomUUID().toString();
        request.getSession().setAttribute("csrfLoginToken", csrfToken);
        System.out.println("CSRF Token created and stored in session: " + csrfToken);


        getServletContext()
                .getRequestDispatcher("/WEB-INF/templates/login.jsp")
                .forward(request, response);
    }

}