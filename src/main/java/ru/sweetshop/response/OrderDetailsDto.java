package ru.sweetshop.response;

import ru.sweetshop.model.Order;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public record OrderDetailsDto(
        Long id,
        String orderIdUuid,
        Long customerId,
        String customerName,
        String customerPhone,
        LocalDateTime orderDate,
        Order.OrderStatus status,
        Order.DeliveryType deliveryType,
        String deliveryAddress,
        LocalDate deliveryDate,
        Long pickupStoreId,
        String pickupStoreName,
        String pickupStoreAddress,
        String comment,
        Order.PaymentMethod paymentMethod,
        BigDecimal totalAmount,
        List<ProductDto> products) {
    public record ProductDto(
            Long productId,
            String name,
            String imageName,
            Integer quantity,
            BigDecimal unitPrice) {
    }

    public static OrderDetailsDto of(Order order) {
        return new OrderDetailsDto(
                order.getId(),
                order.getOrderIdUuid().toString(),
                order.getCustomer().getId(),
                order.getCustomer().getName(),
                order.getCustomer().getPhone(),
                order.getOrderDate(),
                order.getStatus(),
                order.getDeliveryType(),
                order.getDeliveryAddress(),
                order.getDeliveryDate(),
                order.getPickupStore() == null ? null : order.getPickupStore().getId(),
                order.getPickupStore() == null ? null : order.getPickupStore().getName(),
                order.getPickupStore() == null ? null : order.getPickupStore().getAddress(),
                order.getComment(),
                order.getPaymentMethod(),
                order.getTotalAmount(),
                order.getOrderDetails().stream()
                        .map(orderDetail -> new ProductDto(
                                orderDetail.getProduct().getId(),
                                orderDetail.getProduct().getName(),
                                orderDetail.getProduct().getImageName(),
                                orderDetail.getQuantity(),
                                orderDetail.getUnitPrice()
                        )).toList()
        );
    }
}
