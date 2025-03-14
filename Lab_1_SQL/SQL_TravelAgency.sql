-- 1. Вставка даних у Clients (клієнти)
INSERT INTO public."Clients" (full_name, email, phone) 
VALUES 
    ('John Doe', 'john.doe@example.com', '123456789'),
    ('Alice Smith', 'alice.smith@example.com', '987654321');

-- 2. Вставка даних у Tours (тури)
INSERT INTO public."Tours" (name, country, duration) 
VALUES 
    ('Paris Getaway', 'France', 5),
    ('Swiss Alps Adventure', 'Switzerland', 7);

-- 3. Вставка даних у Bookings (бронювання)
INSERT INTO public."Bookings" (client_id, tour_id, booking_date, people_num) 
VALUES 
    (6, 5, '2025-04-10', 2),
    (7, 6, '2025-05-15', 1);

-- 4. Вибірка всіх бронювань з деталями клієнтів і турів
SELECT b.id, c.full_name, t.tour_name AS tour_name, b.booking_date, b.people_num
FROM public."Bookings" b
JOIN public."Clients" c ON b.client_id = c.id
JOIN public."Tours" t ON b.tour_id = t.id;

-- 5. Оновлення даних (змінимо email у клієнта "John Doe")
UPDATE public."Clients" 
SET email = 'john.updated@example.com' 
WHERE full_name = 'John Doe';

-- 6. Видалення бронювання (видаляємо бронювання клієнта Alice Smith)
DELETE FROM public."Bookings" 
WHERE client_id = (SELECT id FROM public."Clients" WHERE full_name = 'Alice Smith');

-- 7. Перевіряємо зміни (вибірка всіх клієнтів і бронювань після змін)
SELECT * FROM public."Clients";
SELECT * FROM public."Bookings";