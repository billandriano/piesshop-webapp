package com.unipi.cdsshop.models;

import java.io.Serializable;

public class OrderItem implements Serializable {
    private Integer id;
    private Integer cdId;
    private Integer orderId;
    private Integer quantity;

    public OrderItem() {
    }

    public OrderItem(Integer id, Integer cdId, Integer orderId, Integer quantity) {
        this.id = id;
        this.cdId = cdId;
        this.orderId = orderId;
        this.quantity = quantity;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCdId() {
        return cdId;
    }

    public void setCdId(Integer cdId) {
        this.cdId = cdId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", cdId=" + cdId +
                ", orderId=" + orderId +
                ", quantity=" + quantity +
                '}' +'\n';
    }
}
