-- Создание пользователя
CREATE ROLE read_only_user WITH LOGIN PASSWORD '12345';
-- Предоставление прав на подключение к базе данных
GRANT CONNECT ON DATABASE sweetshop TO read_only_user;
-- Предоставление прав на чтение всех таблиц в схеме (обычно public)
GRANT USAGE ON SCHEMA public TO read_only_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_only_user;
-- (Опционально) Чтобы новые таблицы автоматически получали эти права:
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO read_only_user;