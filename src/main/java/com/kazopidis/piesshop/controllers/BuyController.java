package com.kazopidis.piesshop.controllers;

import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.kazopidis.piesshop.email.Email;
import com.kazopidis.piesshop.forms.FormOrder;
import com.kazopidis.piesshop.models.*;
import com.kazopidis.piesshop.models.dao.AreaDAO;
import com.kazopidis.piesshop.models.dao.OrderDAO;
import com.kazopidis.piesshop.models.dao.PieDAO;
import com.kazopidis.piesshop.models.dao.UserDAO;
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

        List<Pie> pies = PieDAO.getPies();
        request.setAttribute("pies",pies);


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

        List<Pie> pies = PieDAO.getPies();

        List<OrderItem> orderItems = new ArrayList<>();

        for(var pie: pies) {
            int quantity = Integer.parseInt(request.getParameter("Order"+pie.getName()));
            orderItems.add(new OrderItem(null,pie.getId(),null,quantity));
            //System.out.println("Pie: " + pie.getName() + ", Quantity: " + quantity);
        }

        int totalPies = 0;
        for (OrderItem orderItem: orderItems) {
            System.out.println(orderItem.getQuantity());
            totalPies += orderItem.getQuantity();
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
            request.setAttribute("pies",PieDAO.getPies());
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

            request.setAttribute("pies",PieDAO.getPies());
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














































