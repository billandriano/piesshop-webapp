package com.unipi.cdsshop.forms.validators;

import com.unipi.cdsshop.models.OrderItem;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

import java.util.List;

public class AtLeastOneItemInOrderValidator implements ConstraintValidator<AtLeastOneItemInOrderConstraint, List<OrderItem>> {

    @Override
    public void initialize(AtLeastOneItemInOrderConstraint constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(List<OrderItem> orderItems, ConstraintValidatorContext constraintValidatorContext) {
        int countItems=0;
        for (OrderItem item: orderItems) {
            countItems+= item.getQuantity();
        }
        return countItems > 0;
    }
}
