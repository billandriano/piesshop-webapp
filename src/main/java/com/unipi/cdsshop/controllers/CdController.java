package com.unipi.cdsshop.controllers;

import com.unipi.cdsshop.models.Cd;
import com.unipi.cdsshop.models.dao.CdDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/cd")
public class CdController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // read parameters
        int id = Integer.parseInt(request.getParameter("id"));

        // prepare bean
        Cd cdBean = CdDAO.getCdById(id);
        request.setAttribute("bean",cdBean);

        // dispatch to jsp
        getServletContext()
                .getRequestDispatcher("/WEB-INF/templates/cd.jsp")
                .forward(request, response);

        }

}