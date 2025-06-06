package ru.sweetshop.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "customers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "customer_id")
    private Long id;

    @Column(name = "name", length = 50)
    private String name;

    @Column(name = "phone", unique = true, length = 20)
    private String phone;

    @Column(name = "address")
    private String address;

    @Column(name = "is_guest")
    private Boolean isGuest;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private LocalDateTime createdAt;

    @Column(name = "verification_code")
    private String verificationCode;

    @Column(name = "phone_verification")
    private Boolean phoneVerified;

    @OneToMany(mappedBy = "customer")
    @JsonIgnore
    private List<Order> orders;

    public Customer(Long id) {
        this.id = id;
    }

    public Customer(String phone) {
        this.phone = phone;
    }
}
