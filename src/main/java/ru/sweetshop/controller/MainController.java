package ru.sweetshop.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;
import ru.sweetshop.model.*;
import ru.sweetshop.repository.*;
import ru.sweetshop.request.AddOrderRequest;
import ru.sweetshop.request.SaveUser;
import ru.sweetshop.response.AddOrderResponse;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class MainController {

    private final StoreRepository storeRepository;
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final CustomerRepository customerRepository;
    private final SimpMessagingTemplate messagingTemplate;

    @GetMapping("/stores")
    public ResponseEntity<List<Store>> stores() {
        return ResponseEntity.ok(storeRepository.findAll(Sort.by(Sort.Direction.DESC, "id")));
    }

    @GetMapping("/categories")
    public ResponseEntity<List<Category>> categories() {
        return ResponseEntity.ok(categoryRepository.findAll());
    }

    @GetMapping("/products")
    public ResponseEntity<List<Product>> products() {
        return ResponseEntity.ok(productRepository.findAll());
    }

    @GetMapping("/products/{categoryId}")
    public ResponseEntity<List<Product>> productsByCategoryId(@PathVariable Long categoryId) {
        return ResponseEntity.ok(productRepository.findAllByCategory_Id(categoryId));
    }

    @GetMapping("/product/{id}")
    public ResponseEntity<Product> products(@PathVariable Long id) {
        return ResponseEntity.ok(productRepository.findById(id).get());
    }

    @PostMapping("/add-order")
    public ResponseEntity<AddOrderResponse> addOrder(@RequestBody AddOrderRequest addOrderRequest) {
        Customer customer = new Customer(addOrderRequest.userId());
        if (addOrderRequest.userId() == null) {
            Customer newCustomer = new Customer(null, addOrderRequest.name(),
                    addOrderRequest.phone(), addOrderRequest.address(),
                    true, LocalDateTime.now(), null, false, null);
            customer = customerRepository.save(newCustomer);
        }

        UUID uuid = UUID.randomUUID();
        Order.DeliveryType deliveryType = "courier".equals(addOrderRequest.deliveryMethod())
                ? Order.DeliveryType.DELIVERY : Order.DeliveryType.PICKUP;

        Store pickupStore = deliveryType == Order.DeliveryType.PICKUP
                ? storeRepository.findById(Long.parseLong(addOrderRequest.deliveryMethod().substring(7))).orElse(null)
                : null;

        Order order = new Order(null, uuid,
                customer,
                LocalDateTime.now(),
                Order.OrderStatus.CREATED,
                deliveryType,
                addOrderRequest.address(),
                addOrderRequest.date(),
                pickupStore,
                addOrderRequest.comment(),
                Order.PaymentMethod.valueOf(addOrderRequest.paymentMethod()),
                addOrderRequest.totalAmount(),
                null
        );

        Order saved = orderRepository.save(order);

        List<OrderDetail> orderDetails = addOrderRequest.cart().stream()
                .map(cart -> new OrderDetail(null, saved,
                        new Product(cart.id()), cart.quantity(), cart.price()))
                .toList();

        orderDetailRepository.saveAll(orderDetails);

        // отправить уведомление по WebSocket
        messagingTemplate.convertAndSend("/topic/orders", order);

        return ResponseEntity.ok(new AddOrderResponse(uuid.toString()));
    }

    @GetMapping("/order/{orderId}")
    public ResponseEntity<Order> orderByUuidId(@PathVariable String orderId) {
        return ResponseEntity.ok(orderRepository.findByOrderIdUuid(UUID.fromString(orderId)).get());
    }

    @GetMapping(value = "/orders-by-user/{userId}", produces = "application/json")
    public ResponseEntity<List<Order>> ordersByUser(@PathVariable Long userId) {
        Customer customer = customerRepository.findById(userId).get();
        List<Order> orders = orderRepository.findAllByCustomer(customer);
        return ResponseEntity.ok(orders);
    }

    @PostMapping("save-user/{userId}")
    public ResponseEntity<Customer> saveUser(@PathVariable Long userId, @RequestBody SaveUser saveUser) {
        Customer customer = customerRepository.findById(userId).get();
        customer.setName(saveUser.name());
        customer.setPhone(saveUser.phone());
        customer.setAddress(saveUser.address());
        customerRepository.save(customer);
        return ResponseEntity.ok(customer);
    }
}
