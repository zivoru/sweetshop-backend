package ru.sweetshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweetshop.model.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {}
