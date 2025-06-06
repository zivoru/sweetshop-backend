package ru.sweetshop.response;

import ru.sweetshop.model.Order;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record OrderDto(
        Long id,
        LocalDateTime orderDate,
        Long customerId,
        String customerName,
        String customerPhone,
        Order.OrderStatus status,
        Order.DeliveryType deliveryType,
        BigDecimal totalAmount) {

    public static OrderDto of(Order order) {
        return new OrderDto(order.getId(),
                order.getOrderDate(),
                order.getCustomer().getId(),
                order.getCustomer().getName(),
                order.getCustomer().getPhone(),
                order.getStatus(),
                order.getDeliveryType(),
                order.getTotalAmount());
    }
}
