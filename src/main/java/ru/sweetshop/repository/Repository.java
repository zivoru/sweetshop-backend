package ru.sweetshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweetshop.model.*;

interface SaleDetailRepository extends JpaRepository<SaleDetail, Long> {}
