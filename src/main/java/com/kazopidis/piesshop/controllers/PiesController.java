package com.kazopidis.piesshop.controllers;

import java.io.*;
import java.util.List;

import com.kazopidis.piesshop.models.Pie;
import com.kazopidis.piesshop.models.User;
import com.kazopidis.piesshop.models.dao.PieDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/pies")
public class PiesController extends HttpServlet {
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
        List<Pie> pies;

        if (searchQuery != null && !searchQuery.isEmpty()) {
            pies = PieDAO.searchPies(searchQuery); // Method to search pies by name or other attributes
        } else {
            pies = PieDAO.getPies(); // Get all pies
        }

        request.setAttribute("pies",pies);

        // dispatch to jsp
        getServletContext()
                .getRequestDispatcher("/WEB-INF/templates/pies.jsp")
                .forward(request, response);

        }

    }