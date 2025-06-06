package ru.sweetshop.request;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public record AddOrderRequest(Long userId,
        String name,
                              String phone,
                              String deliveryMethod,
                              String address,
                              LocalDate date,
                              String comment,
                              String paymentMethod,
                              List<Cart> cart,
                              BigDecimal totalAmount) {

    public record Cart(Long id, Integer quantity, BigDecimal price) {

    }
}
