/*
    HW5用到的所有sql代码
*/
CREATE DATABASE IF NOT EXISTS HW5_DB;   -- 创建数据库
USE HW5_DB; -- 使用数据库

-- 删除原来建好的表
DROP TABLE IF EXISTS score;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS user;

CREATE TABLE IF NOT EXISTS user(    -- 创建表
    id INT AUTO_INCREMENT PRIMARY KEY,  -- 设置id 为 自增 主键
    username VARCHAR(50) NOT NULL,  -- name是保留字
    sex ENUM('Male', 'Female') NOT NULL,
    age INT NOT NULL,
    phone VARCHAR(50) NOT NULL
);
INSERT INTO user    -- 插入所有列的数据可以省略列名 (col1, col2, ...)
VALUES 
    (NULL, 'John Doe', 'Male', 25, '123-456-7890'),  -- NULL是用于自增长列的占位符，系统将为id列生成一个唯一的值
    (NULL, 'Jane Smith', 'Female', 31, '987-654-3210'),
    (NULL, 'Bob Johnson', 'Male', 22, '555-123-4567');
SELECT * FROM user; -- 查询表中所有数据
SELECT username FROM user WHERE age >= 20 and age <= 30; -- 查询年龄在20到30之间的用户
INSERT INTO user
VALUES 
    (NULL, '李佳亮', 'Male', 19, '100-111-0101'),
    (NULL, '李四', 'Female', 17, '114-000-1000'),
    (NULL, '李五', 'Male', 22, '167-8900-1200'),
    (NULL, '李六', 'Male', 29, '199-1100-1100'),
    (NULL, '李七', 'Female', 29, '199-1200-1300');
SELECT * FROM user;
SELECT username FROM user WHERE age >= 20 AND age <= 30 AND  username LIKE '%李%' ORDER BY age DESC;
-- 查询年龄在20到30之间且名字含有“李”的用户
SELECT avg(age) FROM user;
CREATE TABLE IF NOT EXISTS team(
    id INT AUTO_INCREMENT PRIMARY KEY,
    teamName VARCHAR(50) NOT NULL
);
INSERT INTO team
VALUES 
    (NULL, 'THU'),
    (NULL, 'ECNU'),
    (NULL, 'SDU');
CREATE TABLE IF NOT EXISTS score(
    id INT AUTO_INCREMENT PRIMARY KEY,
    teamid INT NOT NULL,
    userid INT NOT NULL,
    score INT NOT NULL,
    FOREIGN KEY (userid) REFERENCES user(id),   -- 外键
    FOREIGN KEY (teamid) REFERENCES team(id)
);
INSERT INTO score
VALUES 
    (NULL, 1, 1, 70),
    (NULL, 1, 2, 80),
    (NULL, 1, 3, 60),
    (NULL, 2, 4, 100),
    (NULL, 2, 5, 90),
    (NULL, 2, 6, 90),
    (NULL, 3, 7, 80),
    (NULL, 3, 8, 50);
SELECT username
FROM user u
JOIN score s ON u.id = s.userid
JOIN team t ON s.teamid = t.id
WHERE t.teamName = 'ECNU' AND u.age < 20;

SELECT t.teamName, SUM(COALESCE(s.score, 0)) AS totalScore
FROM team t
JOIN score s ON t.id = s.teamid
WHERE t.teamName = 'ECNU';
-- COALESCE(s.score, 0): 如果s.score为NULL，则返回0

DROP TABLE score;
DROP TABLE team;
DROP TABLE user;

-- 删除数据库
-- DROP DATABASE HW5_DB;