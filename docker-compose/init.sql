CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255),
    amount INT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO orders (customer_name, amount, status)
VALUES
('Alice', 120, 'NEW'),
('Bob', 75, 'PAID'),
('Charlie', 200, 'SHIPPED');