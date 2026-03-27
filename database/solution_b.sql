-- 1. Liệt kê hóa đơn của khách hàng
SELECT u.user_id, u.user_name, o.order_id
FROM users u
JOIN orders o ON u.user_id = o.user_id;

-- 2. Số lượng hóa đơn của khách hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;

-- 3. Thông tin hóa đơn: mã đơn + số sản phẩm
SELECT o.order_id, COUNT(od.product_id) AS total_products
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

-- 4. Thông tin mua hàng
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;

-- 5. 7 user có nhiều đơn hàng nhất
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY total_orders DESC
LIMIT 7;

-- 6. 7 user mua Samsung hoặc Apple
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%'
OR p.product_name LIKE '%Apple%'
LIMIT 7;

-- 7. Tổng tiền mỗi đơn
SELECT u.user_id, u.user_name, o.order_id,
SUM(p.product_price) AS total_money
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;

-- 8. Đơn có tổng tiền lớn nhất của mỗi user
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
    SUM(p.product_price) AS total_money
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE total_money = (
    SELECT MAX(total)
    FROM (
        SELECT SUM(p2.product_price) AS total
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        WHERE o2.user_id = t.user_id
        GROUP BY o2.order_id
    ) x
);

-- 9. Đơn có tổng tiền nhỏ nhất mỗi user
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
    SUM(p.product_price) AS total_money,
    COUNT(p.product_id) AS total_products
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE total_money = (
    SELECT MIN(total)
    FROM (
        SELECT SUM(p2.product_price) AS total
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        WHERE o2.user_id = t.user_id
        GROUP BY o2.order_id
    ) x
);

-- 10. Đơn có nhiều sản phẩm nhất mỗi user
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
    SUM(p.product_price) AS total_money,
    COUNT(p.product_id) AS total_products
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE total_products = (
    SELECT MAX(tp)
    FROM (
        SELECT COUNT(p2.product_id) AS tp
        FROM orders o2
        JOIN order_details od2 ON o2.order_id = od2.order_id
        JOIN products p2 ON od2.product_id = p2.product_id
        WHERE o2.user_id = t.user_id
        GROUP BY o2.order_id
    ) x
);