CREATE TABLE categories
(
    category_id SERIAL PRIMARY KEY,
    name        VARCHAR(50) UNIQUE NOT NULL
);


CREATE TABLE products
(
    product_id   SERIAL PRIMARY KEY,
    category_id  INT REFERENCES categories (category_id),
    name         VARCHAR(100) UNIQUE NOT NULL,
    description  TEXT,
    price        DECIMAL(10, 2)      NOT NULL,
    weight_grams INT                 NOT NULL,
    image_name   varchar(100) DEFAULT 'empty.jpg'
);

CREATE TABLE customers
(
    customer_id        SERIAL PRIMARY KEY,
    name               VARCHAR(50),
    phone              VARCHAR(20) UNIQUE,
    address            TEXT,
    is_guest           BOOLEAN,
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    verification_code  VARCHAR(10),
    phone_verification BOOLEAN
);

CREATE TABLE stores
(
    store_id      SERIAL PRIMARY KEY,
    name          VARCHAR(50) UNIQUE NOT NULL,
    description   TEXT               NOT NULL,
    address       TEXT               NOT NULL,
    working_hours VARCHAR(50)        NOT NULL,
    image_name_1  VARCHAR(100)       NOT NULL,
    image_name_2  VARCHAR(100)       NOT NULL
);

CREATE TABLE orders
(
    order_id         SERIAL PRIMARY KEY,
    order_id_uuid    UUID        DEFAULT gen_random_uuid(),
    customer_id      INT REFERENCES customers (customer_id),
    order_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status           VARCHAR(20) CHECK ( status IN (
                                                    'CREATED',
                                                    'IN_PROGRESS',
                                                    'READY_FOR_PICKUP',
                                                    'OUT_FOR_DELIVERY',
                                                    'COMPLETED'
        ))                     DEFAULT 'CREATED',
    delivery_type    VARCHAR(20) CHECK ( delivery_type IN ('PICKUP', 'DELIVERY') ),
    delivery_address TEXT,
    delivery_date    DATE,
    pickup_store_id  INT REFERENCES stores (store_id),
    comment          TEXT,
    payment_method   VARCHAR(20) CHECK ( payment_method IN (
                                                            'CASH_ON_DELIVERY',
                                                            'CARD_ON_DELIVERY',
                                                            'ONLINE_CREDIT_CARD'
        ) ),
    total_amount     DECIMAL(10, 2) NOT NULL
);

CREATE TABLE order_details
(
    order_detail_id SERIAL PRIMARY KEY,
    order_id        INT REFERENCES orders (order_id),
    product_id      INT REFERENCES products (product_id),
    quantity        INT            NOT NULL DEFAULT 1,
    unit_price      DECIMAL(10, 2) NOT NULL
);

CREATE TABLE employees
(
    employee_id SERIAL PRIMARY KEY,
    first_name  VARCHAR(50)                                                   NOT NULL,
    last_name   VARCHAR(50)                                                   NOT NULL,
    position    VARCHAR(50)                                                   NOT NULL,
    phone       VARCHAR(20)                                                   NOT NULL UNIQUE,
    hire_date   DATE                                                          NOT NULL,
    login       VARCHAR(20),
    password    TEXT,
    store_id    INT REFERENCES stores (store_id),
    role        VARCHAR(20) CHECK ( role IN ('ADMIN', 'MANAGER', 'CASHIER') ) NOT NULL
);

CREATE TABLE stock
(
    stock_id     SERIAL PRIMARY KEY,
    store_id     INT REFERENCES stores (store_id),
    product_id   INT REFERENCES products (product_id),
    quantity     INT NOT NULL DEFAULT 1,
    last_updated TIMESTAMP
);

CREATE TABLE sales
(
    sale_id        SERIAL PRIMARY KEY,
    store_id       INT REFERENCES stores (store_id),
    employee_id    INT REFERENCES employees (employee_id),
    sale_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount   DECIMAL(10, 2)                                           NOT NULL,
    payment_method VARCHAR(20) CHECK ( payment_method IN ('CASH', 'CARD') ) NOT NULL
);

CREATE TABLE sale_details
(
    sale_detail_id SERIAL PRIMARY KEY,
    sale_id        INT REFERENCES sales (sale_id),
    product_id     INT REFERENCES products (product_id),
    quantity       INT            NOT NULL DEFAULT 1,
    unit_price     DECIMAL(10, 2) NOT NULL
);