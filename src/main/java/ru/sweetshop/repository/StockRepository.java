package ru.sweetshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweetshop.model.Stock;

public interface StockRepository extends JpaRepository<Stock, Long> {}
