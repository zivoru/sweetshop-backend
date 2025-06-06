package ru.sweetshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweetshop.model.Sale;

public interface SaleRepository extends JpaRepository<Sale, Long> {}
