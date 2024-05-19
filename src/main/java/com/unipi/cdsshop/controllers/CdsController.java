package com.unipi.cdsshop.controllers;

import java.io.*;
import java.util.List;

import com.unipi.cdsshop.models.Cd;
import com.unipi.cdsshop.models.User;
import com.unipi.cdsshop.models.dao.CdDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/cds")
public class CdsController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // Check if the user is logged in
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || user.getId() == 0) {
            request.setAttribute("errors", "You have to login first in order to make an order.");
            getServletContext()
                    .getRequestDispatcher("/WEB-INF/templates/login.jsp")
                    .forward(request, response);
            return;
        }

        String searchQuery = request.getParameter("searchQuery");
        List<Cd> cds;

        if (searchQuery != null && !searchQuery.isEmpty()) {
            cds = CdDAO.searchCds(searchQuery); // Method to search cds by name or other attributes
        } else {
            cds = CdDAO.getCds(); // Get all cds
        }

        request.setAttribute("cds",cds);

        // dispatch to jsp
        getServletContext()
                .getRequestDispatcher("/WEB-INF/templates/cds.jsp")
                .forward(request, response);

        }

    }