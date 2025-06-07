package ru.sweetshop.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ru.sweetshop.model.*;
import ru.sweetshop.repository.*;
import ru.sweetshop.request.CategoryRequest;
import ru.sweetshop.request.LoginRequest;
import ru.sweetshop.request.NewStatus;
import ru.sweetshop.request.PutProductRequest;
import ru.sweetshop.response.*;
import ru.sweetshop.service.OrderService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class AdminController {

    private final EmployeeRepository employeeRepository;
    private final CategoryRepository categoryRepository;
    private final CustomerRepository customerRepository;
    private final OrderService orderService;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final StoreRepository storeRepository;

    @PostMapping("/login")
    public ResponseEntity<Employee> login(@RequestBody LoginRequest loginRequest) {
        if ("admin".equals(loginRequest.username()) && "admin".equals(loginRequest.password())) {
            Optional<Employee> employee = employeeRepository.findByLogin(loginRequest.username());
            return employee.map(ResponseEntity::ok)
                    .orElseGet(() -> ResponseEntity.status(HttpStatusCode.valueOf(403)).build());
        }
        return ResponseEntity.status(HttpStatusCode.valueOf(403)).build();
    }

    @GetMapping("/categories")
    public ResponseEntity<List<CategoryResponse>> categories() {
        List<CategoryResponse> categories = categoryRepository.findAll().stream()
                .map(category -> new CategoryResponse(category.getId(), category.getName(),
                        (long) category.getProducts().size())).toList();
        return ResponseEntity.ok(categories);
    }

    @PutMapping("/categories/{id}")
    public ResponseEntity<?> editCategory(@PathVariable Long id, @RequestBody CategoryRequest request) {
        Optional<Category> optionalCategory = categoryRepository.findById(id);
        if (optionalCategory.isEmpty()) {
            return ResponseEntity.notFound().build();
        } else {
            Category category = optionalCategory.get();
            category.setName(request.name());
            categoryRepository.save(category);
            return ResponseEntity.ok().build();
        }
    }

    @PostMapping("/categories")
    public ResponseEntity<CategoryResponse> addCategory(@RequestBody CategoryRequest request) {
        Optional<Category> optionalCategory = categoryRepository.findByNameIgnoreCase(request.name());
        if (optionalCategory.isPresent()) {
            return ResponseEntity.status(409).build();
        }
        Category category = new Category(null, request.name(), null);
        Category savedCategory = categoryRepository.save(category);
        CategoryResponse response = new CategoryResponse(savedCategory.getId(), savedCategory.getName(), 0L);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/categories/{id}")
    public ResponseEntity<?> deleteCategory(@PathVariable Long id) {
        categoryRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/customers")
    public ResponseEntity<List<CustomerResponse>> customers() {
        List<Customer> all = customerRepository.findAll();
        List<CustomerResponse> customerResponses = all.stream().map(customer -> new CustomerResponse(customer.getId(),
                customer.getName(), customer.getPhone(), customer.getOrders().size())).toList();
        return ResponseEntity.ok(customerResponses);
    }

    @GetMapping("/customers/{id}")
    public ResponseEntity<CustomerFullResponse> customer(@PathVariable Long id) {
        Optional<Customer> customer = customerRepository.findById(id);
        if (customer.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        CustomerFullResponse customerFullResponse = customer.map(c -> new CustomerFullResponse(c.getId(),
                c.getName(), c.getPhone(), c.getAddress(),
                c.getIsGuest(), c.getCreatedAt(),
                c.getOrders().stream().map(order -> new CustomerFullResponse.OrderItem(order.getId(),
                        order.getOrderDate(), order.getStatus(), order.getTotalAmount())).toList())).get();

        return ResponseEntity.ok(customerFullResponse);
    }

    @GetMapping("/orders")
    public ResponseEntity<PageResponse<OrderDto>> orders(
            @RequestParam(required = false) @DateTimeFormat(pattern = "EEE, dd MMM yyyy HH:mm:ss z") LocalDateTime from,
            @RequestParam(required = false) @DateTimeFormat(pattern = "EEE, dd MMM yyyy HH:mm:ss z") LocalDateTime to,
            @RequestParam String status,
            @RequestParam String deliveryType,
            @RequestParam String orderId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "id") String sortField,
            @RequestParam(defaultValue = "desc") String sortOrder
    ) {

        Page<OrderDto> orders = orderService.getOrders(
                from == null ? null : from.toLocalDate(),
                to == null ? null : to.toLocalDate(),
                status, deliveryType, orderId, page, size, sortField, sortOrder);

        return ResponseEntity.ok(new PageResponse<>(
                orders.getContent(),
                orders.getNumber(),
                orders.getSize(),
                orders.getTotalElements(),
                orders.getTotalPages()
        ));
    }

    @GetMapping("/orders/stats")
    public ResponseEntity<String> ordersStats() {
        return ResponseEntity.ok("""
                {
                  "total": 1284,
                  "today": 24,
                  "avg": 1034,
                  "byStatus": {
                    "pending": 67,
                    "paid": 1122,
                    "cancelled": 95
                  }
                }
                """);
    }

    @PutMapping("/orders/{id}/status")
    public ResponseEntity<?> setStatus(@PathVariable Long id, @RequestBody NewStatus request) {
        Optional<Order> byId = orderRepository.findById(id);
        if (byId.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Order order = byId.get();
        order.setStatus(Order.OrderStatus.valueOf(request.newStatus()));
        orderRepository.save(order);
        return ResponseEntity.ok().build();
    }

    @GetMapping(value = "/orders/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<OrderDetailsDto> getOrder(@PathVariable Long id) {
        Optional<Order> byId = orderRepository.findById(id);
        if (byId.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(byId.map(OrderDetailsDto::of).get());
    }

    @GetMapping("/products")
    public ResponseEntity<List<ProductDto>> products() {
        List<Product> all = productRepository.findAll(Sort.by(Sort.Direction.DESC, "id"));
        List<ProductDto> list = all.stream().map(ProductDto::of).toList();
        return ResponseEntity.ok(list);
    }

    @PutMapping("/products/{id}")
    public ResponseEntity<?> putProduct(@PathVariable Long id,
                                        @RequestBody PutProductRequest request) {
        Optional<Product> byId = productRepository.findById(id);
        if (byId.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Product product = byId.get();
        try {
            product.setCategory(categoryRepository.findById(request.categoryId()).get());
        } catch (Throwable _) {
        }
        product.setName(request.name());
        product.setDescription(request.description());
        product.setPrice(request.price());
        product.setWeightGrams(request.weightGrams());
        productRepository.save(product);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/products")
    public ResponseEntity<ProductDto> addProduct(@RequestBody ProductDto productDto) {
        Product product = new Product(null,
                categoryRepository.findById(productDto.categoryId()).orElseThrow(),
                productDto.name(),
                productDto.description(),
                productDto.price(),
                productDto.weightGrams(),
                "empty.jpg"
        );
        Product saved = productRepository.save(product);
        return ResponseEntity.ok(ProductDto.of(saved));
    }

    @DeleteMapping("products/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        Optional<Product> byId = productRepository.findById(id);
        if (byId.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        productRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/stores")
    public ResponseEntity<Store> addStore(@RequestBody Store store) {
        store.setImageName1("empty.jpg");
        store.setImageName2("empty.jpg");
        Store saved = storeRepository.save(store);
        return ResponseEntity.ok(saved);
    }

    @PutMapping("/stores/{id}")
    public ResponseEntity<?> putStore(@PathVariable Long id, @RequestBody Store request) {
        Optional<Store> byId = storeRepository.findById(id);
        if (byId.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        Store store = byId.get();
        store.setName(request.getName());
        store.setDescription(request.getDescription());
        store.setAddress(request.getAddress());
        store.setWorkingHours(request.getWorkingHours());
        storeRepository.save(store);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/stores/{id}")
    public ResponseEntity<?> deleteStore(@PathVariable Long id) {
        Optional<Store> byId = storeRepository.findById(id);
        if (byId.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        storeRepository.delete(byId.get());
        return ResponseEntity.ok().build();
    }
}
