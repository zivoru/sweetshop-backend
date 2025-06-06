package ru.sweetshop.response;

import ru.sweetshop.model.Order;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public record CustomerFullResponse(Long id,
                                   String name,
                                   String phone,
                                   String address,
                                   Boolean isGuest,
                                   LocalDateTime createdAt,
                                   List<OrderItem> orders) {
    public record OrderItem(Long id,
                            LocalDateTime date,
                            Order.OrderStatus status,
                            BigDecimal totalAmount) {}
}
