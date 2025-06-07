package ru.sweetshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweetshop.model.Customer;
import ru.sweetshop.model.Order;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Optional<Order> findByOrderIdUuid(UUID orderIdUuid);

    List<Order> findAllByCustomer(Customer customer, Sort sort);

    Page<Order> findAll(Specification<Order> spec, Pageable pageable);
}
