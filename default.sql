
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
    password    VARCHAR(20),
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

--------------------------------------------------------------------------


--------------------------------------------------------------------------

INSERT INTO categories (name) VALUES
                                  ('Эклеры'),
                                  ('Пирожные'),
                                  ('Торты'),
                                  ('Макарон'),
                                  ('Подарочные наборы');

INSERT INTO products (category_id, name, description, price, weight_grams, image_name) VALUES
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Торты' LIMIT 1), 'Наполеон', 'Классический торт с нежным кремом', 1250.00, 800, 'product1.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Эклеры' LIMIT 1), 'Эклер ванильный', 'Воздушный эклер с ванильным кремом', 120.00, 85, 'product2.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Пирожные' LIMIT 1), 'Красный бархат', 'Нежное пирожное с крем-чизом', 180.00, 120, 'product3.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Макарон' LIMIT 1), 'Макарон фисташковый', 'Хрустящее печенье с фисташковой начинкой', 95.00, 40, 'product4.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Подарочные наборы' LIMIT 1), 'Набор "Сладкоежка"', 'Ассорти из лучших десертов', 2500.00, 1500, 'product5.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Торты' LIMIT 1), 'Медовик', 'Торт с медовыми коржами и сметанным кремом', 1400.00, 900, 'product1.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Эклеры' LIMIT 1), 'Эклер шоколадный', 'Шоколадный эклер с пралине', 135.00, 90, 'product2.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Пирожные' LIMIT 1), 'Чизкейк Нью-Йорк', 'Классический чизкейк на песочной основе', 220.00, 150, 'product3.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Макарон' LIMIT 1), 'Макарон клубничный', 'Нежное печенье с клубничной начинкой', 85.00, 35, 'product4.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Торты' LIMIT 1), 'Муравейник', 'Торт с хрустящими коржами и сгущенкой', 1100.00, 750, 'product5.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Эклеры' LIMIT 1), 'Эклер кофейный', 'Эклер с кофейным кремом', 130.00, 80, 'product1.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Пирожные' LIMIT 1), 'Тирамису', 'Итальянский десерт с кофейным вкусом', 200.00, 130, 'product2.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Макарон' LIMIT 1), 'Макарон ванильный', 'Классическое французское печенье', 90.00, 38, 'product3.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Подарочные наборы' LIMIT 1), 'Набор "Гурман"', 'Эксклюзивные десерты ручной работы', 3200.00, 1800, 'product4.jpeg'),
                                                                                           ((SELECT category_id FROM categories WHERE name = 'Торты' LIMIT 1), 'Прага', 'Шоколадный торт по старинному рецепту', 1600.00, 950, 'product5.jpeg');

INSERT INTO employees (first_name, last_name, position, phone, hire_date, login, password, store_id, role)
VALUES ('Владимир', 'Зимин', 'Администратор', '+7 (919) 713-51-38', '2025-05-23', 'admin', 'admin', null, 'ADMIN');

INSERT INTO stores (name, description, address, working_hours, image_name_1, image_name_2)
VALUES ('ASTRA', 'Булки, кофе и десерты в самом центре города. Уютное небольшое пространство с приветливыми бариста и всегда свежими булками и десертами.', 'Тополевый переулок, 5', 'Ежедневно 08:30 – 21:00', 'astra1.jpeg', 'astra2.jpeg'),
       ('BISTRO', 'Кухня в стиле comfort food, просто и понятно, из знакомых ингредиентов в современном исполнении, в содержании - детские воспоминания, вкусовой опыт из путешествий и личных предпочтений всех членов команды. Дебют на кухне нашего шеф-кондитера Лены Ажгихиной.', 'Толмачева, 32', 'Ежедневно 9:00 – 22:00', 'bistro1.jpeg', 'bistro2.jpeg'),
       ('CGK', 'Наш новый проект–остров в холле Центра Городской Культуры. Пространство, наполненное воздухом, запахом кофе, книг и искусства.', 'Пушкина, 15', 'Ежедневно 9:00 – 21:00', 'cgk1.jpeg', 'cgk2.jpeg');


-------------------------------------------------------------------

-- Заказ 1
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (3, 'CREATED', 'DELIVERY', 'ул. Центральная, д.15', '2025-06-05', NULL, 'Позвонить перед доставкой', 'CARD_ON_DELIVERY', 235.97);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (1, 5, 2, 45.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (1, 12, 1, 32.50);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (1, 7, 3, 23.00);

-- Заказ 2
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (1, 'IN_PROGRESS', 'PICKUP', NULL, NULL, 2, NULL, 'ONLINE_CREDIT_CARD', 78.99);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (2, 3, 1, 78.99);

-- Заказ 3
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (5, 'READY_FOR_PICKUP', 'PICKUP', NULL, NULL, 1, 'Упаковать в подарочную упаковку', 'CASH_ON_DELIVERY', 215.47);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (3, 9, 2, 65.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (3, 14, 1, 83.49);

-- Заказ 4
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (2, 'OUT_FOR_DELIVERY', 'DELIVERY', 'пр. Ленина, д.42, кв.13', '2025-06-03', NULL, NULL, 'CARD_ON_DELIVERY', 342.96);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (4, 1, 4, 25.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (4, 6, 2, 89.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (4, 11, 1, 56.00);

-- Заказ 5
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (7, 'COMPLETED', 'DELIVERY', 'ул. Садовая, д.7', '2025-05-30', NULL, 'Доставка до подъезда', 'CASH_ON_DELIVERY', 154.98);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (5, 8, 3, 51.66);

-- Заказ 6
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (4, 'CREATED', 'PICKUP', NULL, NULL, 3, 'Заберу после 18:00', 'ONLINE_CREDIT_CARD', 203.97);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (6, 2, 1, 89.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (6, 10, 2, 56.99);

-- Заказ 7
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (6, 'IN_PROGRESS', 'DELIVERY', 'ул. Мира, д.33, кв.12', '2025-06-07', NULL, NULL, 'CARD_ON_DELIVERY', 128.49);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (7, 15, 1, 128.49);

-- Заказ 8
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (3, 'READY_FOR_PICKUP', 'PICKUP', NULL, NULL, 2, NULL, 'ONLINE_CREDIT_CARD', 276.96);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (8, 4, 3, 45.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (8, 13, 2, 67.50);

-- Заказ 9
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (1, 'OUT_FOR_DELIVERY', 'DELIVERY', 'ул. Новая, д.5', '2025-06-04', NULL, 'Код домофона 1458', 'CASH_ON_DELIVERY', 189.97);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (9, 7, 1, 23.00);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (9, 9, 2, 65.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (9, 12, 1, 32.50);

-- Заказ 10
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (5, 'COMPLETED', 'PICKUP', NULL, NULL, 1, NULL, 'ONLINE_CREDIT_CARD', 345.98);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (10, 6, 1, 89.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (10, 11, 3, 56.00);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (10, 14, 1, 83.49);

-- Заказ 11
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (2, 'CREATED', 'DELIVERY', 'ул. Лесная, д.22', '2025-06-08', NULL, NULL, 'CARD_ON_DELIVERY', 102.99);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (11, 3, 1, 78.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (11, 5, 1, 45.99);

-- Заказ 12
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (4, 'IN_PROGRESS', 'PICKUP', NULL, NULL, 3, NULL, 'CASH_ON_DELIVERY', 179.98);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (12, 10, 2, 56.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (12, 15, 1, 128.49);

-- Заказ 13
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (7, 'READY_FOR_PICKUP', 'PICKUP', NULL, NULL, 1, 'Подарочная карта внутри', 'ONLINE_CREDIT_CARD', 233.97);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (13, 1, 3, 25.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (13, 8, 2, 51.66);

-- Заказ 14
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (6, 'OUT_FOR_DELIVERY', 'DELIVERY', 'ул. Парковая, д.17, кв.4', '2025-06-06', NULL, NULL, 'CARD_ON_DELIVERY', 311.95);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (14, 2, 1, 89.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (14, 4, 2, 45.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (14, 7, 3, 23.00);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (14, 13, 1, 67.50);

-- Заказ 15
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (3, 'COMPLETED', 'DELIVERY', 'пр. Победы, д.88', '2025-05-28', NULL, 'Оставить у консьержа', 'CASH_ON_DELIVERY', 167.98);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (15, 12, 2, 32.50);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (15, 14, 1, 83.49);

-- Заказ 16
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (1, 'CREATED', 'PICKUP', NULL, NULL, 2, NULL, 'ONLINE_CREDIT_CARD', 89.99);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (16, 2, 1, 89.99);

-- Заказ 17
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (5, 'IN_PROGRESS', 'DELIVERY', 'ул. Школьная, д.13', '2025-06-09', NULL, 'После 19:00', 'CARD_ON_DELIVERY', 211.96);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (17, 4, 1, 45.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (17, 6, 1, 89.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (17, 9, 1, 65.99);

-- Заказ 18
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (2, 'READY_FOR_PICKUP', 'PICKUP', NULL, NULL, 3, 'Заберу в обед', 'CASH_ON_DELIVERY', 156.00);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (18, 11, 2, 56.00);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (18, 5, 1, 45.99);

-- Заказ 19
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (4, 'OUT_FOR_DELIVERY', 'DELIVERY', 'ул. Речная, д.9, кв.7', '2025-06-05', NULL, NULL, 'CARD_ON_DELIVERY', 103.98);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (19, 1, 2, 25.99);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (19, 3, 1, 78.99);

-- Заказ 20
INSERT INTO orders (customer_id, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (7, 'COMPLETED', 'PICKUP', NULL, NULL, 1, NULL, 'ONLINE_CREDIT_CARD', 279.96);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (20, 8, 4, 51.66);
INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES (20, 10, 1, 56.99);


