package ru.sweetshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweetshop.model.Store;

public interface StoreRepository extends JpaRepository<Store, Long> {}
