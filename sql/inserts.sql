INSERT INTO public.categories (name) VALUES ('Эклеры');
INSERT INTO public.categories (name) VALUES ('Пирожные');
INSERT INTO public.categories (name) VALUES ('Торты');
INSERT INTO public.categories (name) VALUES ('Макарон');

INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Эклеры'), 'Эклер Карамель-фундук', 'Карамельный крем и фундук', 300, 80, 'product1.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Эклеры'), 'Эклер Сникерс', '', 290, 80, 'product2.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Эклеры'), 'Эклер Матча-клубника', 'Взбитый ганаш с матчей и свежая клубника', 300, 80, 'product3.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Эклеры'), 'Эклер Голубика', '', 280, 75, 'product4.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Эклеры'), 'Набор эклеров (4 штуки)', 'Сникерс, Карамель-Фундук, Голубика, Матча-Клубника', 1170, 0, 'product5.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Лимонный кекс с каламанси', 'Лимонный кекс с цедрой, пропитан лимонным сиропом, украшен взбитым ганашем с каламанси и кубиками лимона', 360, 110, 'product6.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Чизкейк с голубикой', 'Наша версия чизкейка: нежный сырный мусс с белым шоколадом, хрустящий крамбл с миндальной мукой, свежая голубика', 400, 100, 'product7.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Красный Бархат', 'Бархатистый бисквит с добавлением какао, прослойка из ароматной клубники, сырный мусс с белым шоколадом', 360, 110, 'product8.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Чёрный лес', 'Современная интерпретация легкий сливочно-сырный мусс с белым шоколадом, много сочной вишни, влажный и насыщенный бисквит Брауни с горьким шоколадом', 360, 110, 'product9.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Тарталетка Соленая карамель-Шоколад-Пекан', 'Песочная шоколадная основа, соленая карамель, ганаш на молочном шоколаде, карамелизированный пекан', 370, 75, 'product10.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Каламанси-чёрная смородина', 'Маковый бисквит, начинка из чёрной смородины, крем с белым шоколадом и пюре каламансии', 360, 110, 'product11.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Брауни с солёной сгущенкой', 'Кекс Брауни, покрытый молочным шоколадом с варёной сгущенкой, розовой солью и фундуком', 370, 100, 'product12.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Медовик', 'Пористые медовые коржи, нежный сметанный крем и свежая голубика', 350, 90, 'product13.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Малина-Маракуйя-Шоколад', 'Шоколадный бисквит, малина, кремю из маракуйи с манго, шоколадный мусс, немного хрустящего слоя с шоколадом и цедрой лайма', 360, 100, 'product14.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Пирожное Сникерс', 'Мусс на молочном шоколаде, влажный и насыщенный бисквит Брауни с горьким шоколадом, мягкая карамель, соленый арахис', 360, 110, 'product15.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Пирожные'), 'Набор пирожных (6 штук)', 'Чизкейк с голубикой, Маракуйя-Малина-Шоколад, Черный лес, Красный бархат, Каламанси-Черная смородина, Сникерс', 2200, 0, 'product16.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Торты'), 'Брауни с шоколадом, орехами и сусальным золотом', 'Наш фирменный шоколадный кекс брауни покрываем молочным шоколадом и украшаем карамелизированные грецкие орехи и пекан', 2300, 750, 'product17.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Торты'), 'Торт Маракуйя-Малина-Шоколад', 'Шоколадный бисквит, малина, кремю из маракуйи с манго, шоколадный мусс, немного ещё хрустящего слоя с шоколадом и цедрой лайма', 2700, 850, 'product18.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Торты'), 'Торт Медовик', 'Пористые медовые коржи, нежный сметанный крем, свежая клубника и макарон', 4000, 1500, 'product19.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Торты'), 'Торт Черный Лес', 'Современная интерпретация еще одного знаменитого торта: легкий сливочно-сырный мусс с белым шоколадом, много сочной вишни, влажный и насыщенный бисквит Брауни с горьким шоколадом', 2700, 1000, 'product20.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Торты'), 'Торт Красный Бархат', 'Французская версия классического американского торта Red Velvet: бархатистый бисквит с добавлением какао, прослойка из ароматной клубники, сырный мусс с белым шоколадом', 2700, 900, 'product21.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Торты'), 'Торт Каламанси-Чёрная смородина', 'Маковый бисквит, начинка из чёрной смородины, крем с белым шоколадом и пюре каламанси', 2700, 850, 'product22.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Макарон'), 'Печенье Шоколадные бриллианты', 'Французская классика: рассыпчатое песочное', 430, 350, 'product23.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Макарон'), 'Безе с ягодами', 'Классическое безе посыпаем сублимированной малиной', 350, 80, 'product24.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Макарон'), 'Солёная карамель в банке', 'Классическая солёная карамель, можно добавить в кашу, к булочке, в десерт дома или просто есть ложками из банки', 550, 200, 'product25.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Макарон'), 'Коробка трюфелей (12 конфет)', 'Ассорти из 3 видов: Малина-Горький шоколад, Карамель, Бергамот-черная смородина', 1800, 180, 'product26.webp');
INSERT INTO public.products (category_id, name, description, price, weight_grams, image_name) VALUES ((SELECT category_id FROM categories WHERE name='Макарон'), 'Барон макарон (9 штук)', 'Ассорти из разных вкусов', 1440, 290, 'product27.webp');

INSERT INTO public.stores (name, description, address, working_hours, image_name_1, image_name_2) VALUES ('ASTRA', 'Булки, кофе и десерты в самом центре города. Уютное небольшое пространство с приветливыми бариста и всегда свежими булками и десертами.', 'Тополевый переулок, 5', 'Ежедневно 08:30 – 21:00', 'astra1.jpeg', 'astra2.jpeg');
INSERT INTO public.stores (name, description, address, working_hours, image_name_1, image_name_2) VALUES ('BISTRO', 'Кухня в стиле comfort food, просто и понятно, из знакомых ингредиентов в современном исполнении, в содержании - детские воспоминания, вкусовой опыт из путешествий и личных предпочтений всех членов команды. Дебют на кухне нашего шеф-кондитера Лены Ажгихиной.', 'Толмачева, 32', 'Ежедневно 9:00 – 22:00', 'bistro1.jpeg', 'bistro2.jpeg');
INSERT INTO public.stores (name, description, address, working_hours, image_name_1, image_name_2) VALUES ('CGK', 'Наш новый проект–остров в холле Центра Городской Культуры. Пространство, наполненное воздухом, запахом кофе, книг и искусства.', 'Пушкина, 15', 'Ежедневно 9:00 – 21:00', 'cgk1.jpeg', 'cgk2.jpeg');

INSERT INTO public.customers (name, phone, address, is_guest, created_at, verification_code, phone_verification) VALUES ('Алексей', '+7 (912) 345-67-89', 'Москва, Ленина 10', false, '2025-06-02 09:15:42.000000', null, true);
INSERT INTO public.customers (name, phone, address, is_guest, created_at, verification_code, phone_verification) VALUES ('Екатерина', '+7 (987) 654-32-10', 'Санкт-Петербург, Невский пр. 25', true, '2025-06-02 14:30:18.000000', '789012', false);
INSERT INTO public.customers (name, phone, address, is_guest, created_at, verification_code, phone_verification) VALUES ('Иван', '+7 (923) 456-78-90', 'Новосибирск, Гоголя 5', false, '2025-06-03 11:22:05.000000', null, true);
INSERT INTO public.customers (name, phone, address, is_guest, created_at, verification_code, phone_verification) VALUES ('Ольга', '+7 (999) 123-45-67', 'Екатеринбург, Мира 15', true, '2025-06-03 16:45:33.000000', '456123', true);
INSERT INTO public.customers (name, phone, address, is_guest, created_at, verification_code, phone_verification) VALUES ('Дмитрий', '+7 (926) 789-01-23', 'Казань, Пушкина 7', false, '2025-06-04 10:10:10.000000', null, false);
INSERT INTO public.customers (name, phone, address, is_guest, created_at, verification_code, phone_verification) VALUES ('Анна', '+7 (915) 678-90-12', 'Сочи, Приморская 42', true, '2025-06-05 13:55:47.000000', '321654', true);
INSERT INTO public.customers (name, phone, address, is_guest, created_at, verification_code, phone_verification) VALUES ('Сергей', '+7 (925) 234-56-78', 'Владивосток, Океанская 3', false, '2025-06-06 18:20:14.000000', null, true);

-- Заказ 1
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (1, '2025-05-24 10:15:30.000000', 'COMPLETED', 'DELIVERY', 'Москва, Ленина 10', '2025-05-25', NULL, NULL, 'ONLINE_CREDIT_CARD', 0);
-- Заказ 2
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (2, '2025-05-24 11:20:45.000000', 'IN_PROGRESS', 'PICKUP', NULL, '2025-05-25', 2, NULL, 'CARD_ON_DELIVERY', 0);
-- Заказ 3
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (3, '2025-05-24 12:30:15.000000', 'OUT_FOR_DELIVERY', 'DELIVERY', 'Новосибирск, Гоголя 5', '2025-05-26', NULL, 'Позвонить за час', 'CASH_ON_DELIVERY', 0);
-- Заказ 4
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (2, '2025-05-24 14:45:00.000000', 'COMPLETED', 'DELIVERY', 'Санкт-Петербург, Невский пр. 25', '2025-05-25', NULL, NULL, 'ONLINE_CREDIT_CARD', 0);
-- Заказ 5
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (4, '2025-05-25 09:10:20.000000', 'READY_FOR_PICKUP', 'PICKUP', NULL, '2025-05-26', 1, 'Упаковать в подарочную бумагу', 'CARD_ON_DELIVERY', 0);
-- Заказ 6
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (6, '2025-05-25 16:30:45.000000', 'COMPLETED', 'DELIVERY', 'ул. Центральная, 1', '2025-05-27', NULL, NULL, 'CASH_ON_DELIVERY', 0);
-- Заказ 7
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (5, '2025-05-26 08:15:10.000000', 'IN_PROGRESS', 'DELIVERY', 'Казань, Пушкина 7', '2025-05-27', NULL, 'Код домофона: 1234', 'ONLINE_CREDIT_CARD', 0);
-- Заказ 8
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (6, '2025-05-26 12:40:30.000000', 'OUT_FOR_DELIVERY', 'DELIVERY', 'Сочи, Приморская 42', '2025-05-27', NULL, NULL, 'CASH_ON_DELIVERY', 0);
-- Заказ 9
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (7, '2025-05-26 18:20:15.000000', 'COMPLETED', 'PICKUP', NULL, '2025-05-28', 3, 'Срочный заказ', 'CARD_ON_DELIVERY', 0);
-- Заказ 10
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (7, '2025-05-27 10:05:40.000000', 'COMPLETED', 'DELIVERY', 'Владивосток, Океанская 3', '2025-05-28', NULL, 'После 18:00', 'ONLINE_CREDIT_CARD', 0);
-- Заказ 11
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (1, '2025-05-27 14:25:50.000000', 'IN_PROGRESS', 'PICKUP', NULL, '2025-05-28', 2, NULL, 'CASH_ON_DELIVERY', 0);
-- Заказ 12
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (5, '2025-05-28 09:30:20.000000', 'READY_FOR_PICKUP', 'PICKUP', NULL, '2025-05-29', 1, 'Нужен чек', 'CARD_ON_DELIVERY', 0);
-- Заказ 13
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (3, '2025-05-28 15:45:10.000000', 'CREATED', 'DELIVERY', 'Новосибирск, Гоголя 5', '2025-05-29', NULL, NULL, 'ONLINE_CREDIT_CARD', 0);
-- Заказ 14
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (4, '2025-05-29 11:10:30.000000', 'CREATED', 'DELIVERY', 'Екатеринбург, Мира 15', '2025-05-30', NULL, 'Курьеру не звонить', 'CASH_ON_DELIVERY', 0);
-- Заказ 15
INSERT INTO public.orders (customer_id, order_date, status, delivery_type, delivery_address, delivery_date, pickup_store_id, comment, payment_method, total_amount)
VALUES (1, '2025-05-29 17:20:45.000000', 'CREATED', 'PICKUP', NULL, '2025-05-31', 3, 'Дополнительные приборы', 'CARD_ON_DELIVERY', 0);

-- Для заказа 1
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (1, 5, 2, (SELECT price FROM public.products WHERE product_id=5));
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (1, 12, 1, (SELECT price FROM public.products WHERE product_id=12));
-- Для заказа 2
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (2, 8, 1, (SELECT price FROM public.products WHERE product_id=8));
-- Для заказа 3
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (3, 3, 3, (SELECT price FROM public.products WHERE product_id=3));
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (3, 15, 1, (SELECT price FROM public.products WHERE product_id=15));
-- Для заказа 4
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (4, 7, 2, (SELECT price FROM public.products WHERE product_id=7));
-- Для заказа 5
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (5, 20, 1, (SELECT price FROM public.products WHERE product_id=20));
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (5, 25, 1, (SELECT price FROM public.products WHERE product_id=25));
-- Для заказа 6
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (6, 10, 4, (SELECT price FROM public.products WHERE product_id=10));
-- Для заказа 7
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (7, 2, 1, (SELECT price FROM public.products WHERE product_id=2));
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (7, 18, 2, (SELECT price FROM public.products WHERE product_id=18));
-- Для заказа 8
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (8, 6, 1, (SELECT price FROM public.products WHERE product_id=6));
-- Для заказа 9
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (9, 9, 3, (SELECT price FROM public.products WHERE product_id=9));
-- Для заказа 10
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (10, 14, 1, (SELECT price FROM public.products WHERE product_id=14));
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (10, 22, 1, (SELECT price FROM public.products WHERE product_id=22));
-- Для заказа 11
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (11, 1, 1, (SELECT price FROM public.products WHERE product_id=1));
-- Для заказа 12
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (12, 17, 2, (SELECT price FROM public.products WHERE product_id=17));
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (12, 26, 1, (SELECT price FROM public.products WHERE product_id=26));
-- Для заказа 13
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (13, 4, 1, (SELECT price FROM public.products WHERE product_id=4));
-- Для заказа 14
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (14, 11, 2, (SELECT price FROM public.products WHERE product_id=11));
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (14, 23, 1, (SELECT price FROM public.products WHERE product_id=23));
-- Для заказа 15
INSERT INTO public.order_details (order_id, product_id, quantity, unit_price) VALUES (15, 27, 1, (SELECT price FROM public.products WHERE product_id=27));

UPDATE public.orders o
SET total_amount = (
    SELECT COALESCE(SUM(od.unit_price * od.quantity), 0)
    FROM public.order_details od
    WHERE od.order_id = o.order_id
)
WHERE o.total_amount = 0;  -- или любое другое условие

INSERT INTO public.employees (first_name, last_name, position, phone, hire_date, login, password, store_id, role) VALUES ('Владимир', 'Зимин', 'Администратор', '+7 (919) 713-51-38', '2025-05-23', 'admin', '$2a$10$KiBCw683LrWAvBWnnkMAROp1h2dJiAUePBrsoGFY9CJWB5LZ.WunW', null, 'ADMIN');
