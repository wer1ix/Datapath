-- Usaré como ejemplo la empresa de compra y venta de 
-- inmuebles Zillow


CREATE DATABASE zillow_db;
USE zillow_db;

-- Tabla de usuarios
CREATE TABLE users (
    user_id INT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Tabla de propiedades
CREATE TABLE properties (
    property_id INT,
    title VARCHAR(255),
    description TEXT,
    price DECIMAL(12,2),
    status ENUM('disponible', 'vendida') DEFAULT 'disponible',
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES users(user_id)
);

-- Tabla de transacciones (ventas)
CREATE TABLE transactions (
    transaction_id INT,
    property_id INT,
    buyer_id INT,
    sale_price DECIMAL(12,2),
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (buyer_id) REFERENCES users(user_id)
);


