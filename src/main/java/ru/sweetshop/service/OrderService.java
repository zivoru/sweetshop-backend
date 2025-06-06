package ru.sweetshop.service;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import ru.sweetshop.model.Order;
import ru.sweetshop.repository.OrderRepository;
import ru.sweetshop.response.OrderDto;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;

    public Page<OrderDto> getOrders(LocalDate from, LocalDate to, String status, String deliveryType, String orderId,
                                    int page, int size, String sortField, String sortOrder) {
        Pageable pageable = PageRequest.of(page, size, Sort.Direction.fromString(sortOrder), sortField);

        Specification<Order> spec = Specification.where(null);

        if (from != null) {
            spec = spec.and((root, query, cb) -> cb.greaterThanOrEqualTo(root.get("orderDate"), from.atStartOfDay()));
        }
        if (to != null) {
            spec = spec.and((root, query, cb) -> cb.lessThanOrEqualTo(root.get("orderDate"), to.atTime(LocalTime.MAX)));
        }
        if (status != null && !status.isEmpty()) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("status"), status));
        }
        if (deliveryType != null && !deliveryType.isEmpty()) {
            spec = spec.and((root, query, cb) -> cb.equal(root.get("deliveryType"), deliveryType));
        }
        if (orderId != null && !orderId.isEmpty()) {
            spec = spec.and((root, query, cb) -> cb.like(cb.lower(cb.toString(root.get("id"))), "%" + orderId.toLowerCase() + "%"));
        }

        return orderRepository.findAll(spec, pageable).map(OrderDto::of);
    }

    private List<Sort.Order> parseSort(String[] sortParams) {
        return Arrays.stream(sortParams)
                .map(s -> {
                    String[] parts = s.split(",");
                    return new Sort.Order(
                            parts.length > 1 && parts[1].equalsIgnoreCase("desc") ? Sort.Direction.DESC : Sort.Direction.ASC,
                            parts[0]
                    );
                })
                .collect(Collectors.toList());
    }

}
