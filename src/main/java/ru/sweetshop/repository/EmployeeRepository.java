package ru.sweetshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.sweetshop.model.Employee;

import java.util.Optional;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    Optional<Employee> findByLoginAndPassword(String login, String password);
}
