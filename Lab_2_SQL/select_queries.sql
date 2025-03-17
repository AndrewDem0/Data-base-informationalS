-- Вибірка всіх записів із таблиць  
SELECT * FROM Books;  -- Виводить усі книги  
SELECT * FROM Fines;  -- Виводить усі штрафи  
SELECT * FROM Borrowings;  -- Виводить усі записи про позики  

-- Вибірка даних із певними умовами  
SELECT * FROM Borrowings WHERE return_date IS NULL;  -- Виводить лише книги, які ще не повернули  
SELECT * FROM Books WHERE genre = 'Comedy';  -- Виводить усі книги жанру "Comedy"  

-- Сортування результатів  
SELECT * FROM Users ORDER BY full_name ASC;  -- Виводить список користувачів у алфавітному порядку  

-- Групування даних  
SELECT genre, COUNT(*) FROM Books GROUP BY genre;  -- Підрахунок кількості книг у кожному жанрі  
SELECT status, COUNT(*) FROM Fines GROUP BY status HAVING COUNT(*) > 5;  -- Виводить тільки ті штрафи, яких більше ніж 5  

-- Об'єднання таблиць (JOIN)  
SELECT u.full_name, b.title AS book_title, borrow.borrow_date  
FROM Borrowings AS borrow  
JOIN Users AS u ON borrow.user_id = u.id  
JOIN Books AS b ON borrow.book_id = b.id;  
-- Виводить список користувачів, книг, які вони взяли, та дату позики  

-- Агрегатні функції  
SELECT COUNT(*) FROM Users;  -- Підраховує загальну кількість користувачів  
SELECT AVG(amount) FROM Fines WHERE status = 'Unpaid';  -- Обчислює середню суму неоплачених штрафів  
SELECT SUM(amount) FROM Fines;  -- Підраховує загальну суму всіх штрафів  

-- Вибір унікальних значень  
SELECT DISTINCT genre FROM Books;  -- Виводить список унікальних жанрів книг  

-- Пошук мінімальних та максимальних значень  
SELECT MAX(published_year) AS newest, MIN(published_year) AS oldest FROM Books;  
-- Визначає найновішу та найстарішу книгу у бібліотеці  

-- Підрахунок штрафів для користувачів  
SELECT Users.full_name, COUNT(Fines.id) AS unpaid_f  
FROM Fines  
JOIN Users ON Fines.user_id = Users.id  
WHERE Fines.status = 'Unpaid'  
GROUP BY Users.full_name  
ORDER BY unpaid_f DESC  
LIMIT 10;  
-- Виводить 10 користувачів із найбільшою кількістю неоплачених штрафів  

-- Пошук прострочених повернень  
SELECT Users.full_name, Books.title, Borrowings.return_date  
FROM Borrowings  
JOIN Users ON Borrowings.user_id = Users.id  
JOIN Books ON Borrowings.book_id = Books.id  
WHERE Borrowings.return_date < NOW();  
-- Виводить список книг, які були повернені із запізненням  

-- Загальна сума штрафів  
SELECT SUM(amount) FROM Fines;  -- Підраховує загальну суму всіх штрафів у бібліотеці  
