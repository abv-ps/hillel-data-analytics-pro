CREATE TABLE country (
    country_id INTEGER PRIMARY KEY,
    country_code VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE device (
    device_id INTEGER PRIMARY KEY,
    device_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE "group" (
    group_id INTEGER PRIMARY KEY,
    group_label VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE "user" (
    user_id INTEGER PRIMARY KEY,
    device_id INTEGER NOT NULL,
    country_id INTEGER NOT NULL,
    group_id INTEGER NOT NULL CHECK (group_id IN (1, 2)),
    days_on_product INTEGER NOT NULL CHECK (days_on_product >= 0),
    CONSTRAINT fk_user_device FOREIGN KEY (device_id) REFERENCES device(device_id),
    CONSTRAINT fk_user_country FOREIGN KEY (country_id) REFERENCES country(country_id),
    CONSTRAINT fk_user_group FOREIGN KEY (group_id) REFERENCES "group"(group_id)
);

CREATE TABLE daily (
    daily_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    date DATE NOT NULL CHECK (date BETWEEN '2025-08-01' AND '2025-08-20'),
    converted INTEGER NOT NULL CHECK (converted IN (0, 1)),
    CONSTRAINT fk_daily_user FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    UNIQUE (user_id, date)
);