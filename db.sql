-- Amazon service

-- Users
CREATE TABLE IF NOT EXISTS users
(
    id         BIGSERIAL PRIMARY KEY,
    avatar_url VARCHAR(255) NOT NULL,
    username   VARCHAR(255) NOT NULL,
    address_id BIGINT,
    firstname  VARCHAR(255) NOT NULL,
    lastname   VARCHAR(255) NOT NULL,
    email      VARCHAR(355) NOT NULL,
    password   VARCHAR(128) NOT NULL,
    is_seller  BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP             DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (address_id) REFERENCES addresses (id)
);

-- Sessions
CREATE TABLE IF NOT EXISTS sessions
(
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT       NOT NULL,
    token      VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Addresses
CREATE TABLE IF NOT EXISTS addresses
(
    id         BIGSERIAL PRIMARY KEY,
    street     VARCHAR(255) NOT NULL,
    city       VARCHAR(255) NOT NULL,
    state      VARCHAR(255) NOT NULL,
    country    VARCHAR(255) NOT NULL,
    postalcode VARCHAR(255) NOT NULL,
    is_stock   BOOLEAN      NOT NULL DEFAULT FALSE
);

-- Items
CREATE TABLE IF NOT EXISTS items
(
    id          BIGSERIAL PRIMARY KEY,
    user_id     BIGINT         NOT NULL,
    name        VARCHAR(255)   NOT NULL,
    description TEXT           NOT NULL,
    media_urls  VARCHAR(255)[] NOT NULL,
    price       DECIMAL        NOT NULL,
    catalog     VARCHAR(255)   NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Comments
CREATE TABLE IF NOT EXISTS comments
(
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT        NOT NULL,
    item_id    BIGINT        NOT NULL,
    content    VARCHAR(1024) NOT NULL,
    img_url    VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (item_id) REFERENCES items (id)
);

-- Orders
CREATE TABLE IF NOT EXISTS orders
(
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT       NOT NULL,
    item_ids   BIGINT[]     NOT NULL,
    status     VARCHAR(255) NOT NULL,
    stock_id   BIGINT       NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (stock_id) REFERENCES addresses (id),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (item_ids) REFERENCES items (id)
);

-- Payments
CREATE TABLE IF NOT EXISTS payments
(
    id         BIGSERIAL PRIMARY KEY,
    order_id   BIGINT       NOT NULL,
    amount     DECIMAL      NOT NULL,
    status     VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders (id)
);
