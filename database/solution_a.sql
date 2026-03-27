-- 1. Danh sách user theo Alphabet
SELECT * 
FROM users
ORDER BY user_name ASC;

-- 2. Lấy 7 user theo Alphabet
SELECT * 
FROM users
ORDER BY user_name ASC
LIMIT 7;

-- 3. User có chữ a trong tên
SELECT * 
FROM users
WHERE user_name LIKE '%a%'
ORDER BY user_name ASC;

-- 4. Tên bắt đầu bằng m
SELECT * 
FROM users
WHERE user_name LIKE 'm%';

-- 5. Tên kết thúc bằng i
SELECT * 
FROM users
WHERE user_name LIKE '%i';

-- 6. Email Gmail
SELECT *
FROM users
WHERE user_email LIKE '%@gmail.com';

-- 7. Gmail và tên bắt đầu m
SELECT *
FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE 'm%';

-- 8. Gmail + tên có i + độ dài >5
SELECT *
FROM users
WHERE user_email LIKE '%@gmail.com'
AND user_name LIKE '%i%'
AND LENGTH(user_name) > 5;

-- 9. Tên có a, dài 5-9, Gmail, trong email có chữ i
SELECT *
FROM users
WHERE user_name LIKE '%a%'
AND LENGTH(user_name) BETWEEN 5 AND 9
AND user_email LIKE '%@gmail.com'
AND user_email LIKE '%i%';

-- 10. Điều kiện OR
SELECT *
FROM users
WHERE (user_name LIKE '%a%' AND LENGTH(user_name) BETWEEN 5 AND 9)
OR (user_name LIKE '%i%' AND LENGTH(user_name) < 9)
OR (user_email LIKE '%@gmail.com' AND user_email LIKE '%i%');