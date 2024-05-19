package com.unipi.cdsshop.controllers;

import java.io.*;
import java.time.LocalDateTime;
import java.util.*;

import com.unipi.cdsshop.email.Email;
import com.unipi.cdsshop.forms.FormOrder;
import com.unipi.cdsshop.models.*;
import com.unipi.cdsshop.models.dao.AreaDAO;
import com.unipi.cdsshop.models.dao.OrderDAO;
import com.unipi.cdsshop.models.dao.CdDAO;
import com.unipi.cdsshop.models.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

@WebServlet("/buy")
public class BuyController extends HttpServlet {

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

        // Create a CSRF token and store it in the session
        String csrfToken = UUID.randomUUID().toString();
        request.getSession().setAttribute("csrfToken", csrfToken);
        
            

        List<Cd> cds = CdDAO.getCds();
        request.setAttribute("cds",cds);


        List<Area> areas = AreaDAO.getAreas();
        request.setAttribute("areas",areas);


        request.getSession().setAttribute("user", user);


        //trivial response
        getServletContext()
                .getRequestDispatcher("/WEB-INF/templates/buy.jsp")
                .forward(request, response);
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

        boolean offerSelected = request.getParameter("offer1") != null;

        FormOrder formOrder = new FormOrder(
                request.getParameter("name"),
                request.getParameter("address"),
                Integer.parseInt(request.getParameter("area")),
                request.getParameter("email"),
                request.getParameter("tel"),
                request.getParameter("message"),
                null,
                offerSelected,
                request.getParameter("payment"),
                LocalDateTime.now()
        );

        List<Cd> cds = CdDAO.getCds();

        List<OrderItem> orderItems = new ArrayList<>();

        for(var cd: cds) {
            int quantity = Integer.parseInt(request.getParameter("Order"+cd.getName()));
            orderItems.add(new OrderItem(null,cd.getId(),null,quantity));
            //System.out.println("Cd: " + cd.getName() + ", Quantity: " + quantity);
        }

        int totalcds = 0;
        for (OrderItem orderItem: orderItems) {
            System.out.println(orderItem.getQuantity());
            totalcds += orderItem.getQuantity();
        }


        formOrder.setOrderItems(orderItems);

        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();
        Set<ConstraintViolation<FormOrder>> errors = validator.validate(formOrder);


        if (errors.isEmpty()) { //No errors
            // send E-mails
            Email.sendEmailToAdminOrderForm(formOrder);
            Email.sendEmailToClientOrderForm(formOrder);

            // Insert order to db
            OrderDAO.storeOrder(formOrder, (User) request.getSession().getAttribute("user"));

            // response
            request.setAttribute("areas",AreaDAO.getAreas());
            request.setAttribute("cds",CdDAO.getCds());
            request.setAttribute("success",true);

            getServletContext()
                    .getRequestDispatcher("/WEB-INF/templates/buy.jsp")
                    .forward(request, response);

        } else { // Errors
            StringBuilder errorMessage = new StringBuilder("<ul>");

            errorMessage.append("<p>The form contains the following errors:</p>");

            for (var error: errors) {
                errorMessage.append("<li>" + error.getMessage() + "</li>");
            }

            errorMessage.append("</ul>");

            request.setAttribute("cds",CdDAO.getCds());
            request.setAttribute("areas", AreaDAO.getAreas());
            request.setAttribute("errors",errorMessage);
            request.setAttribute("formOrder",formOrder);

            getServletContext()
                    .getRequestDispatcher("/WEB-INF/templates/buy.jsp")
                    .forward(request, response);
        }

        System.out.println(formOrder);

    }
}














































