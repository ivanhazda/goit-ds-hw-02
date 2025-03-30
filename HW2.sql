-- 1. Отримати всі завдання певного користувача. Використайте SELECT для отримання завдань конкретного користувача за його user_id.
SELECT * FROM  tasks t  WHERE  user_id  =10 ;
-- 2. Вибрати завдання за певним статусом. Використайте підзапит для вибору завдань з конкретним статусом, наприклад, 'new'.
SELECT * FROM tasks t WHERE status_id = (SELECT id FROM	status WHERE name='new' );

--3. Оновити статус конкретного завдання. Змініть статус конкретного завдання на 'in progress' або інший статус.
UPDATE tasks SET status_id = (SELECT id FROM status WHERE name = 'in progress') WHERE id = 3;

--4.Отримати список користувачів, які не мають жодного завдання. Використайте комбінацію SELECT, WHERE NOT IN і підзапит.
SELECT * FROM users WHERE id NOT IN (SELECT DISTINCT user_id FROM tasks);
-- 5.Додати нове завдання для конкретного користувача. Використайте INSERT для додавання нового завдання.

INSERT  INTO tasks (title, description, status_id, user_id) 
    VALUES ('New Task', 'This is a new task', 1, 2);

-- 6.Отримати всі завдання, які ще не завершено. Виберіть завдання, чий статус не є 'завершено'.
SELECT * FROM  tasks t WHERE  status_id != (SELECT id FROM status s  WHERE name = 'completed' );

-- 7. Видалити конкретне завдання. Використайте DELETE для видалення завдання за його id.
DELETE FROM  tasks  WHERE id = 6;

-- 8.Знайти користувачів з певною електронною поштою. Використайте SELECT із умовою LIKE для фільтрації за електронною поштою.
SELECT * FROM users u  WHERE email ="timothy38@example.net";

--9.Оновити ім'я користувача. Змініть ім'я користувача за допомогою UPDATE.
UPDATE users SET fullname = 'Updated Name' WHERE id = 6;

--10.Отримати кількість завдань для кожного статусу. Використайте SELECT, COUNT, GROUP BY для групування завдань за статусами.

SELECT  b.name,COUNT(status_id)  
FROM tasks a
LEFT JOIN status b ON b.id =a.status_id 
GROUP BY b.name ;

--11.Отримати завдання, які призначені користувачам з певною доменною частиною електронної пошти. 
--  Використайте SELECT з умовою LIKE в поєднанні з JOIN, щоб вибрати завдання, призначені користувачам, 
--  чия електронна пошта містить певний домен (наприклад, '%@example.com').
SELECT a.* FROM tasks a 
LEFT JOIN users b ON b.id = a.user_id 
WHERE b.email LIKE "%@example.com";

--12.Отримати список завдань, що не мають опису. Виберіть завдання, у яких відсутній опис.
SELECT * FROM tasks t WHERE  description IS NULL  OR description ='';

--13.Вибрати користувачів та їхні завдання, які є у статусі 'in progress'. 
-- Використайте INNER JOIN для отримання списку користувачів та їхніх завдань із певним статусом.
SELECT users.fullname, tasks.title 
  FROM users 
  INNER JOIN tasks ON users.id = tasks.user_id 
  WHERE tasks.status_id = (SELECT id FROM status WHERE name = 'in progress');

--14.Отримати користувачів та кількість їхніх завдань. 
--Використайте LEFT JOIN та GROUP BY для вибору користувачів та підрахунку їхніх завдань.
 SELECT a.fullname, COUNT(b.title) FROM users a
 LEFT JOIN tasks b ON b.user_id = a.id 
 GROUP BY a.id ;















SELECT *
FROM status;
