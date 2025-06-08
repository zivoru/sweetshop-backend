package ru.sweetshop.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.stereotype.Repository;
import ru.sweetshop.model.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
@RequiredArgsConstructor
public class MainRepository {

    private static final String QUERY_1 = """
            SELECT store_id, name, description, address, working_hours, image_name_1, image_name_2
            FROM stores
            ORDER BY store_id
            """;
    private static final String QUERY_2 = """
            SELECT category_id, name
            FROM categories
            ORDER BY category_id
            """;
    private static final String QUERY_3 = """
            SELECT *
            FROM products
            ORDER BY product_id DESC
            """;
    private static final String QUERY_4 = """
            SELECT *
            FROM products
            WHERE category_id=?
            ORDER BY product_id DESC
            """;
    private static final String QUERY_5 = """
            SELECT *
            FROM products
            WHERE product_id=?
            """;
    private static final String QUERY_6 = """
            SELECT o.order_id, o.order_id_uuid, o.customer_id, o.order_date, o.status,
                   o.delivery_type, o.delivery_address, o.delivery_date,
                   s.store_id, s.name, s.description, s.address, s.working_hours,
                   o.comment, o.payment_method, o.total_amount
            FROM orders o
                LEFT JOIN stores s
                    ON o.pickup_store_id = s.store_id
            WHERE o.order_id_uuid=?
            """;
    private static final String QUERY_7 = """
            SELECT *
            FROM order_details
            WHERE order_id=?
            """;
    private static final String QUERY_8 = """
            SELECT *
            FROM customers
            WHERE phone=?
            """;
    private static final String QUERY_9 = """
            INSERT INTO customers
            (
                 name,
                 phone,
                 address,
                 is_guest,
                 created_at,
                 verification_code,
                 phone_verification
            )
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """;
    private static final String QUERY_10 = """
            SELECT *
            FROM stores
            WHERE store_id=?
            """;
    private static final String QUERY_11 = """
            INSERT INTO orders
            (
                customer_id,
                delivery_type,
                delivery_address,
                delivery_date,
                pickup_store_id,
                comment,
                payment_method,
                total_amount
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
            """;
    private static final String QUERY_12 = """
            INSERT INTO order_details(order_id, product_id, quantity, unit_price)
            VALUES (?, ?, ?, ?)
            """;
    private static final String QUERY_13 = """
            SELECT *
            FROM customers
            WHERE customer_id=?
            """;
    private static final String QUERY_14 = """
            SELECT *
            FROM orders
            WHERE customer_id=?
            ORDER BY order_id DESC
            """;
    private static final String QUERY_15 = """
            SELECT *
            FROM employees
            WHERE login=?
            """;
    private static final String QUERY_16 = """
            SELECT category_id, name
            FROM categories
            WHERE category_id=?
            """;
    private static final String QUERY_17 = """
            INSERT INTO categories(name) VALUES (?)
            """;
    private static final String QUERY_18 = """
            SELECT category_id, name
            FROM categories
            WHERE name ILIKE ?
            """;
    private static final String QUERY_19 = """
            DELETE FROM categories
            WHERE category_id=?
            """;
    private static final String QUERY_20 = """
            SELECT * FROM customers
            """;
    private static final String QUERY_21 = """
            SELECT o.order_id, o.order_id_uuid, o.customer_id, o.order_date, o.status,
                   o.delivery_type, o.delivery_address, o.delivery_date,
                   s.store_id, s.name, s.description, s.address, s.working_hours,
                   o.comment, o.payment_method, o.total_amount
            FROM orders o
                LEFT JOIN stores s
                    ON o.pickup_store_id = s.store_id
            WHERE o.order_id=?
            """;
    private static final String QUERY_22 = """
            INSERT INTO products
            (
                category_id,
                name,
                description,
                price,
                weight_grams,
                image_name
            )
            VALUES (?, ?, ?, ?, ?, ?)
            """;
    private static final String QUERY_23 = """
            DELETE FROM products WHERE product_id=?
            """;
    private static final String QUERY_24 = """
            INSERT INTO stores
            (
                name,
                description,
                address,
                working_hours,
                image_name_1,
                image_name_2
            )
            VALUES (?, ?, ?, ?, ?, ?)
            """;
    private static final String QUERY_25 = """
            SELECT * FROM stores WHERE store_id=?
            """;
    private static final String QUERY_26 = """
            DELETE FROM stores WHERE store_id=?
            """;
    private static final String QUERY_27 = """
            SELECT * FROM orders
            WHERE
              (order_date >= :fromStartOfDay OR :from IS NULL)
              AND (order_date <= :toEndOfDay OR :to IS NULL)
              AND (status = :status OR :status IS NULL OR :status = '')
              AND (delivery_type = :deliveryType OR :deliveryType IS NULL OR :deliveryType = '')
              AND (LOWER(CAST(order_id AS TEXT)) LIKE LOWER(CONCAT('%', :orderId, '%')) OR :orderId IS NULL OR :orderId = '')
            ORDER BY :sortField :sortDirection
            LIMIT :size OFFSET :offset
            """;

    private final JdbcOperations jdbcOperations;

    public List<Store> findAllStores() {
        return jdbcOperations.query(QUERY_1, (rs, _) -> new Store(
                rs.getLong(1),
                rs.getString(2),
                rs.getString(3),
                rs.getString(4),
                rs.getString(5),
                rs.getString(6),
                rs.getString(7)
        ));
    }

    public List<Category> findAllCategories() {
        return jdbcOperations.query(QUERY_2, (rs, _) ->
                new Category(rs.getLong(1), rs.getString(2), null));
    }

    public List<Product> findAllProducts() {
        return jdbcOperations.query(QUERY_3, (rs, _) -> new Product(
                rs.getLong(1),
                null,
                rs.getString(3),
                rs.getString(4),
                rs.getBigDecimal(5),
                rs.getInt(6),
                rs.getString(7)
        ));
    }

    public List<Product> findAllProductsByCategoryId(Long categoryId) {
        return jdbcOperations.query(QUERY_4, (rs, _) -> new Product(
                rs.getLong(1),
                null,
                rs.getString(3),
                rs.getString(4),
                rs.getBigDecimal(5),
                rs.getInt(6),
                rs.getString(7)
        ), categoryId);
    }

    public Optional<Product> findProductById(Long productId) {
        List<Product> products = jdbcOperations.query(QUERY_5, (rs, _) -> new Product(
                rs.getLong(1),
                null,
                rs.getString(3),
                rs.getString(4),
                rs.getBigDecimal(5),
                rs.getInt(6),
                rs.getString(7)
        ), productId);
        return Optional.ofNullable(products.isEmpty() ? null : products.getFirst());
    }

    public Optional<Order> findOrderByUuidId(String uuidId) {
        List<Order> orders = jdbcOperations.query(QUERY_6, (rs, _) -> {
            long orderId = rs.getLong(1);

            List<OrderDetail> orderDetails = getOrderDetails(orderId);

            return new Order(orderId,
                    rs.getObject(2, UUID.class),
                    null,
                    rs.getTimestamp(4) == null ? null : rs.getTimestamp(4).toLocalDateTime(),
                    Order.OrderStatus.valueOf(rs.getString(5)),
                    Order.DeliveryType.valueOf(rs.getString(6)),
                    rs.getString(7),
                    rs.getDate(8) == null ? null : rs.getDate(8).toLocalDate(),
                    rs.getLong(9) == 0 ? null : new Store(
                            rs.getLong(9),
                            rs.getString(10),
                            rs.getString(11),
                            rs.getString(12),
                            rs.getString(13),
                            null, null
                    ),
                    rs.getString(14),
                    Order.PaymentMethod.valueOf(rs.getString(15)),
                    rs.getBigDecimal(16),
                    orderDetails
            );
        }, UUID.fromString(uuidId));
        return Optional.ofNullable(orders.isEmpty() ? null : orders.getFirst());
    }

    private List<OrderDetail> getOrderDetails(long orderId) {
        return jdbcOperations.query(QUERY_7, (rs, _) -> new OrderDetail(
                rs.getLong(1),
                null,
                findProductById(rs.getLong(3)).get(),
                rs.getInt(4),
                rs.getBigDecimal(5)
        ), orderId);
    }

    public Optional<Customer> findCustomerByPhone(String phone) {
        List<Customer> customers = jdbcOperations.query(QUERY_8, (rs, _) -> new Customer(), phone);
        return Optional.ofNullable(customers.isEmpty() ? null : customers.getFirst());
    }

    public void saveCustomer(Customer customer) {
        jdbcOperations.update(QUERY_9, customer.getName(), customer.getPhone(), customer.getAddress(),
                customer.getIsGuest(), customer.getCreatedAt(), customer.getVerificationCode(),
                customer.getPhoneVerified()
        );
    }
}
